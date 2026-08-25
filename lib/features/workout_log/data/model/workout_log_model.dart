import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class WorkoutLogModel {
  final String id;
  final WorkoutModel workout;
  final DateTime date;

  WorkoutLogModel({required this.id, required this.workout, required this.date});
}