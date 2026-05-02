import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

abstract class SchedaState extends Equatable {
  const SchedaState();

  @override
  List<Object?> get props => [];
}

class SchedeInitial extends SchedaState {
  const SchedeInitial();
}

class SchedeLoading extends SchedaState {
  const SchedeLoading();
}

class SchedeLoaded extends SchedaState {
  final List<SchedaModel> schede;
  const SchedeLoaded(this.schede);

  @override
  List<Object?> get props => [schede];
}

class SchedeError extends SchedaState {
  final String message;
  const SchedeError(this.message);

  @override
  List<Object?> get props => [message];
}