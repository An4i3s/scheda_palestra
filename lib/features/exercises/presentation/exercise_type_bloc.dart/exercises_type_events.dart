

import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model.dart';

abstract class ExerciseTypeEvent extends Equatable {
  const ExerciseTypeEvent();

  @override
  List<Object?> get props => [];
}

/// Carica la lista delle schede all'avvio della pagina.
class ExerciseTypeStarted extends ExerciseTypeEvent {
  const ExerciseTypeStarted();
}

/// Salva (crea o aggiorna) una scheda.
class ExerciseTypeSaved extends ExerciseTypeEvent {
  final ExerciseTypeModel exercise;
  const ExerciseTypeSaved(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

/// Elimina una scheda tramite id.
class ExerciseTypeDeleted extends ExerciseTypeEvent {
  final String id;
  const ExerciseTypeDeleted(this.id);

  @override
  List<Object?> get props => [id];
}