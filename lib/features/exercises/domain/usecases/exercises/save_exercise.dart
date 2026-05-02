import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/exercises/data/repositories/exercises_repository.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';

class SaveExercise{
  final ExercisesRepository repository;
  const SaveExercise({required this.repository});
 
  Future<Either<Failure, ExerciseModel>> call(ExerciseModel params) {
    return repository.saveExercise(params);
  }
}
 