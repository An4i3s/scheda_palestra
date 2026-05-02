
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/exercises/data/datasources/exercise_datasource.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';

class ExerciseLocalDatasource implements ExercisesDatasource {
  static const _boxName = 'exercises';

  Future<Box<ExerciseModel>> get _box async =>
      Hive.isBoxOpen(_boxName)
          ? Hive.box<ExerciseModel>(_boxName)
          : await Hive.openBox<ExerciseModel>(_boxName);

  @override
  Future<List<ExerciseModel>> getExercises() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<ExerciseModel> getExerciseById(String id) async {
    final box = await _box;
    final exercise = box.get(id);
    if (exercise == null) throw Exception('Esercizio $id non trovato');
    return exercise;
  }

  @override
  Future<ExerciseModel> saveExercise(ExerciseModel exercise) async {
    final box = await _box;
    await box.put(exercise.id, exercise);
    return exercise;
  }

  @override
  Future<void> deleteExercise(String id) async {
    final box = await _box;
    await box.delete(id);
  }
}