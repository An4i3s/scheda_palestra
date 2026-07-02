import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_state.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/views/create_workout_dialog.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_bloc.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_state.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_exercise.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final schedeState = context.read<SchedeBloc>().state;
          final workoutBloc = context.read<WorkoutBloc>();

          if (schedeState is SchedeLoaded) {
            showDialog(
              context: context,
              useRootNavigator: false,
              builder: (context) => CreateWorkoutDialog(
                schede: schedeState.schede,
                onCreateWorkout: (workout) {
                  workoutBloc.add(WorkoutCreated(workout));
                },
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
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
                spacing: 16,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout.scheda.nome,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "${workout.scheda.esercizi.length.toString()} esercizi",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          AnimatedContainer(
                            duration: Durations.medium1,
                            width: double.infinity,
                            height: 8,
                            margin: const EdgeInsets.only(top: 8, bottom: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Stack(
                                children: [
                                  AnimatedFractionallySizedBox(
                                    widthFactor: workout.scheda.esercizi.isEmpty
                                        ? 0
                                        : workout.completedExerciseIds.length / workout.scheda.esercizi.length,
                                    heightFactor: 1,
                                    alignment: Alignment.centerLeft,
                                    duration: Durations.medium1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.green.shade400,
                                            Colors.green.shade600,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${workout.completedExerciseIds.length} /${workout.scheda.esercizi.length} completati',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${(100 * (workout.completedExerciseIds.length / workout.scheda.esercizi.length)).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<WorkoutBloc>().add(const WourtkoutStarted());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow),
                          SizedBox(width: 8),
                          Text("Inizia Allenamento")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 16,
                        children: [
                                  ...workout.scheda.esercizi.map((e) => ExerciseWorkout(exerciseModel: e, onPressed: () { 
                      context.read<WorkoutBloc>().add(WorkoutExerciseToggle(exerciseId: e.id));
                     }, isPressed: workout.completedExerciseIds.contains(e.id),))
                      ],),
                    ),
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
