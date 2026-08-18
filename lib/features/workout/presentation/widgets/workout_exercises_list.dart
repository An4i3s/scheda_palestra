import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/views/workout_exercise.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_bloc.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';

class WorkoutExerciseList extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutExerciseList({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: workout.scheda.esercizi.map(
        (e) => ExerciseWorkout(
          exerciseModel: e,
          onPressed: () {
            context.read<WorkoutBloc>().add(
              WorkoutExerciseToggled(exerciseId: e.id),
            );
          },
          isPressed: workout.isExerciseCompleted(e.id),
        ),
      ).toList(),
    );
  }
}