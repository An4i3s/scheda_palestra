import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_bloc.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_state.dart';
import 'package:scheda_palestra/features/workout_log/presentation/widgets/workout_log_card.dart';

class WorkoutLogView extends StatelessWidget {
  const WorkoutLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 96,
        backgroundColor: AppColors.backgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Workout Log',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
             Text(
              context.i18n.viewWorkoutLog,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<WorkoutLogBloc, WorkoutLogState>(
        builder: (c, state) {
          if (state is WorkoutLogLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
          if (state is WorkoutLogEmpty) {
            return Padding(
              padding:  EdgeInsets.all(16.0),
              child: Center(child: Text(context.i18n.noWorkoutLog)),
            );
          }
          if (state is WorkoutLogError) {
            return Text("Error");
          }
          if (state is WorkoutLogLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderContainerColor),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          Text("🏆", style: TextStyle(fontSize: 32)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.workouts.length.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                context.i18n.totalWorkoutLog,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              
                    ...state.workouts.map(
                      (w) =>
                          WorkoutLogCard(controller: ExpansibleController(), workoutLogModel: w,),
                    ),
                    // Text("Workout $e")),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}