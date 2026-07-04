import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';

class ExerciseModelAdapter extends TypeAdapter<ExerciseModel> {
  @override
  final int typeId = 1;

  @override
  ExerciseModel read(BinaryReader reader) {
    return ExerciseModel(
      name: reader.readString(),
      series: reader.readInt(),
      repetitions: reader.readInt(),
      weight: reader.readInt(),
      targetMuscleGroup: TargetMuscleGroup.values[reader.readInt()],
      restTime: reader.readInt(), id: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseModel obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.series);
    writer.writeInt(obj.repetitions);
    writer.writeInt(obj.weight);
    writer.writeInt(obj.targetMuscleGroup.index);
    writer.writeInt(obj.restTime);
    writer.writeString(obj.id);
  }
}