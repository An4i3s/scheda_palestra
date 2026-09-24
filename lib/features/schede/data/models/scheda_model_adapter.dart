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
        final raw = reader.readList();
        return raw
            .where((e) => e != null)
            .map((e) {
              if (e is ExerciseModel) return e;
              if (e is Map) return ExerciseModel.fromJson(Map<String, dynamic>.from(e));
              return null;
            })
            .whereType<ExerciseModel>()
            .toList();
      } catch (_) {
        return const <ExerciseModel>[];
      }
    }

    final id = readSafeString();
    final nome = readSafeString();
    final descrizione = readSafeString();
    final createdAtMillis = readSafeInt();
    final createdAt = DateTime.fromMillisecondsSinceEpoch(
        createdAtMillis == 0 ? 0 : createdAtMillis);
    final esercizi = readSafeList();
    final categoryIndex = readSafeInt();
    final category = (categoryIndex >= 0 && categoryIndex < WorkoutCategory.values.length)
        ? WorkoutCategory.values[categoryIndex]
        : WorkoutCategory.strength;

    return SchedaModel(
      id: id,
      nome: nome,
      descrizione: descrizione,
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
    writer.writeString(obj.descrizione);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeList(obj.esercizi);
    writer.writeInt(obj.category.index);
  }
}