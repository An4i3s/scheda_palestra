import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';

enum WorkoutCategory {
  strength,
  cardio,
  endurance,
  flexibility,
}

class SchedaModel  {
  final String id;

  final String nome;

  final DateTime createdAt;

  final List<ExerciseModel> esercizi;

  final WorkoutCategory category;

  SchedaModel({
    required this.id,
    required this.nome,
    required this.createdAt,
    this.esercizi = const [], required this.category,
  });

  SchedaModel copyWith({
    String? id,
    String? nome,
    DateTime? createdAt,
    List<ExerciseModel>? esercizi,
    WorkoutCategory? category,
  }) {
    return SchedaModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      createdAt: createdAt ?? this.createdAt,
      esercizi: esercizi ?? this.esercizi, category: category ?? this.category,
    );
  }
}