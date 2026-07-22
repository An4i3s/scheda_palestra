import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object?> get props => [];
}

class WorkoutInitial extends WorkoutState{
  const WorkoutInitial(); 
}

class WorkoutLoading extends WorkoutState {
  const WorkoutLoading();
}

class WorkoutLoaded extends WorkoutState {
  final WorkoutModel workout;
  const WorkoutLoaded(this.workout);

  @override
  List<Object?> get props => [workout];
}

class WorkoutEmpty extends WorkoutState {
  const WorkoutEmpty();
}


class WorkoutInProgress extends WorkoutState{
  const WorkoutInProgress(); 
}

class WorkoutDeleted extends WorkoutState{
  const WorkoutDeleted(); 
}


class WorkoutRegistered extends WorkoutState{
  const WorkoutRegistered(); 
}

class WorkoutError extends WorkoutState {
  final String message;
  const WorkoutError(this.message);

  @override
  List<Object?> get props => [message];
}

