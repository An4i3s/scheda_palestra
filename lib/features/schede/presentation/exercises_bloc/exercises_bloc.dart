import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/presentation/exercises_bloc/exercises_events.dart';
import 'package:scheda_palestra/features/schede/presentation/exercises_bloc/exercises_state.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';





typedef GetExercisesFn = Future<Either<Failure, List<ExerciseModel>>> Function();
typedef SaveExerciseFn = Future<Either<Failure, ExerciseModel>> Function(ExerciseModel);

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  final GetExercisesFn getExercises;
  final SaveExerciseFn saveExercise;

  ExercisesBloc({
    required this.getExercises,
    required this.saveExercise,
  }) : super(const ExercisesInitial()) {
    on<ExercisesStarted>(_onStarted);
    on<ExerciseSaved>(_onSaved);
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

}