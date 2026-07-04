import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/exercises/data/repositories/exercises_repository.dart';

class DeleteExercise {
  final ExercisesRepository repository;
  const DeleteExercise({required this.repository});

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteExercise(id);
  }
}