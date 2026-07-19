import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/home/data/home_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

abstract class HomeLocalDatasource {
  Future<HomeModel> getHomeSummary();
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  static const _boxName = 'workouts';

  Future<Box<WorkoutModel>> get _box async =>
      Hive.isBoxOpen(_boxName)
          ? Hive.box<WorkoutModel>(_boxName)
          : await Hive.openBox<WorkoutModel>(_boxName);

  @override
  Future<HomeModel> getHomeSummary() async {
    final box = await _box;
    final workouts = box.values.whereType<WorkoutModel>().toList();

    final uniqueById = <String, WorkoutModel>{};
    for (final workout in workouts) {
      uniqueById[workout.id] = workout;
    }

    final sorted = uniqueById.values.toList()
      ..sort((a, b) => a.dayOfWeek.compareTo(b.dayOfWeek));

    final lastWorkout = sorted.isEmpty ? null : sorted.last;

    return HomeModel(
      totalWorkouts: sorted.length,
      lastWorkoutName: lastWorkout?.scheda.nome,
      weeklyAssignments: sorted,
    );
  }
}