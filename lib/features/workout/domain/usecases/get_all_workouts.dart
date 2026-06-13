import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/data/repositories/workout_repository.dart';

class GetAllWorkouts {
  final WorkoutRepository repository;

  GetAllWorkouts({required this.repository});

  Future<Either<Failure, List<WorkoutModel>>> call() {
    return repository.getAllWorkouts();
  }
}
