enum TargetMuscleGroup {
  chest,
  back,
  legs,
  shoulders,
  arms,
  core,
}

class ExerciseModel {
  final String id;
  final String name;
  final int series;
  final int repetitions;
  final int weight;
  final TargetMuscleGroup targetMuscleGroup;
  final int restTime;
  ExerciseModel({
    required this.name,
    required this.series,
    required this.repetitions,
    required this.weight,
    required this.targetMuscleGroup, required this.restTime, required this.id,
  });
}