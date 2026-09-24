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
  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "descrizione": descrizione,
        "createdAt": createdAt.toIso8601String(),
        "esercizi": esercizi.map((e) => e.toJson()).toList(),
        "category": category.name,
      };

    factory SchedaModel.fromJson(Map<String, dynamic> json){
      final created = json["createdAt"];
      DateTime parsedCreated;
      if (created is String) {
        parsedCreated = DateTime.parse(created);
      } else if (created is int) {
        parsedCreated = DateTime.fromMillisecondsSinceEpoch(created);
      } else {
        parsedCreated = DateTime.now();
      }

      final eserciziJson = json["esercizi"] as List?;
      final eserciziList = eserciziJson == null
          ? <ExerciseModel>[]
          : eserciziJson
              .whereType<Map<String, dynamic>>()
              .map((e) => ExerciseModel.fromJson(e))
              .toList();

      final categoryStr = json["category"] as String?;
      final category = WorkoutCategory.values.firstWhere(
          (c) => c.name == (categoryStr ?? ''),
          orElse: () => WorkoutCategory.strength);

      return SchedaModel(
        id: json["id"] ?? '',
        nome: json["nome"] ?? '',
        createdAt: parsedCreated,
        category: category,
        descrizione: json["descrizione"] ?? '',
        esercizi: eserciziList,
      );
    }
}