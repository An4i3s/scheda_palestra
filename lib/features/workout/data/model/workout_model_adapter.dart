import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class WorkoutModelAdapter extends TypeAdapter<WorkoutModel> {
  @override
  final int typeId = 2;

  @override
  WorkoutModel read(BinaryReader reader) {
    final id = reader.readString();

    final completed = reader.readList();
    final completedExercises = completed
        .where((e) => e != null)
        .map((e) {
          if (e is ExerciseModel) return e;
          if (e is Map) return ExerciseModel.fromJson(Map<String, dynamic>.from(e));
          return null;
        })
        .whereType<ExerciseModel>()
        .toList();

    final dayOfWeek = reader.readInt();

    final schedaValue = reader.read();
    final scheda = schedaValue is SchedaModel
        ? schedaValue
        : SchedaModel(
            id: '',
            nome: '',
            createdAt: DateTime.fromMillisecondsSinceEpoch(0),
            category: WorkoutCategory.strength,
          );

    final completedIds = reader.readList();
    final completedExerciseIds = completedIds
        .where((e) => e != null)
        .map((e) => e.toString())
        .toSet();

    final isCompleted = reader.readBool();

    return WorkoutModel(
      id: id,
      completedExercises: completedExercises,
      dayOfWeek: dayOfWeek,
      scheda: scheda,
      completedExerciseIds: completedExerciseIds,
      isCompleted: isCompleted,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutModel obj) {
    writer.writeString(obj.id);
    writer.writeList(obj.completedExercises);
    writer.writeInt(obj.dayOfWeek);
    writer.write(obj.scheda);
    writer.writeList(obj.completedExerciseIds.toList());
    writer.writeBool(obj.isCompleted);
  }
}
