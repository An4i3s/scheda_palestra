
import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout_log/data/datasources/workout_log_datasource_impl.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';
import 'package:scheda_palestra/features/workout_log/data/repositories/workout_log_repository.dart';

class WorkoutLogRepositoryImpl implements WorkoutLogRepository{
   final WorkoutLogDatasourceImpl datasource;

  WorkoutLogRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<WorkoutLogModel>>> getPastWorkouts() async{
        try {
      final workouts = await datasource.getPastWorkouts();
      return Right(workouts);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, WorkoutLogModel>> registerWorkout(WorkoutLogModel workout) async{
         try {
      final workouts = await datasource.registerWorkout(workout);
      return Right(workouts);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}