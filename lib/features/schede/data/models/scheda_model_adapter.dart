import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class SchedaModelAdapter extends TypeAdapter<SchedaModel> {
  @override
  SchedaModel read(BinaryReader reader) {
    return SchedaModel(
      id: reader.readString(),
      nome: reader.readString(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      esercizi: (reader.readList()).cast<ExerciseModel>(),
      category: WorkoutCategory.values[reader.readInt()],
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