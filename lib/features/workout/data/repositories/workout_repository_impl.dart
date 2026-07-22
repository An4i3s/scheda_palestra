import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout/data/datasources/workout_local_datasource.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/data/repositories/workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutLocalDatasource datasource;

  WorkoutRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, WorkoutModel>> getCurrentWorkout() async {
    try {
      final workout = await datasource.getCurrentWorkout();
      return Right(workout);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkoutModel>> saveWorkout(WorkoutModel workout) async {
    try {
      final saved = await datasource.saveWorkout(workout);
      return Right(saved);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WorkoutModel>> createWorkout(WorkoutModel workout) async {
    try {
      final created = await datasource.createWorkout(workout);
      return Right(created);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<WorkoutModel>>> getAllWorkouts() async {
    try {
      final workouts = await datasource.getAllWorkouts();
      return Right(workouts);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, WorkoutModel>> toggleExercise(String exId) async{
    try{
      final toggled = await datasource.toggleExercise(exId);
      return Right(toggled);
    }
    catch(e){
      return Left(CacheFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> deleteWorkout(WorkoutModel workout) async{
    try{
      final deleted = await datasource.deleteWorkout(workout);
      return Right(deleted);
    }catch(e){
        return Left(CacheFailure(e.toString()));
    }
  }
}