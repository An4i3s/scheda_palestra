import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model.dart';

class ExerciseTypeModelAdapter extends TypeAdapter<ExerciseTypeModel> {
  @override
  final int typeId = 2;

  @override
  ExerciseTypeModel read(BinaryReader reader) {
    return ExerciseTypeModel(
      name: reader.readString(),
      targetMuscleGroup: TargetMuscleGroup.values[reader.readInt()], id: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseTypeModel obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.targetMuscleGroup.index);
    writer.writeString(obj.id);
  }
} 