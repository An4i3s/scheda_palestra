import 'package:equatable/equatable.dart';

abstract class ExercisesEvent extends Equatable {
  const ExercisesEvent();

  @override
  List<Object?> get props => [];
}

class ExercisesStarted extends ExercisesEvent {
  const ExercisesStarted();
}
