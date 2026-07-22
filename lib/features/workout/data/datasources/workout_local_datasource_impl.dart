import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/workout/data/datasources/workout_local_datasource.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class WorkoutLocalDatasourceImpl implements WorkoutLocalDatasource {
  static const _boxName = 'workouts';
  static const _currentKey = 'current_workout';

  Future<Box<WorkoutModel>> get _box async =>
      Hive.isBoxOpen(_boxName)
          ? Hive.box<WorkoutModel>(_boxName)
          : await Hive.openBox<WorkoutModel>(_boxName);

  @override
  Future<WorkoutModel> getCurrentWorkout() async {
    try {
      final box = await _box;
      final workout = box.get(_currentKey);
      if (workout == null) throw Exception('Nessun workout attivo');
      return workout;
    } catch (e) {
      print('Errore caricamento workout: $e');
      rethrow;
    }
  }

  @override
  Future<WorkoutModel> saveWorkout(WorkoutModel workout) async {
    final box = await _box;
    await box.put(_currentKey, workout);
    return workout;
  }

  @override
  Future<List<WorkoutModel>> getAllWorkouts() async {
    final box = await _box;
    return box.values.toList();
  }
@override
Future<WorkoutModel> createWorkout(WorkoutModel workout) async {
  final box = await _box;
  await box.put(workout.id, workout);
  return workout;
}
  
  @override
Future<WorkoutModel> toggleExercise(String exerciseId) async {
  final box = await _box;
  
  final workout = box.get(_currentKey);
  if (workout == null) throw Exception('Nessun workout attivo');
  
  final updatedWorkout = workout.isExerciseCompleted(exerciseId)
      ? workout.unmarkExerciseCompleted(exerciseId)
      : workout.markExerciseCompleted(exerciseId);
  
  await box.put(_currentKey, updatedWorkout);
  return updatedWorkout;
}

  @override
  Future<bool> deleteWorkout(WorkoutModel workout) async{
      final box = await _box;
      await box.delete(workout.id);
      return !box.containsKey(workout.id);
    
  }

  // @override
  // Future<WorkoutModel> updateWorkout(WorkoutModel workout) {
  //   // try{
  //   //    final box = await _box;
  //   //    final workout = box.get(_currentKey);
  //   //    final updatedWorkout = workout
  //   // }
     
  //  return Wo
  // }
}
