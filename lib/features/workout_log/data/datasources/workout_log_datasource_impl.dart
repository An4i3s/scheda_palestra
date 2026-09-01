import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/core/utils/logger.dart';
import 'package:scheda_palestra/features/workout_log/data/datasources/workout_log_datasource.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

class WorkoutLogDatasourceImpl implements WorkoutLogDatasource{

    static const _boxName = 'workout_logs';


  Future<Box<WorkoutLogModel>> get _box async =>
      Hive.isBoxOpen(_boxName)
          ? Hive.box<WorkoutLogModel>(_boxName)
          : await Hive.openBox<WorkoutLogModel>(_boxName);

  @override
  Future<List<WorkoutLogModel>> getPastWorkouts() async{
    try{
      final box = await _box;
      final all = box.values.whereType<WorkoutLogModel>().toList();
      return all;
    }catch(e){
    Logger.error('WorkoutLogDatasourceImpl', 'Errore caricamento past workout: $e');
    rethrow;
    }
  }
  
  @override
  Future<WorkoutLogModel> registerWorkout(WorkoutLogModel workoutlog) async{
    try{
      final box = await _box;
      await box.put(workoutlog.id, workoutlog);
      return workoutlog;
    }catch(e){
      rethrow;
    }
  }
}