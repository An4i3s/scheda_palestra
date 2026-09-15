import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/back_up_service/back_up_service.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_bloc.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_events.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_events.dart';
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
  bool _isLoadingImport = false;
  bool _isLoadingExport = false;

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
    setState(() => _isLoadingExport = true);
    try {
      final file = await BackupService.exportBackup();
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'Backup dei tuoi dati - Scheda Palestra',
        ),
      );
     if(mounted) _showSnackBar(isError: false, context.i18n.exportSuccess);
    } catch (e) {
      _showSnackBar(isError: true, context.i18n.exportError(e.toString()));
    } finally {
      if (mounted) setState(() => _isLoadingExport = false);
    }
  }

  Future<void> _handleImport() async {
    final confirmed = await _showConfirmDialog();
    if (!confirmed) return;

    setState(() => _isLoadingImport = true);
    try {
      final pickedFile = await FilePicker.pickFile();

      if (pickedFile == null || pickedFile.path == null) {
        setState(() => _isLoadingImport = false);
        return; // utente ha annullato
      }

      final file = File(pickedFile.path!);
      await BackupService.importBackup(file);
      if (mounted) {
        _refreshAllBlocs(context);
        _showSnackBar(context.i18n.importSuccess, isError: false);
      }
    } catch (e) {
      _showSnackBar(context.i18n.importError(e.toString()), isError: true);
    } finally {
      if (mounted) setState(() => _isLoadingImport = false);
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
        title:  Text(context.i18n.importConfirmTitle),
        content:  Text(
          context.i18n.importConfirmMessage
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child:  Text(context.i18n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child:  Text(context.i18n.overwrite),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  final _btnStyle = OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
            side: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
              style: BorderStyle.solid,
            ),
            foregroundColor: AppColors.primaryColor,
            minimumSize: Size(double.infinity, 32),
            padding: EdgeInsets.all(12),
          );
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Row(
          spacing: 8,
          children: [
            Icon(Icons.arrow_circle_down_outlined, color: Colors.blueGrey),
            Text(
              "Backup",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: 4,),
        OutlinedButton(
          style: _btnStyle,
          onPressed: _isLoadingImport ? null : _handleImport,
          child: _isLoadingImport
              ? CircularProgressIndicator(color: AppColors.primaryColor)
              : Text(context.i18n.importBackup),
        ),
        OutlinedButton(
          style: _btnStyle,
          onPressed: _isLoadingExport ? null : _exportBackup,
          child: _isLoadingExport
              ? CircularProgressIndicator(color: AppColors.primaryColor)
              : Text(context.i18n.exportBackup),
        ),
      ],
    );
  }
}
