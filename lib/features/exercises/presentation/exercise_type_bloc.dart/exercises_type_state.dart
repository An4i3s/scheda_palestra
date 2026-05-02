import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model.dart';

abstract class ExercisesTypeState extends Equatable {
  const ExercisesTypeState();

  @override
  List<Object?> get props => [];
}

class ExercisesTypeInitial extends ExercisesTypeState {
  const ExercisesTypeInitial();
}

class ExercisesTypeLoading extends ExercisesTypeState {
  const ExercisesTypeLoading();
}

class ExercisesTypeLoaded extends ExercisesTypeState {
  final List<ExerciseTypeModel> exercises;
  const ExercisesTypeLoaded(this.exercises);

  @override
  List<Object?> get props => [exercises];
}

class ExercisesTypeError extends ExercisesTypeState {
  final String message;
  const ExercisesTypeError(this.message);

  @override
  List<Object?> get props => [message];
}