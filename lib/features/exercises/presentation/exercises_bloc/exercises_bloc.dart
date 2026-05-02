import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercises_bloc/exercises_events.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercises_bloc/exercises_state.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';





typedef GetExercisesFn = Future<Either<Failure, List<ExerciseModel>>> Function();
typedef SaveExerciseFn = Future<Either<Failure, ExerciseModel>> Function(ExerciseModel);
typedef DeleteExerciseFn = Future<Either<Failure, void>> Function(String);

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  final GetExercisesFn getExercises;
  final SaveExerciseFn saveExercise;
  final DeleteExerciseFn deleteExercise;

  ExercisesBloc({
    required this.getExercises,
    required this.saveExercise,
    required this.deleteExercise,
  }) : super(const ExercisesInitial()) {
    on<ExercisesStarted>(_onStarted);
    on<ExerciseSaved>(_onSaved);
    on<ExerciseDeleted>(_onDeleted);
  }

  Future<void> _onStarted(
    ExercisesStarted event,
    Emitter<ExercisesState> emit,
  ) async {
    emit(const ExercisesLoading());
    final result = await getExercises();
    result.fold(
      (failure) => emit(ExercisesError(failure.message)),
      (exercises) => emit(ExercisesLoaded(exercises)),
    );
  }

  Future<void> _onSaved(
    ExerciseSaved event,
    Emitter<ExercisesState> emit,
  ) async {
    final result = await saveExercise(event.exercise);
    result.fold(
      (failure) => emit(ExercisesError(failure.message)),
      (_) => add(const ExercisesStarted()), // ricarica la lista
    );
  }

  Future<void> _onDeleted(
    ExerciseDeleted event,
    Emitter<ExercisesState> emit,
  ) async {
    final result = await deleteExercise(event.id);
    result.fold(
      (failure) => emit(ExercisesError(failure.message)),
      (_) => add(const ExercisesStarted()), // ricarica la lista
    );
  }
}