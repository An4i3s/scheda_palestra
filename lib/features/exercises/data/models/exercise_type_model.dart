import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';

class ExerciseTypeModel {
  final String id;
  final String name;
  final TargetMuscleGroup targetMuscleGroup;

  ExerciseTypeModel({
    required this.id,
    required this.name, required this.targetMuscleGroup,
  });
}