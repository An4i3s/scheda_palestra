import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_stats.dart';

class ExerciseStatsList extends StatelessWidget{
  const ExerciseStatsList({super.key, required this.exerciseModel});
  final ExerciseModel exerciseModel;

  @override
  Widget build(BuildContext context) {
    return  switch (exerciseModel.category) {
                                  WorkoutCategory.strength => StrengthMetricsWidget(series: exerciseModel.series, reps: exerciseModel.repetitions, rest: exerciseModel.restTime, weight: exerciseModel.weight, ),               
                                  WorkoutCategory.ruuning =>  CardioMetricsWidget(time: exerciseModel.time, km: exerciseModel.km, series: exerciseModel.series,),
                                  WorkoutCategory.walking => WalkingMetricsWidget(time: exerciseModel.time, km: exerciseModel.km, elevation: exerciseModel.elevation, series: exerciseModel.series, )  ,
                                  WorkoutCategory.cycling =>  CardioMetricsWidget(time: exerciseModel.time, km: exerciseModel.km, series: exerciseModel.series,),
                                  WorkoutCategory.swimming =>  CardioMetricsWidget(time: exerciseModel.time, km: exerciseModel.km, series: exerciseModel.series,),
                                  WorkoutCategory.pilates => GenericExerciseWidget(time: exerciseModel.time, description: exerciseModel.description, series: null,),
                                  WorkoutCategory.yoga => GenericExerciseWidget(series: exerciseModel.series, time: exerciseModel.time, description: exerciseModel.description,),
                                  WorkoutCategory.crossfit => GenericExerciseWidget(series: exerciseModel.series, time: exerciseModel.time, description: exerciseModel.description,),
                    };
  }
}