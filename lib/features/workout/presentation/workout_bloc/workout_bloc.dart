import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_state.dart';

typedef GetCurrentWorkoutFn = Future<Either<Failure, WorkoutModel>>  Function();
typedef SaveWorkoutFn = Future<Either<Failure, WorkoutModel>> Function(WorkoutModel);
typedef DeletWorkoutFn = Future<Either<Failure, bool>> Function(WorkoutModel);
typedef GetAllWorkoutsFn = Future<Either<Failure, List<WorkoutModel>>> Function();
typedef CreateWorkoutFn = Future<Either<Failure, WorkoutModel>> Function(WorkoutModel);
typedef ToggleExerciseFn = Future<Either<Failure, WorkoutModel>> Function(String id);

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState>{
  final GetCurrentWorkoutFn getCurrentWorkout;
  final SaveWorkoutFn saveWorkoutFn;
  final DeletWorkoutFn deletWorkoutFn;
  final GetAllWorkoutsFn getAllWorkoutsFn;
  final CreateWorkoutFn createWorkoutFn;
  final ToggleExerciseFn toggleExerciseFn;

  WorkoutBloc({
    required this.getCurrentWorkout,
    required this.saveWorkoutFn,
    required this.getAllWorkoutsFn,
    required this.createWorkoutFn, 
    required this.toggleExerciseFn,
    required this.deletWorkoutFn
  }):super(const WorkoutInitial()){
    on<WourtkoutLoaded>(_onLoaded);
    on<WourtkoutStarted>(_onStarted);
    on<WorkoutCreated>(_onCreated);
    on<WorkoutExerciseToggled>(_onExToggled);
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


  Future<void> _onDeleted(
    WorkoutOnDeleted event,
    Emitter<WorkoutState> emit,
  ) async {
    emit(const WorkoutLoading());
    final result = await deletWorkoutFn(event.workout);
    result.fold(
      (failure) => emit(WorkoutError(failure.message)),
      (workout) => emit(WorkoutDeleted()),
    );
  }

  Future<void> _onExToggled(
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
}