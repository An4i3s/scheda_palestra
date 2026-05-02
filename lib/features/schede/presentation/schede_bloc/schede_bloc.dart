import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_events.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_state.dart';



typedef GetSchedeFn = Future<Either<Failure, List<SchedaModel>>> Function();
typedef SaveSchedaFn = Future<Either<Failure, SchedaModel>> Function(SchedaModel);
typedef DeleteSchedaFn = Future<Either<Failure, void>> Function(String);

class SchedeBloc extends Bloc<SchedeEvent, SchedaState> {
  final GetSchedeFn getSchede;
  final SaveSchedaFn saveScheda;
  final DeleteSchedaFn deleteScheda;

  SchedeBloc({
    required this.getSchede,
    required this.saveScheda,
    required this.deleteScheda,
  }) : super(const SchedeInitial()) {
    on<SchedeStarted>(_onStarted);
    on<SchedaSaved>(_onSaved);
    on<SchedaDeleted>(_onDeleted);
  }

  Future<void> _onStarted(
    SchedeStarted event,
    Emitter<SchedaState> emit,
  ) async {
    emit(const SchedeLoading());
    final result = await getSchede();
    result.fold(
      (failure) => emit(SchedeError(failure.message)),
      (schede) => emit(SchedeLoaded(schede)),
    );
  }

  Future<void> _onSaved(
    SchedaSaved event,
    Emitter<SchedaState> emit,
  ) async {
    final result = await saveScheda(event.scheda);
    result.fold(
      (failure) => emit(SchedeError(failure.message)),
      (_) => add(const SchedeStarted()), // ricarica la lista
    );
  }

  Future<void> _onDeleted(
    SchedaDeleted event,
    Emitter<SchedaState> emit,
  ) async {
    final result = await deleteScheda(event.id);
    result.fold(
      (failure) => emit(SchedeError(failure.message)),
      (_) => add(const SchedeStarted()), // ricarica la lista
    );
  }
}