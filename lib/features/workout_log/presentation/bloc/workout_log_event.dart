
import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

abstract class WorkoutLogEvent extends Equatable{
  const WorkoutLogEvent();

  @override
  List<Object?> get props => [];
}

class WorkoutLogOnLoad extends WorkoutLogEvent{
  const WorkoutLogOnLoad();
}

class WorkoutLogOnRegistered extends WorkoutLogEvent{
  final WorkoutLogModel workout;
  const WorkoutLogOnRegistered({required this.workout});
}