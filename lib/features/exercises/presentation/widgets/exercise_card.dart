import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;

  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Serie: ${exercise.series}'),
            Text('Ripetizioni: ${exercise.repetitions}'),
            Text('Peso: ${exercise.weight} kg'),
          ],
        ),
      ),
    );
  }
  }