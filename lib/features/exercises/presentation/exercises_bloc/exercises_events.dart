

import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';

abstract class ExercisesEvent extends Equatable {
  const ExercisesEvent();

  @override
  List<Object?> get props => [];
}

/// Carica la lista delle schede all'avvio della pagina.
class ExercisesStarted extends ExercisesEvent {
  const ExercisesStarted();
}

/// Salva (crea o aggiorna) una scheda.
class ExerciseSaved extends ExercisesEvent {
  final ExerciseModel exercise;
  const ExerciseSaved(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

/// Elimina una scheda tramite id.
class ExerciseDeleted extends ExercisesEvent {
  final String id;
  const ExerciseDeleted(this.id);

  @override
  List<Object?> get props => [id];
}