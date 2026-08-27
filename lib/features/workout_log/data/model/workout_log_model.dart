import 'package:scheda_palestra/core/back_up_service/back_up_abstract.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class WorkoutLogModel implements BackupableModel{
  final String id;
  final WorkoutModel workout;
  final DateTime date;

  WorkoutLogModel({required this.id, required this.workout, required this.date});
  
  @override
  Map<String, dynamic> toJson() => {"id": id, "workout":workout, "date": date };

    factory WorkoutLogModel.fromJson(Map<String, dynamic> json){
      return WorkoutLogModel(id: json["id"], workout: json["workout"], date: json["date"]);
    }
}