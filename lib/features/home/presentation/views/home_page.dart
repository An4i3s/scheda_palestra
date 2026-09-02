// ignore_for_file: constant_identifier_names


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_bloc.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_events.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_state.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/back_up_widget.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/home_header_widget.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/weekly_plan.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_state.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/create_workout_dialog.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/core/utils/logger.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_bloc.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_state.dart';
import 'package:scheda_palestra/features/workout_log/domain/workout_series.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_bloc.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_state.dart';
import 'package:share_plus/share_plus.dart';

enum DaysOfWeek { LUN, MAR, MER, GIO, VEN, SAB, DOM }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _openAssignmentDialog(
    BuildContext context, {
    required int selectedDay,
    WorkoutModel? selectedWorkout,
  }) {
    final schedeState = context.read<SchedeBloc>().state;
    if (schedeState is! SchedeLoaded) return;

    // Debug log: tapped day in weekly plan
    Logger.info(
      'HomePage',
      'Tapped day: $selectedDay, workoutId=${selectedWorkout?.id ?? 'null'}',
    );
    final today = DateTime.now();

    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (_) => CreateWorkoutBottomSheet(
        schede: schedeState.schede,
        onCreateWorkout: (workout) {
          if (today.weekday == workout.dayOfWeek) {
            context.read<WorkoutBloc>().add(
              WourtkoutUpdated(workoutModel: workout),
            );
          }

          context.read<HomeBloc>().add(HomeCreateWorkout(workout));
        },
        selectedWorkout: selectedWorkout,
        selectedDay: selectedDay,
        onDeleteWorkout: (WorkoutModel w) {

          if (today.weekday == w.dayOfWeek) {
            context.read<WorkoutBloc>().add(WorkoutOnDeleted(w));
          }
          context.read<HomeBloc>().add(HomeDeleteWorkout(w));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutBloc, WorkoutState>(
      listener: (context, state) {
        final today = DateTime.now().weekday;
        if (state is WorkoutLoaded) {
          if (state.workout.dayOfWeek == today) {
            context.read<HomeBloc>().add(const HomeStarted());
          }
        } else if (state is WorkoutDeleted) {
          if (state.dayOfWeek == today) {
            context.read<HomeBloc>().add(const HomeStarted());
          }
        } else if (state is WorkoutMutationCompleted) {
          // A background create/delete completed; refresh the weekly plan.
          context.read<HomeBloc>().add(const HomeStarted());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        endDrawer: Drawer(
          backgroundColor: AppColors.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                BackupWidget(),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is HomeError) {
                return const Center(
                  child: Text(
                    'Non è stato possibile caricare il piano settimanale.',
                  ),
                );
              }

              if (state is HomeLoaded) {
                final homeModel = state.homeModel;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 24,
                      children: [
                        BlocBuilder<WorkoutLogBloc, WorkoutLogState>(
                          buildWhen: (previous, current) =>
                              current is WorkoutLogLoaded,
                          builder: (context, workoutState) {

                            int streak = 0;
                            int monthlyCount = 0;

                            if (workoutState is WorkoutLogLoaded) {
                              streak = workoutState.workouts.currentStreak;
                              monthlyCount = workoutState.workouts.countInMonth(
                                DateTime.now(),
                              );
                            }

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                HomeHeaderWidget(
                                  streaksDays: streak,
                                  onSettingsPressed: () =>
                                      Scaffold.of(context).openEndDrawer(),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.borderContainerColor,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 8,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        spacing: 8,
                                        children: [
                                          Text(
                                            "🎯",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "Obiettivo",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "$monthlyCount",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Allenamenti questo mese",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        WeeklyPlanWidget(
                          homeModel: homeModel,
                          onPressed: (c, day, workout) => _openAssignmentDialog(
                            c,
                            selectedDay: day,
                            selectedWorkout: workout,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
