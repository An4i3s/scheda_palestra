import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

class WorkoutLogState extends Equatable{
  const WorkoutLogState();
  @override
  List<Object?> get props => [];
}

class WorkoutLogLoading extends WorkoutLogState{
  const WorkoutLogLoading();
}

class WorkoutLogLoaded extends WorkoutLogState{
  final List<WorkoutLogModel> workouts;
  const WorkoutLogLoaded({required this.workouts});
}


class WorkoutLogEmpty extends WorkoutLogState{
  const WorkoutLogEmpty();
}

class WorkoutLogError extends WorkoutLogState{
  const WorkoutLogError();
}

class WorkoutRegistered extends WorkoutLogState{
  const WorkoutRegistered();
}