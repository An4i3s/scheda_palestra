import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class HomeModel {
  final int totalWorkouts;
  final String? lastWorkoutName;
  final List<WorkoutModel> weeklyAssignments;

  const HomeModel({
    required this.totalWorkouts,
    this.lastWorkoutName,
    this.weeklyAssignments = const [],
  });
}