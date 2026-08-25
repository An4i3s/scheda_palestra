import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

abstract class WorkoutLogRepository {
    Future<Either<Failure, List<WorkoutLogModel>>> getPastWorkouts();
    Future<Either<Failure, WorkoutLogModel>> registerWorkout(WorkoutLogModel workout);
}