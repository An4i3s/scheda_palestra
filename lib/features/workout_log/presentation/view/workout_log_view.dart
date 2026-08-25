import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_bloc.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_state.dart';

class WorkoutLogView extends StatelessWidget{
  const WorkoutLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<WorkoutLogBloc, WorkoutLogState>(builder: (c, state){
                  print("State is $state");

         if(state is WorkoutLogLoading){
             return const Center(
              child: CircularProgressIndicator(
                color: AppColors.secondaryBtnColor,
              ),
            );
        }
        if(state is WorkoutLogEmpty){
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text("Ancora nessun workout registrato!"),
            ),
          );
        }
        if(state is WorkoutLogError){
          return Text("Error");
        }
        if(state is WorkoutLogLoaded){
          return Column(children: [...state.workouts.map((e) => Text("Workout $e")),
          Text("Numero workout completati = ${state.workouts.length}")
          ],);
        }
      return const SizedBox.shrink();
      }),
    );
  }
}