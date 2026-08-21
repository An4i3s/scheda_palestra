import 'package:equatable/equatable.dart';

class HomeEvents extends Equatable{
  const HomeEvents();

  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvents {
  const HomeStarted();
}

class HomeCreateWorkout extends HomeEvents {
  final dynamic workout;
  const HomeCreateWorkout(this.workout);

  @override
  List<Object?> get props => [workout];
}

class HomeDeleteWorkout extends HomeEvents {
  final dynamic workout;
  const HomeDeleteWorkout(this.workout);

  @override
  List<Object?> get props => [workout];
}

