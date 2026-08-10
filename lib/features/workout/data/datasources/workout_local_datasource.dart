import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

abstract class WorkoutLocalDatasource {
  Future<WorkoutModel> getCurrentWorkout();
  Future<WorkoutModel> saveWorkout(WorkoutModel workout);
  Future<List<WorkoutModel>> getAllWorkouts();
  Future<WorkoutModel> createWorkout(WorkoutModel workout);
  Future<WorkoutModel> toggleExercise(String exerciseId);
  Future<bool> deleteWorkout(WorkoutModel workout);
}
