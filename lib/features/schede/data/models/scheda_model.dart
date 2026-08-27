import 'package:scheda_palestra/core/back_up_service/back_up_abstract.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';

enum WorkoutCategory {
  strength,
  ruuning,
  walking,
  cycling,
  swimming,
  pilates,
  yoga,
  crossfit,
}

class SchedaModel extends BackupableModel{
  final String id;

  final String nome;

  final String descrizione;

  final DateTime createdAt;

  final List<ExerciseModel> esercizi;

  final WorkoutCategory category;

  SchedaModel({
    required this.id,
    required this.nome,
    this.descrizione = '',
    required this.createdAt,
    this.esercizi = const [],
    required this.category,
  });

  SchedaModel copyWith({
    String? id,
    String? nome,
    String? descrizione,
    DateTime? createdAt,
    List<ExerciseModel>? esercizi,
    WorkoutCategory? category,
  }) {
    return SchedaModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descrizione: descrizione ?? this.descrizione,
      createdAt: createdAt ?? this.createdAt,
      esercizi: esercizi ?? this.esercizi,
      category: category ?? this.category,
    );
  }
  
  @override
  Map<String, dynamic> toJson() => {"id": id, "nome":nome, "descrizione":descrizione, "createdAt": createdAt, "esercizi": esercizi, "category":category};

    factory SchedaModel.fromJson(Map<String, dynamic> json){
      return SchedaModel(id: json["id"], nome: json["nome"], createdAt: json["createdAt"], category: json["category"], descrizione: json["descrizione"]);
    }
}