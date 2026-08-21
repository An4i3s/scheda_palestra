import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/workout/data/datasources/workout_local_datasource.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/core/utils/logger.dart';

class WorkoutLocalDatasourceImpl implements WorkoutLocalDatasource {
  static const _boxName = 'workouts';

  // No per-day current key: selection is based on `dayOfWeek` and `date` fields

  Future<Box<WorkoutModel>> get _box async =>
      Hive.isBoxOpen(_boxName)
          ? Hive.box<WorkoutModel>(_boxName)
          : await Hive.openBox<WorkoutModel>(_boxName);

  @override
  Future<WorkoutModel> getCurrentWorkout() async {
    try {
      final box = await _box;
      final all = box.values.whereType<WorkoutModel>().toList();
      Logger.info('WorkoutLocalDatasource', 'Box contains ${all.length} workouts');
      for (var w in all) {
        Logger.info('WorkoutLocalDatasource', 'stored workout: id=${w.id} day=${w.dayOfWeek} isCompleted=${w.isCompleted}');
      }
      final today = DateTime.now().weekday; // 1 = Monday, 7 = Sunday
      Logger.info('WorkoutLocalDatasource', 'Today weekday = $today');

      final assignments = box.values
          .whereType<WorkoutModel>()
          .where((w) => w.dayOfWeek == today)
          .toList();

      Logger.info('WorkoutLocalDatasource', 'Assignments for today: ${assignments.length}');
      for (var a in assignments) {
        Logger.info('WorkoutLocalDatasource', 'assignment id=${a.id} day=${a.dayOfWeek} isCompleted=${a.isCompleted}');
      }

      if (assignments.isNotEmpty) {
        return assignments.first;
      }

      throw Exception('Nessun workout attivo');
    } catch (e, st) {
      Logger.error('WorkoutLocalDatasource', 'Errore caricamento workout: $e');
      Logger.info('WorkoutLocalDatasource', 'StackTrace: $st');
      rethrow;
    }
  }

  @override
  Future<WorkoutModel> saveWorkout(WorkoutModel workout) async {
    final box = await _box;
    Logger.info('WorkoutLocalDatasource', 'Saving workout: id=${workout.id} day=${workout.dayOfWeek}');
    await box.put(workout.id, workout);
    Logger.info('WorkoutLocalDatasource', 'Saved workout: id=${workout.id}');
    // persisted by id only
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
    Logger.info('WorkoutLocalDatasource', 'Creating workout: id=${workout.id} day=${workout.dayOfWeek}');
    await box.put(workout.id, workout);
    Logger.info('WorkoutLocalDatasource', 'Created workout: id=${workout.id}');
    // persisted by id only
    return workout;
  }

  @override
  Future<WorkoutModel> toggleExercise(String exerciseId) async {
    final box = await _box;
    // find current workout for today using existing logic
    Logger.info('WorkoutLocalDatasource', 'Toggling exercise: id=$exerciseId');
    final current = await getCurrentWorkout();
    final updated = current.isExerciseCompleted(exerciseId)
      ? current.unmarkExerciseCompleted(exerciseId)
      : current.markExerciseCompleted(exerciseId);

    await box.put(updated.id, updated);
    Logger.info('WorkoutLocalDatasource', 'Toggled exercise: workoutId=${updated.id} completedCount=${updated.completedExerciseIds.length}');
    return updated;
  }

  @override
  Future<bool> deleteWorkout(WorkoutModel workout) async {
    final box = await _box;
    Logger.info('WorkoutLocalDatasource', 'Deleting workout: id=${workout.id} day=${workout.dayOfWeek}');
    await box.delete(workout.id);
    Logger.info('WorkoutLocalDatasource', 'Deleted workout: id=${workout.id}');
    // no per-day current key to clean up; workouts stored by id only
    return true;
  }

  @override
  Future<bool> completeWorkout(WorkoutModel workout) async {
    final box = await _box;
    final current = box.get(workout.id) ?? workout;
    final completedWorkout = current.copyWith(
      id: workout.id,
      // date: workout.date,
      dayOfWeek: workout.dayOfWeek,
      scheda: workout.scheda,
      completedExercises: workout.completedExercises,
      completedExerciseIds: workout.completedExerciseIds,
      isCompleted: true,
    );

    await box.put(completedWorkout.id, completedWorkout);
    Logger.info('WorkoutLocalDatasource', 'Completed workout: id=${completedWorkout.id}');
    return true;
  }
}
