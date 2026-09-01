import 'package:scheda_palestra/core/back_up_service/back_up_abstract.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class HomeModel extends BackupableModel{
  final int totalWorkouts;
  final String? lastWorkoutName;
  final List<WorkoutModel> weeklyAssignments;

  HomeModel({
    required this.totalWorkouts,
    this.lastWorkoutName,
    this.weeklyAssignments = const [],
  });
  
  @override
  Map<String, dynamic> toJson() => {
    "totalWorkouts":totalWorkouts,
    "lastWorkoutName": lastWorkoutName,
    "weeklyAssignments": weeklyAssignments.map((e) => e.toJson()).toList()
  };

  factory HomeModel.fromJson(Map<String, dynamic> json){
     final weeklyAssingmentJson = json["totalWorkouts"] as List?;
    final totalAssignements = weeklyAssingmentJson == null ? <WorkoutModel>[]: weeklyAssingmentJson.map((e) => WorkoutModel.fromJson(Map<String, dynamic>.from(e))).toList();
    return HomeModel(
      totalWorkouts:  json["totalWorkouts"],
      lastWorkoutName: json["lastWorkoutName"],
      weeklyAssignments: totalAssignements
      );
  }
}