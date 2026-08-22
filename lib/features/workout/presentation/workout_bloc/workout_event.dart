import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

abstract class WorkoutEvent extends Equatable{
  const WorkoutEvent();

  @override
  List<Object?> get props => [];
}
//Carica il workout corrente
class WourtkoutLoaded extends WorkoutEvent {
  const WourtkoutLoaded();
}

class WourtkoutUpdated extends WorkoutEvent {
  final WorkoutModel workoutModel;
  const WourtkoutUpdated({required this.workoutModel});
}


//Inizia un nuovo workout
class WourtkoutInitial extends WorkoutEvent {
  const WourtkoutInitial();
}

//Riprendi workout non completato
class WorkoutResumed extends WorkoutEvent{
  const WorkoutResumed();
}

//Salva workout
class WorkoutSaved extends WorkoutEvent{
  const WorkoutSaved();
}

//Crea un nuovo workout per un giorno specifico
class WorkoutCreated extends WorkoutEvent {
  final WorkoutModel workout;
  const WorkoutCreated(this.workout);

  @override
  List<Object?> get props => [workout];
}

class WorkoutExerciseToggled extends WorkoutEvent {
  final WorkoutModel workout;
  final String exerciseId;
  const WorkoutExerciseToggled({ required this.workout, required this.exerciseId,});

  @override
  List<Object?> get props => [exerciseId];
}

class WorkoutOnDeleted extends WorkoutEvent {
  final WorkoutModel workout;
  const WorkoutOnDeleted(this.workout);

  @override
  List<Object?> get props => [workout];
}

// Silent delete: perform deletion but avoid emitting UI-loading states immediately.
class WorkoutDeleteSilent extends WorkoutEvent {
  final WorkoutModel workout;
  const WorkoutDeleteSilent(this.workout);

  @override
  List<Object?> get props => [workout];
}

class WorkoutOnCompleted extends WorkoutEvent {
  final WorkoutModel workout;
  const WorkoutOnCompleted(this.workout);

  @override
  List<Object?> get props => [workout];
}


class WorkoutOnSuccess extends WorkoutEvent {
  final WorkoutModel workout;
  const WorkoutOnSuccess(this.workout);

  @override
  List<Object?> get props => [workout];
}



