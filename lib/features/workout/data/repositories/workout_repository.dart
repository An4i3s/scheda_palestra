import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

abstract class WorkoutRepository {
  Future<Either<Failure, WorkoutModel>> getCurrentWorkout();
  Future<Either<Failure, WorkoutModel>> saveWorkout(WorkoutModel workout);
  Future<Either<Failure, List<WorkoutModel>>> getAllWorkouts();
  Future<Either<Failure, WorkoutModel>> createWorkout(WorkoutModel workout);
   Future<Either<Failure, WorkoutModel>> toggleExercise(String exId);
}
