import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class SchedaModelAdapter extends TypeAdapter<SchedaModel> {
  @override
  SchedaModel read(BinaryReader reader) {
    String readSafeString() {
      try {
        return reader.readString();
      } catch (_) {
        return '';
      }
    }

    int readSafeInt() {
      try {
        return reader.readInt();
      } catch (_) {
        return 0;
      }
    }

    List<ExerciseModel> readSafeList() {
      try {
        return (reader.readList()).cast<ExerciseModel>();
      } catch (_) {
        return <ExerciseModel>[];
      }
    }

    final id = readSafeString();
    final nome = readSafeString();
    final createdAtMillis = readSafeInt();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(
        createdAtMillis == 0 ? DateTime.now().millisecondsSinceEpoch : createdAtMillis);
    final esercizi = readSafeList();
    final categoryIndex = readSafeInt();
    final category = (categoryIndex >= 0 && categoryIndex < WorkoutCategory.values.length)
        ? WorkoutCategory.values[categoryIndex]
        : WorkoutCategory.strength;

    return SchedaModel(
      id: id,
      nome: nome,
      createdAt: createdAt,
      esercizi: esercizi,
      category: category,
    );
  }

  @override
  final int typeId = 0;

  @override
  void write(BinaryWriter writer, SchedaModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.nome);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeList(obj.esercizi);
    writer.writeInt(obj.category.index);
  }
}