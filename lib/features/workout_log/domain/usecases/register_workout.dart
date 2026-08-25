import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';
import 'package:scheda_palestra/features/workout_log/data/repositories/workout_log_repository.dart';

class RegisterWorkout {
  final WorkoutLogRepository repository;

  RegisterWorkout({required this.repository});

  Future<Either<Failure, WorkoutLogModel>> call(WorkoutLogModel workout){
    return repository.registerWorkout(workout);
  }

}
