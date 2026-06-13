import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';

abstract class ExercisesRepository {
  Future<Either<Failure, List<ExerciseModel>>> getExercises();
  Future<Either<Failure, ExerciseModel>> getExerciseById(String id);
  Future<Either<Failure, ExerciseModel>> saveExercise(ExerciseModel exercise);
}