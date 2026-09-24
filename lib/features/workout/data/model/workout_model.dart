import 'package:scheda_palestra/core/back_up_service/back_up_abstract.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class WorkoutModel implements BackupableModel{
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

    @override
      Map<String, dynamic> toJson() => {
        "id": id,
        "completedExercises": completedExercises.map((e) => e.toJson()).toList(),
        "dayOfWeek": dayOfWeek,
        "scheda": scheda.toJson(),
        "completedExerciseIds": completedExerciseIds.toList(),
        "isCompleted": isCompleted,
      };

      factory WorkoutModel.fromJson(Map<String, dynamic> json){
        final completedJson = json["completedExercises"] as List?;
        final completedExercises = completedJson == null
        ? <ExerciseModel>[]
        : completedJson
            .whereType<Map<String, dynamic>>()
            .map((e) => ExerciseModel.fromJson(e))
            .toList();

        final schedaJson = json["scheda"] as Map<String, dynamic>?;
        final scheda = schedaJson == null ? throw ArgumentError('scheda missing') : SchedaModel.fromJson(Map<String, dynamic>.from(schedaJson));

        final completedIdsJson = json["completedExerciseIds"] as List?;
        final completedIds = completedIdsJson == null ? <String>{} : completedIdsJson.map((e) => e.toString()).toSet();

        return WorkoutModel(
          id: json["id"] ?? '',
          completedExercises: completedExercises,
          dayOfWeek: json["dayOfWeek"] ?? 0,
          scheda: scheda,
          completedExerciseIds: completedIds,
          isCompleted: json["isCompleted"] == true,
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