import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class ExerciseModel {
  final String id;
  final String name;
  final int series;
  final int? repetitions;
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
    required this.category, required this.restTime, required this.id, this.time, this.km, this.elevation,
  });
}