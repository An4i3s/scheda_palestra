import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class ExerciseFormDialog extends StatefulWidget {
  final ExerciseModel? esercizio;
  final WorkoutCategory? defaultCategory;
  final void Function(ExerciseModel) onSubmit;

  const ExerciseFormDialog({super.key, this.esercizio, this.defaultCategory, required this.onSubmit});

  @override
  State<ExerciseFormDialog> createState() => _ExerciseFormDialogState();
}

class _ExerciseFormDialogState extends State<ExerciseFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeController;
  late final TextEditingController _serieController;
  late final TextEditingController _ripetizioniController;
  late final TextEditingController _pesoController;
  late final TextEditingController _restTimeController;
  late final TextEditingController _timeController;
  late final TextEditingController _kmController;
  late final TextEditingController _elevationController;
  late final TextEditingController _obiettivoController;
  WorkoutCategory? _workoutCategory;

  bool get _isEditing => widget.esercizio != null;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(
      text: widget.esercizio?.name.toString() ?? '',
    );
    _serieController = TextEditingController(
      text: widget.esercizio?.series.toString() ?? '',
    );
    _ripetizioniController = TextEditingController(
      text: widget.esercizio?.repetitions.toString() ?? '',
    );
    _pesoController = TextEditingController(
      text: widget.esercizio?.weight.toString() ?? '',
    );
    _restTimeController = TextEditingController(
      text: widget.esercizio?.restTime.toString() ?? '',
    );
    _timeController = TextEditingController(
      text: widget.esercizio?.time.toString() ?? '',
    );
    _kmController = TextEditingController(
      text: widget.esercizio?.km.toString() ?? '',
    );
    _elevationController = TextEditingController(
      text: widget.esercizio?.elevation.toString() ?? '',
    );
    _obiettivoController = TextEditingController(
      text: widget.esercizio?.description ?? '',
    );
    _workoutCategory = widget.esercizio?.category ?? widget.defaultCategory;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _serieController.dispose();
    _ripetizioniController.dispose();
    _pesoController.dispose();
    _restTimeController.dispose();
    _timeController.dispose();
    _kmController.dispose();
    _elevationController.dispose();
    _obiettivoController.dispose();
    super.dispose();
  }

  int? _intOrNull(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    return int.tryParse(value);
  }

  WorkoutCategory get _effectiveCategory =>
      _workoutCategory ?? widget.defaultCategory ?? WorkoutCategory.strength;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final category = _effectiveCategory;
    final esercizio = ExerciseModel(
      id: widget.esercizio?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nomeController.text.trim(),
      series: _intOrNull(_serieController.text) ?? 0,
      repetitions: _intOrNull(_ripetizioniController.text),
      weight: _intOrNull(_pesoController.text),
      category: category,
      restTime: _intOrNull(_restTimeController.text),
      time: _intOrNull(_timeController.text),
      km: _intOrNull(_kmController.text),
      elevation: _intOrNull(_elevationController.text),
      description: _obiettivoController.text.trim().isEmpty ? null : _obiettivoController.text.trim(),
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
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome esercizio *',
                border: OutlineInputBorder(),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Campo obbligatorio'
                  : null,
            ),
            const SizedBox(height: 12),
            ..._buildCategoryFields(),
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

  List<Widget> _buildCategoryFields() {
    final category = _effectiveCategory;

    final seriesField = TextFormField(
      controller: _serieController,
      decoration: const InputDecoration(
        labelText: 'Serie *',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (v) =>
          (v == null || _intOrNull(v) == null) ? 'Campo obbligatorio' : null,
    );

    final timeField = TextFormField(
      controller: _timeController,
      decoration: const InputDecoration(
        labelText: 'Tempo (min) *',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (v) =>
          (v == null || _intOrNull(v) == null) ? 'Campo obbligatorio' : null,
    );

    final kmField = TextFormField(
      controller: _kmController,
      decoration: const InputDecoration(
        labelText: 'Km *',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (v) =>
          (v == null || _intOrNull(v) == null) ? 'Campo obbligatorio' : null,
    );

    final elevationField = TextFormField(
      controller: _elevationController,
      decoration: const InputDecoration(
        labelText: 'Dislivello (m) *',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (v) =>
          (v == null || _intOrNull(v) == null) ? 'Campo obbligatorio' : null,
    );

    final repetitionsField = TextFormField(
      controller: _ripetizioniController,
      decoration: const InputDecoration(
        labelText: 'Ripetizioni *',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (v) =>
          (v == null || _intOrNull(v) == null) ? 'Campo obbligatorio' : null,
    );

    final weightField = TextFormField(
      controller: _pesoController,
      decoration: const InputDecoration(
        labelText: 'Peso (kg) *',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (v) =>
          (v == null || _intOrNull(v) == null) ? 'Campo obbligatorio' : null,
    );

    final restField = TextFormField(
      controller: _restTimeController,
      decoration: const InputDecoration(
        labelText: 'Recupero (sec) *',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (v) =>
          (v == null || _intOrNull(v) == null) ? 'Campo obbligatorio' : null,
    );

    final obiettivoField = TextFormField(
      controller: _obiettivoController,
      decoration: const InputDecoration(
        labelText: 'Obiettivo',
        border: OutlineInputBorder(),
      ),
      maxLines: 2,
    );

    switch (category) {
      case WorkoutCategory.strength:
        return [
          Row(
            children: [
              Expanded(child: seriesField),
              const SizedBox(width: 8),
              Expanded(child: repetitionsField),
            ],
          ),
          const SizedBox(height: 12),
          weightField,
          const SizedBox(height: 12),
          restField,
        ];
      case WorkoutCategory.ruuning:
      case WorkoutCategory.cycling:
      case WorkoutCategory.swimming:
        return [
          Row(
            children: [
              Expanded(child: seriesField),
              const SizedBox(width: 8),
              Expanded(child: timeField),
            ],
          ),
          const SizedBox(height: 12),
          kmField,
        ];
      case WorkoutCategory.walking:
        return [
          Row(
            children: [
              Expanded(child: seriesField),
              const SizedBox(width: 8),
              Expanded(child: timeField),
            ],
          ),
          const SizedBox(height: 12),
          kmField,
          const SizedBox(height: 12),
          elevationField,
        ];
      case WorkoutCategory.pilates:
      case WorkoutCategory.yoga:
      case WorkoutCategory.crossfit:
        return [
          obiettivoField,
          const SizedBox(height: 12),
          timeField,
        ];
    }
  }
}
