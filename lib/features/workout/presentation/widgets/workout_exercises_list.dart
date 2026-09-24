import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/views/workout_exercise.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_bloc.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';

class WorkoutExerciseList extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutExerciseList({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final exercises = workout.scheda.esercizi
        .where((e) => e is ExerciseModel)
        .map((e) => e as ExerciseModel)
        .toList();

    return Column(
      spacing: 12,
      children: exercises.map(
        (e) => ExerciseWorkout(
          exerciseModel: e,
          onPressed: () {
            context.read<WorkoutBloc>().add(
              WorkoutExerciseToggled(exerciseId: e.id, workout: workout),
            );
          },
          isPressed: workout.completedExerciseIds.contains(e.id),
        ),
      ).toList(),
    );
  }
}