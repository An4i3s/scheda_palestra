// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_bloc.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_events.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_state.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/home_header_widget.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/weekly_plan.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_state.dart';
import 'package:scheda_palestra/features/workout/presentation/views/create_workout_dialog.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_bloc.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';



  enum DaysOfWeek{
    LUN,
    MAR,
    MER,
    GIO,
    VEN,
    SAB,
    DOM
    }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openAssignmentDialog(BuildContext context, {int? initialDay}) {
    final schedeState = context.read<SchedeBloc>().state;
    if (schedeState is! SchedeLoaded) return;

    showDialog(
      context: context,
      builder: (_) => CreateWorkoutDialog(
        schede: schedeState.schede,
        // initialDay: initialDay,
        onCreateWorkout: (workout) {
          context.read<WorkoutBloc>().add(WorkoutCreated(workout));
          context.read<HomeBloc>().add(const HomeStarted());
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeError) {
              return const Center(child: Text('Non è stato possibile caricare il piano settimanale.'));
            }

            if (state is HomeLoaded) {
              final homeModel = state.homeModel;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 24,
                    children: [
                      HomeHeaderWidget(streaksDays: 0,),
                      WeeklyPlanWidget(homeModel: homeModel, onPressed: _openAssignmentDialog,),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
