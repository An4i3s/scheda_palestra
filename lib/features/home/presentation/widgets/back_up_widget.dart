

//TODO EXPORT + FARE LA UI
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/back_up_service/back_up_service.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_bloc.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_events.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_events.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_bloc.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_bloc.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_event.dart';
import 'package:share_plus/share_plus.dart';

class BackupWidget extends StatefulWidget {
  const BackupWidget({super.key});

  @override
  State<BackupWidget> createState() => _BackupWidgetState();
}

class _BackupWidgetState extends State<BackupWidget> {
  bool _isLoading = false;

  void _showSnackBar(String message, {required bool isError}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

 Future<void> _exportBackup() async {
  setState(() => _isLoading=true,);
  try{
        final file = await BackupService.exportBackup();
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'Backup dei tuoi dati - Scheda Palestra',
        ),
      );
       _showSnackBar(isError: false, 'Backup esportato con successo');
  }catch(e){
    _showSnackBar(isError: true, "Error durante l'export $e");
  }finally{
    if (mounted) setState(() => _isLoading = false);
  }


}

Future<void> _handleImport() async {
  final confirmed = await _showConfirmDialog();
  if (!confirmed) return;

  setState(() => _isLoading = true);
  try {
    final pickedFile = await FilePicker.pickFile();

    if (pickedFile == null || pickedFile.path == null) {
      setState(() => _isLoading = false);
      return; // utente ha annullato
    }

    final file = File(pickedFile.path!);
    await BackupService.importBackup(file);
     if (mounted) {
      _refreshAllBlocs(context);
      _showSnackBar('Backup importato con successo', isError: false);
    }

  } catch (e) {
    _showSnackBar('Errore durante l\'import: $e', isError: true);
  } finally {
    if (mounted) setState(() => _isLoading = false);
  }
}

void _refreshAllBlocs(BuildContext context) {
  context.read<HomeBloc>().add(const HomeStarted());
  context.read<SchedeBloc>().add(const SchedeStarted()); 
  context.read<WorkoutLogBloc>().add(const WorkoutLogOnLoad());
  context.read<WorkoutBloc>().add(const WourtkoutLoaded());
  // aggiungi qui gli altri bloc se servono, es. WorkoutBloc se ha uno stato globale da ricaricare
}

    Future<bool> _showConfirmDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Importa backup'),
        content: const Text(
          'Questa operazione sovrascriverà tutti i dati attuali con quelli del backup. '
          'L\'azione non è reversibile. Vuoi continuare?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annulla'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sovrascrivi'),
          ),
        ],
      ),
    );
    return result ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Backup"),
        Row(
          spacing: 8,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _isLoading ? null : _handleImport,
                child: Text("Import backup"),
              ),
            ),
            Expanded(
              child: OutlinedButton(
                onPressed: _isLoading ? null : _exportBackup,
                child: Text("Export backup"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
