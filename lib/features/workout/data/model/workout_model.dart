import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class WorkoutModel {
  final String id;
  final List<ExerciseModel> completedExercises;
  // final DateTime date;
  final int dayOfWeek;
  final SchedaModel scheda;
  final Set<String> completedExerciseIds;
  final bool isCompleted;

  WorkoutModel({
    required this.id,
    required this.completedExercises,
    // required this.date,
    required this.dayOfWeek,
    required this.scheda,
    this.completedExerciseIds = const {},
    this.isCompleted = false,
  });

  bool isExerciseCompleted(String exerciseId) {
    return completedExerciseIds.contains(exerciseId);
  }

  WorkoutModel copyWith({
    String? id,
    List<ExerciseModel>? completedExercises,
    DateTime? date,
    int? dayOfWeek,
    SchedaModel? scheda,
    Set<String>? completedExerciseIds,
    bool? isCompleted,
  }) {
    return WorkoutModel(
      id: id ?? this.id,
      completedExercises: completedExercises ?? this.completedExercises,
      // date: date ?? this.date,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      scheda: scheda ?? this.scheda,
      completedExerciseIds: completedExerciseIds ?? this.completedExerciseIds,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  WorkoutModel markCompleted() {
    return copyWith(isCompleted: true);
  }

  WorkoutModel markExerciseCompleted(String exerciseId) {
    final updated = Set<String>.from(completedExerciseIds);
    updated.add(exerciseId);
    return copyWith(completedExerciseIds: updated);
  }

  WorkoutModel unmarkExerciseCompleted(String exerciseId) {
    final updated = Set<String>.from(completedExerciseIds);
    updated.remove(exerciseId);
    return copyWith(completedExerciseIds: updated);
  }

  @override
  String toString() => 'WorkoutModel(id=$id, dayOfWeek=$dayOfWeek, isCompleted=$isCompleted, completed=${completedExerciseIds.length})';
}