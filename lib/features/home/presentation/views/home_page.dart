// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_bloc.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_events.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_state.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/home_header_widget.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/weekly_plan.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_state.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/create_workout_dialog.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_bloc.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_state.dart';



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

  void _openAssignmentDialog(BuildContext context, { int? selectedDay, WorkoutModel? selectedWorkout}) {
    final schedeState = context.read<SchedeBloc>().state;
    if (schedeState is! SchedeLoaded) return;

    

    print("selectedDay  = $selectedDay");

    showModalBottomSheet(
      isDismissible: false,
      context: context,
       builder: (_) => CreateWorkoutBottomSheet(
        schede: schedeState.schede, 
            onCreateWorkout: (workout) {
          context.read<WorkoutBloc>().add(WorkoutCreated(workout));
          // context.read<HomeBloc>().add(const HomeStarted());
        }, 
        selectedWorkout: selectedWorkout,
          selectedDay: selectedDay??0,
           onDeleteWorkout: (WorkoutModel w) { 
          context.read<WorkoutBloc>().add(WorkoutOnDeleted(w));
          // context.read<HomeBloc>().add(const HomeStarted());
           },));
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutBloc, WorkoutState>(
        listener: (context, state) {
        if (state is WorkoutDeleted || state is WorkoutLoaded) {
          context.read<HomeBloc>().add(const HomeStarted());
        }
      },
        
        
         
           child: Scaffold(
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
                            WeeklyPlanWidget(homeModel: homeModel, onPressed: (c, day, workout) => _openAssignmentDialog(c, selectedDay: day, selectedWorkout: workout),),
                          ],
                        ),
                      ),
                    );
                  }
                   
                  return const SizedBox.shrink();
                },
              ),
            ),
                   )
         
      
    );
  }
}
