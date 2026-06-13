import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/data/repositories/exercises_repository.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';

class GetExercise {
  final ExercisesRepository repository;
  const GetExercise({required this.repository});

  Future<Either<Failure, List<ExerciseModel>>> call() {
    return repository.getExercises();
  }
}