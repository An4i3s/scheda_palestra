import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model.dart';
import 'package:scheda_palestra/features/exercises/data/repositories/exercises_repository.dart';


class ExerciseTypeUseCases{
      static const _boxName = 'exercises-types';

    Future<Box<ExerciseTypeModel>> get _box async =>
      Hive.isBoxOpen(_boxName)
          ? Hive.box<ExerciseTypeModel>(_boxName)
          : await Hive.openBox<ExerciseTypeModel>(_boxName);
  
  Future<void> deleteExerciseType(String id) async {
    final box = await _box;
    await box.delete(id);
  }

    Future<ExerciseTypeModel> saveExerciseType(ExerciseTypeModel exerciseType) async {
    final box = await _box;
    await box.put(exerciseType.id, exerciseType);
    return exerciseType;
  }



  Future<List<ExerciseTypeModel>> getExerciseTypes() async {
    final box = await _box;
    return box.values.toList();
  }

  Future<ExerciseTypeModel> getExerciseTypeById(String id) async {
    final box = await _box;
    final exerciseType = box.get(id);
    if (exerciseType == null) throw Exception('Tipo di esercizio $id non trovato');
    return exerciseType;
  }

}