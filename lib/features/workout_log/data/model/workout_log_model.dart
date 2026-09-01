import 'package:scheda_palestra/core/back_up_service/back_up_abstract.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class WorkoutLogModel implements BackupableModel{
  final String id;
  final WorkoutModel workout;
  final DateTime date;

  WorkoutLogModel({required this.id, required this.workout, required this.date});
  
  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "workout": workout.toJson(),
        "date": date.toIso8601String(),
      };

    factory WorkoutLogModel.fromJson(Map<String, dynamic> json){
      final workoutJson = json["workout"] as Map<String, dynamic>;
      final dateVal = json["date"];
      final parsedDate = dateVal is String
          ? DateTime.parse(dateVal)
          : (dateVal is int ? DateTime.fromMillisecondsSinceEpoch(dateVal) : DateTime.now());

      return WorkoutLogModel(
        id: json["id"] ?? '',
        workout: WorkoutModel.fromJson(Map<String, dynamic>.from(workoutJson)),
        date: parsedDate,
      );
    }
}