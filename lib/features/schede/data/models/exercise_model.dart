import 'package:scheda_palestra/core/back_up_service/back_up_abstract.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class ExerciseModel implements BackupableModel {
  final String id;
  final String name;
  final int series;
  final String? repetitions;
  final int? weight;
  final WorkoutCategory category;
  final String? description;
  final int? restTime;
  final int? time;
  final int? km;
  final int? elevation;

  ExerciseModel({
    required this.name,
    required this.series,
    required this.repetitions,
    required this.weight,
    this.description,
    required this.category,
    required this.restTime,
    required this.id,
    this.time,
    this.km,
    this.elevation,
  });

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "series": series,
    "repetitions": repetitions,
    "weight": weight,
    "category": category.name,
    "description": description,
    "restTime": restTime,
    "time": time,
    "km": km,
    "elevation": elevation,
  };

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    final repetitionsValue = json["repetitions"];

    return ExerciseModel(
      name: json["name"] ?? '',
      series: json["series"] ?? 0,
      repetitions: repetitionsValue == null ? null : repetitionsValue.toString(),
      weight: json["weight"],
      description: json["description"],
      category: WorkoutCategory.values.firstWhere(
        (e) => e.name == (json["category"] ?? ''),
        orElse: () => WorkoutCategory.strength,
      ),
      restTime: json["restTime"],
      id: json["id"] ?? '',
      time: json["time"],
      km: json["km"],
      elevation: json["elevation"],
    );
  }
}
