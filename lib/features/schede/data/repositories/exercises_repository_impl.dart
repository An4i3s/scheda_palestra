import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/data/datasources/exercise_local_datasource.dart';
import 'package:scheda_palestra/features/schede/data/repositories/exercises_repository.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';

class ExercisesRepositoryImpl implements ExercisesRepository {
    final ExerciseLocalDatasource datasource;

  ExercisesRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, ExerciseModel>> getExerciseById(String id) async {
        try {
      final model = await datasource.getExerciseById(id);
      return Right(model);
    } catch (e) {
      return Left(NotFoundFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExerciseModel>>> getExercises() async {
    try {
      final models = await datasource.getExercises();
      return Right(models);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExerciseModel>> saveExercise(ExerciseModel exercise) async {
    try {
      final model = await datasource.saveExercise(exercise);
      return Right(model);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
