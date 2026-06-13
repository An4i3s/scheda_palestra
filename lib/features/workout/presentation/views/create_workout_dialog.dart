import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class CreateWorkoutDialog extends StatefulWidget {
  final List<SchedaModel> schede;
  final Function(WorkoutModel) onCreateWorkout;

  const CreateWorkoutDialog({
    super.key,
    required this.schede,
    required this.onCreateWorkout,
  });

  @override
  State<CreateWorkoutDialog> createState() => _CreateWorkoutDialogState();
}

class _CreateWorkoutDialogState extends State<CreateWorkoutDialog> {
  String? _selectedSchedaId;
  int? _selectedDay;

  final List<String> _daysOfWeek = [
    'Lunedì',
    'Martedì',
    'Mercoledì',
    'Giovedì',
    'Venerdì',
    'Sabato',
    'Domenica',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            const Text(
              'Crea Nuovo Workout',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Seleziona Scheda
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Seleziona scheda'),
              value: _selectedSchedaId,
              items: widget.schede
                  .map((scheda) => DropdownMenuItem(
                        value: scheda.id,
                        child: Text(scheda.nome),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSchedaId = value;
                });
              },
            ),
            // Seleziona Giorno della Settimana
            DropdownButton<int>(
              isExpanded: true,
              hint: const Text('Seleziona giorno'),
              value: _selectedDay,
              items: List.generate(7, (index) {
                return DropdownMenuItem(
                  value: index + 1,
                  child: Text(_daysOfWeek[index]),
                );
              }),
              onChanged: (value) {
                setState(() {
                  _selectedDay = value;
                });
              },
            ),
            // Bottoni
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Annulla'),
                ),
                ElevatedButton(
                  onPressed: _selectedSchedaId != null && _selectedDay != null
                      ? () {
                          final selectedScheda = widget.schede
                              .firstWhere((s) => s.id == _selectedSchedaId);
                          final workout = WorkoutModel(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            completedExercises: [],
                            date: DateTime.now(),
                            dayOfWeek: _selectedDay!,
                            scheda: selectedScheda,
                          );
                          widget.onCreateWorkout(workout);
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text('Crea'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
