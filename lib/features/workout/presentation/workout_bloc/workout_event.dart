import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object?> get props => [];
}

// Carica il workout corrente
class WourtkoutLoaded extends WorkoutEvent {
  const WourtkoutLoaded();
}

// Inizia un nuovo workout
class WourtkoutStarted extends WorkoutEvent {
  const WourtkoutStarted();
}

// Riprendi workout non completato
class WorkoutResumed extends WorkoutEvent {
  const WorkoutResumed();
}

// Salva workout
class WorkoutSaved extends WorkoutEvent {
  const WorkoutSaved();
}

// Crea un nuovo workout per un giorno specifico
class WorkoutCreated extends WorkoutEvent {
  final WorkoutModel workout;
  const WorkoutCreated(this.workout);

  @override
  List<Object?> get props => [workout];
}

class WorkoutOnDeleted extends WorkoutEvent {
  final WorkoutModel workout;
  const WorkoutOnDeleted(this.workout);

  @override
  List<Object?> get props => [workout];
}

// Segna esercizi come completo/non completo
class WorkoutExerciseToggled extends WorkoutEvent {
  final String exerciseId;
  const WorkoutExerciseToggled({required this.exerciseId});
}
