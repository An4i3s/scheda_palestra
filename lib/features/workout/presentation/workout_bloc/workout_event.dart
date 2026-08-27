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



