import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercise_type_bloc.dart/exercises_type_bloc.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercise_type_bloc.dart/exercises_type_events.dart';

class ExerciseTypeFormDialog extends StatefulWidget {
  final ExerciseTypeModel? exerciseType;
  // final void Function(ExerciseTypeModel) onSubmit;

  const ExerciseTypeFormDialog({
    super.key,
    this.exerciseType,
    // required this.onSubmit,
  });

  @override
  State<ExerciseTypeFormDialog> createState() => _ExerciseTypeFormDialogState();
}

class _ExerciseTypeFormDialogState extends State<ExerciseTypeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  // // late final TextEditingController _nomeController;
  late final TextEditingController _nameController;
  TargetMuscleGroup? _selectedTargetMuscleGroup;


  bool get _isEditing => widget.exerciseType != null;

  @override
  void initState() {
    // super.initState();
    _nameController = TextEditingController(text: widget.exerciseType?.name ?? '');

  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final esercizio = ExerciseTypeModel(
       id: widget.exerciseType?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      // name: _nomeController.text.trim(),
      name: _nameController.text.trim(),
      targetMuscleGroup: _selectedTargetMuscleGroup ?? TargetMuscleGroup.chest,
    );

    context.read<ExerciseTypeBloc>().add(ExerciseTypeSaved(esercizio));
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

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome *',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo obbligatorio' : null,
              textCapitalization: TextCapitalization.sentences,
            ),

              DropdownButtonFormField<TargetMuscleGroup>(
                value: _selectedTargetMuscleGroup,
                items: TargetMuscleGroup.values.map((muscle) {
                  return DropdownMenuItem(
                    value: muscle,
                    child: Text(muscle.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  _selectedTargetMuscleGroup = value;
                }),
                decoration: const InputDecoration(
                  labelText: 'Gruppo muscolare target *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null ? 'Campo obbligatorio' : null,
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