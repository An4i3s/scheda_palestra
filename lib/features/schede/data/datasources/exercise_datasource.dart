import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';

abstract class ExercisesDatasource {
  Future<List<ExerciseModel>> getExercises();
  Future<ExerciseModel> getExerciseById(String id);
  Future<ExerciseModel> saveExercise(ExerciseModel exercise);
  // Future<void> deleteExercise(String id);
}

