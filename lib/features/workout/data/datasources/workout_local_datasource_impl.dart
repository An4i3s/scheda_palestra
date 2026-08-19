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
    await box.put(_currentKey, workout);
    return workout;
  }

  @override
  Future<WorkoutModel> toggleExercise(String exerciseId) async {
    final box = await _box;
    final current = box.get(_currentKey);
    if (current == null) throw Exception('Nessun workout attivo');

    final updated = current.isExerciseCompleted(exerciseId)
        ? current.unmarkExerciseCompleted(exerciseId)
        : current.markExerciseCompleted(exerciseId);

    await box.put(_currentKey, updated);
    await box.put(updated.id, updated);
    return updated;
  }

  @override
  Future<bool> deleteWorkout(WorkoutModel workout) async {
    final box = await _box;
    await box.delete(workout.id);
    final current = box.get(_currentKey);
    if (current?.id == workout.id) {
      await box.delete(_currentKey);
    }
    return true;
  }

  @override
  Future<bool> completeWorkout(WorkoutModel workout) async {
    final box = await _box;
    final current = box.get(_currentKey) ?? box.get(workout.id) ?? workout;
    final completedWorkout = current.copyWith(
      id: workout.id,
      date: workout.date,
      dayOfWeek: workout.dayOfWeek,
      scheda: workout.scheda,
      completedExercises: workout.completedExercises,
      completedExerciseIds: workout.completedExerciseIds,
      isCompleted: true,
    );

    await box.put(completedWorkout.id, completedWorkout);
    await box.put(_currentKey, completedWorkout);
    return true;
  }
}
