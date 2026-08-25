import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

class WorkoutLogModelAdapter extends TypeAdapter<WorkoutLogModel>{
  @override
  final int typeId = 3;

  @override
  WorkoutLogModel read(BinaryReader reader) {
    return WorkoutLogModel(id: reader.readString(), workout: reader.read() as WorkoutModel, date: reader.read() as DateTime);
  }



  @override
  void write(BinaryWriter writer, WorkoutLogModel obj) {
    writer.writeString(obj.id);
    writer.write(obj.workout);
    writer.write(obj.date);
  }
}