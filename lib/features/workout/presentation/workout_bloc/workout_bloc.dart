import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_state.dart';

typedef GetCurrentWorkoutFn = Future<Either<Failure, WorkoutModel>>  Function();
typedef SaveWorkoutFn = Future<Either<Failure, WorkoutModel>> Function(WorkoutModel);
typedef GetAllWorkoutsFn = Future<Either<Failure, List<WorkoutModel>>> Function();
typedef CreateWorkoutFn = Future<Either<Failure, WorkoutModel>> Function(WorkoutModel);
typedef ToggleExerciseFn = Future<Either<Failure, WorkoutModel>> Function(String exerciseId);
typedef DeleteWorkoutFn = Future<Either<Failure, bool>> Function(WorkoutModel workout);

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState>{
  final GetCurrentWorkoutFn getCurrentWorkout;
  final SaveWorkoutFn saveWorkoutFn;
  final GetAllWorkoutsFn getAllWorkoutsFn;
  final CreateWorkoutFn createWorkoutFn;
  final ToggleExerciseFn toggleExerciseFn;
  final DeleteWorkoutFn deleteWorkoutFn;

  WorkoutBloc({
    required this.getCurrentWorkout,
    required this.saveWorkoutFn,
    required this.getAllWorkoutsFn,
    required this.createWorkoutFn,
    required this.toggleExerciseFn,
    required this.deleteWorkoutFn,
  }):super(const WorkoutInitial()){
    on<WourtkoutLoaded>(_onLoaded);
    on<WourtkoutStarted>(_onStarted);
    on<WorkoutCreated>(_onCreated);
    on<WorkoutExerciseToggled>(_onExerciseToggled);
    on<WorkoutOnDeleted>(_onDeleted);

    // on<WorkoutSaved>(_onSaved);
    // on<WorkoutResumed>(_onResumed)
  }

  Future<void> _onLoaded(
    WourtkoutLoaded event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(const WorkoutLoading());
    final result = await getCurrentWorkout();
    result.fold(
      (failure) {
        if (failure.message.contains('Nessun')) {
          emit(const WorkoutEmpty());
        } else {
          emit(WorkoutError(failure.message));
        }
      },
      (workout) => emit(WorkoutLoaded(workout)),
    );
  }

    Future<void> _onStarted(
    WourtkoutStarted event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(const WorkoutInProgress());
    final result = await getCurrentWorkout();
    result.fold(
      (failure) => emit(WorkoutError(failure.message)),
      (workout) => emit(WorkoutRegistered()),
    );
  }

  Future<void> _onCreated(
    WorkoutCreated event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(const WorkoutLoading());
    final result = await createWorkoutFn(event.workout);
    result.fold(
      (failure) => emit(WorkoutError(failure.message)),
      (workout) => emit(WorkoutLoaded(workout)),
    );
  }

  Future<void> _onExerciseToggled(
    WorkoutExerciseToggled event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(const WorkoutLoading());
    final result = await toggleExerciseFn(event.exerciseId);
    result.fold(
      (failure) => emit(WorkoutError(failure.message)),
      (workout) => emit(WorkoutLoaded(workout)),
    );
  }

  Future<void> _onDeleted(
    WorkoutOnDeleted event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(const WorkoutLoading());
    final result = await deleteWorkoutFn(event.workout);
    result.fold(
      (failure) => emit(WorkoutError(failure.message)),
      (_) => emit(const WorkoutDeleted()),
    );
  }
}