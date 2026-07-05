import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';

abstract class ExercisesState extends Equatable {
  const ExercisesState();

  @override
  List<Object?> get props => [];
}

class ExercisesInitial extends ExercisesState {}

class ExercisesLoading extends ExercisesState {}

class ExercisesLoaded extends ExercisesState {
  final List<ExerciseModel> exercises;
  const ExercisesLoaded({required this.exercises});

  @override
  List<Object?> get props => [exercises];
}

class ExercisesError extends ExercisesState {
  final String message;
  const ExercisesError(this.message);

  @override
  List<Object?> get props => [message];
}
