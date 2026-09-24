import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

class WorkoutLogModelAdapter extends TypeAdapter<WorkoutLogModel>{
  @override
  final int typeId = 3;

  @override
  WorkoutLogModel read(BinaryReader reader) {
    try {
      final id = reader.readString();
      final workoutValue = reader.read();
      final workout = workoutValue is WorkoutModel
          ? workoutValue
          : WorkoutModel(
              id: '',
              completedExercises: const [],
              dayOfWeek: 0,
              scheda: SchedaModel(
                id: '',
                nome: '',
                createdAt: DateTime.fromMillisecondsSinceEpoch(0),
                category: WorkoutCategory.strength,
              ),
            );

      final dateValue = reader.read();
      final date = dateValue is DateTime
          ? dateValue
          : DateTime.fromMillisecondsSinceEpoch(0);

      return WorkoutLogModel(id: id, workout: workout, date: date);
    } catch (_) {
      return WorkoutLogModel(
        id: '',
        workout: WorkoutModel(
          id: '',
          completedExercises: const [],
          dayOfWeek: 0,
          scheda: SchedaModel(
            id: '',
            nome: '',
            createdAt: DateTime.fromMillisecondsSinceEpoch(0),
            category: WorkoutCategory.strength,
          ),
        ),
        date: DateTime.fromMillisecondsSinceEpoch(0),
      );
    }
  }



  @override
  void write(BinaryWriter writer, WorkoutLogModel obj) {
    writer.writeString(obj.id);
    writer.write(obj.workout);
    writer.write(obj.date);
  }
}