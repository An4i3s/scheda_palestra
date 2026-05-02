import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercise_type_bloc.dart/exercises_type_events.dart';
import 'package:scheda_palestra/features/exercises/presentation/exercise_type_bloc.dart/exercises_type_state.dart';






typedef GetExercisesTypeFn = Future<Either<Failure, List<ExerciseTypeModel>>> Function();
typedef SaveExerciseTypeFn = Future<Either<Failure, ExerciseTypeModel>> Function(ExerciseTypeModel);
typedef DeleteExerciseTypeFn = Future<Either<Failure, void>> Function(String);

class ExerciseTypeBloc extends Bloc<ExerciseTypeEvent, ExercisesTypeState> {
  final Future<Either<Failure, List<ExerciseTypeModel>>> Function()  getExercisesTypes;
  Future<Either<Failure, ExerciseTypeModel>> Function(ExerciseTypeModel) saveExerciseType;
   Future<Either<Failure, void>> Function(String) deleteExerciseType;

  ExerciseTypeBloc({
    required this.getExercisesTypes,
    required this.saveExerciseType,
    required this.deleteExerciseType,
  }) : super(const ExercisesTypeInitial()) {
    on<ExerciseTypeStarted>(_onStarted);
    on<ExerciseTypeSaved>(_onSaved);
    on<ExerciseTypeDeleted>(_onDeleted);
  }

  Future<void> _onStarted(
    ExerciseTypeStarted event,
    Emitter<ExercisesTypeState> emit,
  ) async {
    emit(const ExercisesTypeLoading());
    final result = await getExercisesTypes();
    result.fold(
      (failure) => emit(ExercisesTypeError(failure.message)),
      (exercises) => emit(ExercisesTypeLoaded(exercises)),
    );
  }

  Future<void> _onSaved(
    ExerciseTypeSaved event,
    Emitter<ExercisesTypeState> emit,
  ) async {
    final result = await saveExerciseType(event.exercise);
    result.fold(
      (failure) => emit(ExercisesTypeError(failure.message)),
      (_) => add(const ExerciseTypeStarted()), // ricarica la lista
    );
  }

  Future<void> _onDeleted(
    ExerciseTypeDeleted event,
    Emitter<ExercisesTypeState> emit,
  ) async {
    final result = await deleteExerciseType(event.id);
    result.fold(
      (failure) => emit(ExercisesTypeError(failure.message)),
      (_) => add(const ExerciseTypeStarted()), // ricarica la lista
    );
  }
}