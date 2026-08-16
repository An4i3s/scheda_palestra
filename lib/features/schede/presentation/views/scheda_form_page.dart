
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/exercises_bloc/exercises_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_events.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/custom_form_field.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_form_dialog.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_scheda_form.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_stats.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/workout_category_container.dart';


class SchedaFormPage extends StatefulWidget {
  final SchedaModel? scheda;

  const SchedaFormPage({super.key, this.scheda});

  @override
  State<SchedaFormPage> createState() => _SchedaFormPageState();
}

class _SchedaFormPageState extends State<SchedaFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _descrizioneController;
  late List<ExerciseModel> _esercizi;
  WorkoutCategory? _selectedCategory;

  bool get _isEditing => widget.scheda != null;
  

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.scheda?.nome ?? '');
    _descrizioneController = TextEditingController(
      text: widget.scheda?.descrizione ?? '',
    );
    _esercizi = List.from(widget.scheda?.esercizi ?? []);
    _selectedCategory = widget.scheda?.category ?? WorkoutCategory.strength;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descrizioneController.dispose();
    super.dispose();
  }
  void _addEsercizio(ExerciseModel esercizio) {
    setState(() => _esercizi.add(esercizio));
  }

  void _editEsercizio(int index, ExerciseModel esercizio) {
    setState(() => _esercizi[index] = esercizio);
  }

    void _showExerciseDialog({int? index, ExerciseModel? esercizio}) {
    showDialog<void>(
      context: context,
      builder: (_) =>  BlocProvider.value(
        value: context.read<ExercisesBloc>(),
        child: ExerciseFormDialog(
          esercizio: esercizio,
          defaultCategory: _selectedCategory,
          onSubmit: (saved) {
            if (index != null) {
              _editEsercizio(index, saved);
            } else {
              _addEsercizio(saved);
            }
          },
        ),
      ),
    );
  }

  void _deleteEsercizio(int index) {
    setState(() => _esercizi.removeAt(index));
  }

  void _reorderEsercizi(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = _esercizi.removeAt(oldIndex);
      _esercizi.insert(newIndex, item);
    });
  }



  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final scheda = SchedaModel(
      id: widget.scheda?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      nome: _nomeController.text.trim(),
      descrizione: _descrizioneController.text.trim(),
      createdAt: widget.scheda?.createdAt ?? DateTime.now(),
      esercizi: _esercizi,
      category: _selectedCategory ?? WorkoutCategory.strength,
    );

    context.read<SchedeBloc>().add(SchedaSaved(scheda));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf3fdfd),
      appBar: AppBar(
        backgroundColor: Color(0xFFf3fdfd),
        title: Text(_isEditing ? 'Modifica scheda' : 'Nuova scheda'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: WorkoutCategoryContainer(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) => setState(() => _selectedCategory = category),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.borderContainerColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        nomeController: _nomeController,
                        hintText: "ex Upper Body, Leg Day...",
                        label: "Nome Scheda",
                      ),
                      const SizedBox(height: 12),
                      CustomFormField(
                        nomeController: _descrizioneController,
                        hintText: "Descrizione",
                        label: 'Descrizione',
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Esercizi (${_esercizi.length})',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    FilledButton.icon(
                      onPressed: () => _showExerciseDialog(),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColors.secondaryBtnColor),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Aggiungi'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (_esercizi.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Center(child: Text('Nessun esercizio aggiunto')),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ExerciseSchedaForm(esercizi: _esercizi, onDelete: (i) => _deleteEsercizio(i), onEdit: (i, e) => _showExerciseDialog(  index: i, esercizio: e),),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: OutlinedButton(
                  onPressed: _submit,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.secondaryBtnColor),
                    padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Salva Scheda',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
