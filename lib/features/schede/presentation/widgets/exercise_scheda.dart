
import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_stats.dart';

class ExerciseInScheda extends StatelessWidget {
  const ExerciseInScheda({
    super.key,
    required this.exercise,
    required this.index,
  });
  final int index;
  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red[800],
              borderRadius: BorderRadius.circular(64),
            ),
            child: Center(child: Text(index.toString(), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                    switch (exercise.category) {
                      WorkoutCategory.strength => StrengthMetricsWidget(series: exercise.series, reps: exercise.repetitions, rest: exercise.restTime, weight: exercise.weight, ),               
                      WorkoutCategory.ruuning =>  CardioMetricsWidget(time: exercise.time, km: exercise.km, series: exercise.series,),
                      WorkoutCategory.walking => WalkingMetricsWidget(time: exercise.time, km: exercise.km, elevation: exercise.elevation, series: exercise.series, )  ,
                      WorkoutCategory.cycling =>  CardioMetricsWidget(time: exercise.time, km: exercise.km, series: exercise.series,),
                      WorkoutCategory.swimming =>  CardioMetricsWidget(time: exercise.time, km: exercise.km, series: exercise.series,),
                      WorkoutCategory.pilates => GenericExerciseWidget(time: exercise.time, description: exercise.description, series: null,),
                      WorkoutCategory.yoga => GenericExerciseWidget(series: exercise.series, time: exercise.time, description: exercise.description,),
                      WorkoutCategory.crossfit => GenericExerciseWidget(series: exercise.series, time: exercise.time, description: exercise.description,),
                    },
              ],
            ),
          ),
        ],
      ),
    );
  }
}

