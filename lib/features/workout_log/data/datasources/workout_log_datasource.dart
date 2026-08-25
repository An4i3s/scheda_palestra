import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

abstract class WorkoutLogDatasource {
  Future<List<WorkoutLogModel>> getPastWorkouts();
  Future<WorkoutLogModel> registerWorkout(WorkoutLogModel workoutLogModel);
}