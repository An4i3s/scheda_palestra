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


class WorkoutDeleted extends WorkoutState{
  final int? dayOfWeek;
  final String? id;
  const WorkoutDeleted({this.dayOfWeek, this.id}); 

  @override
  List<Object?> get props => [dayOfWeek, id];
}


//TODO IMPROVE
class WorkoutMutationCompleted extends WorkoutState {
  final int? dayOfWeek;
  final String? id;
  const WorkoutMutationCompleted({this.dayOfWeek, this.id});

  @override
  List<Object?> get props => [dayOfWeek, id];
}

class WorkoutError extends WorkoutState {
  final String message;
  const WorkoutError(this.message);

  @override
  List<Object?> get props => [message];
}

class WorkoutCompleted extends WorkoutState{
  final WorkoutModel workout;
  const WorkoutCompleted({required this.workout}); 
}


class WorkoutSuccess extends WorkoutState{
  final WorkoutModel workout;
  const WorkoutSuccess({required this.workout}); 
}
