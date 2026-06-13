import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/data/repositories/workout_repository.dart';

class GetCurrentWorkout {
  final WorkoutRepository repository;

  GetCurrentWorkout({required this.repository});

  Future<Either<Failure, WorkoutModel>> call() {
    return repository.getCurrentWorkout();
  }
}
