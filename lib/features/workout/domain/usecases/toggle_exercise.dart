import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/data/repositories/workout_repository.dart';

class ToggleExercise {
  final WorkoutRepository repository;

  ToggleExercise({required this.repository});

  Future<Either<Failure, WorkoutModel>> call(WorkoutModel workout,String exId) {
    return repository.toggleExercise(workout,exId);
  }
}
