import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/widgets/workout_exercises_list.dart';
import 'package:scheda_palestra/features/workout/presentation/widgets/workout_header.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_bloc.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_state.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  @override
  void initState() {
    super.initState();
    context.read<WorkoutBloc>().add(const WourtkoutLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WorkoutError) {
            return Center(child: Text('Errore: ${state.message}'));
          }

          if (state is WorkoutEmpty) {
            return const Center(
              child: Text('Nessun workout attivo. Creane uno nuovo!'),
            );
          }

          if (state is WorkoutLoaded) {
            final workout = state.workout;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  WorkoutHeader(workout: workout),
                  const SizedBox(height: 16),
                  //avoid unnecessary re-renders of the Bloc on exercises toggled
                  BlocSelector<WorkoutBloc, WorkoutState, WorkoutModel>(
                    selector: (state) {
                      if (state is WorkoutLoaded) return state.workout;
                      return workout;
                    },
                    builder: (context, currentWorkout) {
                      return WorkoutExerciseList(workout: currentWorkout);
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
