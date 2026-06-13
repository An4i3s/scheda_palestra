import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class ExerciseModelAdapter extends TypeAdapter<ExerciseModel> {
  @override
  final int typeId = 1;

  @override
  ExerciseModel read(BinaryReader reader) {
    int readSafeInt() {
      try {
        return reader.readInt();
      } catch (_) {
        return 0;
      }
    }

    return ExerciseModel(
      name: reader.readString(),
      series: reader.readInt(),
      repetitions: readSafeInt(),
      weight: readSafeInt(),
      category: WorkoutCategory.values[reader.readInt()],
      restTime: readSafeInt(),
      id: reader.readString(),
      time: readSafeInt(),
      km: readSafeInt(),
      elevation: readSafeInt(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseModel obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.series);
    writer.writeInt(obj.repetitions??0);
    writer.writeInt(obj.weight??0);
    writer.writeInt(obj.category.index);
    writer.writeInt(obj.restTime??0);
    writer.writeString(obj.id);
    writer.writeInt(obj.time??0);
    writer.writeInt(obj.km??0);
    writer.writeInt(obj.elevation??0);
  }
}