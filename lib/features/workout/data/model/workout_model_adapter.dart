import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class WorkoutModelAdapter extends TypeAdapter<WorkoutModel> {
  @override
  final int typeId = 2;

  @override
  WorkoutModel read(BinaryReader reader) {
    return WorkoutModel(
      id: reader.readString(),
      completedExercises: (reader.readList()).cast<ExerciseModel>(),
      date: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      dayOfWeek: reader.readInt(),
      scheda: reader.read() as SchedaModel,
      completedExerciseIds: (reader.readList()).cast<String>().toSet(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutModel obj) {
    writer.writeString(obj.id);
    writer.writeList(obj.completedExercises);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeInt(obj.dayOfWeek);
    writer.write(obj.scheda);
    writer.writeList(obj.completedExerciseIds.toList());
  }
}
