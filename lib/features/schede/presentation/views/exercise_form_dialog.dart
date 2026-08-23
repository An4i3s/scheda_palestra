import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercise_type_bloc.dart/exercises_type_bloc.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercise_type_bloc.dart/exercises_type_state.dart';

class ExerciseFormDialog extends StatefulWidget {
  final ExerciseModel? esercizio;
  final void Function(ExerciseModel) onSubmit;

  const ExerciseFormDialog({
    super.key,
    this.esercizio,
    required this.onSubmit,
  });

  @override
  State<ExerciseFormDialog> createState() => _ExerciseFormDialogState();
}

class _ExerciseFormDialogState extends State<ExerciseFormDialog> {
  final _formKey = GlobalKey<FormState>();
  // // late final TextEditingController _nomeController;
  late final TextEditingController _serieController;
  late final TextEditingController _ripetizioniController;
  late final TextEditingController _pesoController;
  String? _selectedExercise;
  

  bool get _isEditing => widget.esercizio != null;

  @override
  void initState() {
    super.initState();
    _serieController = TextEditingController(
      text: widget.esercizio?.series.toString() ?? '',
    );
    _ripetizioniController = TextEditingController(
      text: widget.esercizio?.repetitions.toString() ?? '',
    );
    _pesoController = TextEditingController(
      text: widget.esercizio?.weight.toString() ?? '',
    );
  }

  @override
  void dispose() {
    // _nomeController.dispose();
    _serieController.dispose();
    _ripetizioniController.dispose();
    _pesoController.dispose();
    super.dispose();
  }




  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final esercizio = ExerciseModel(
       id: widget.esercizio?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      // name: _nomeController.text.trim(),
      name: _selectedExercise ?? "",
      series: int.parse(_serieController.text),
      repetitions: int.parse(_ripetizioniController.text),
      weight: int.parse(_pesoController.text), targetMuscleGroup: TargetMuscleGroup.chest, restTime: 30,
    );

    widget.onSubmit(esercizio);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Modifica esercizio' : 'Nuovo esercizio'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<ExerciseTypeBloc, ExercisesTypeState>(
              builder: (context, state) {
                if (state is ExercisesTypeLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ExercisesTypeError) {
                  return Text(
                    'Errore: ${state.message}',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  );
                }

                if (state is ExercisesTypeLoaded) {
                  return DropdownButton<String>(
                    hint: const Text("Seleziona Esercizio"),
                    items: state.exercises.map((exercise) {
                      return DropdownMenuItem(
                        value: exercise.name,
                        child: Text(exercise.name),
                      );
                    }).toList(),
                    value: _selectedExercise,
                    onChanged: (value) => setState(() {
                      _selectedExercise = value;
                    }),
                  );
                }

                return const Text("Nessun esercizio disponibile");
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _serieController,
                    decoration: const InputDecoration(
                      labelText: 'Serie',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        (v == null || int.tryParse(v) == null) ? '—' : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _ripetizioniController,
                    decoration: const InputDecoration(
                      labelText: 'Ripetizioni',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        (v == null || int.tryParse(v) == null) ? '—' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _pesoController,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (v) =>
                  (v == null || int.tryParse(v) == null) ? 'Campo obbligatorio' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annulla'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(_isEditing ? 'Salva' : 'Aggiungi'),
        ),
      ],
    );
  }
}