 
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/core/utils/logger.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_state.dart';

typedef GetCurrentWorkoutFn = Future<Either<Failure, WorkoutModel>>  Function();
typedef SaveWorkoutFn = Future<Either<Failure, WorkoutModel>> Function(WorkoutModel);
typedef GetAllWorkoutsFn = Future<Either<Failure, List<WorkoutModel>>> Function();
typedef CreateWorkoutFn = Future<Either<Failure, WorkoutModel>> Function(WorkoutModel);
typedef ToggleExerciseFn = Future<Either<Failure, WorkoutModel>> Function(WorkoutModel workout, String exerciseId);
typedef DeleteWorkoutFn = Future<Either<Failure, bool>> Function(WorkoutModel workout);
typedef CompleteWorkoutFn = Future<Either<Failure, bool>> Function(WorkoutModel workout);

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState>{
  final GetCurrentWorkoutFn getCurrentWorkout;
  final SaveWorkoutFn saveWorkoutFn;
  final GetAllWorkoutsFn getAllWorkoutsFn;
  final CreateWorkoutFn createWorkoutFn;
  final ToggleExerciseFn toggleExerciseFn;
  final DeleteWorkoutFn deleteWorkoutFn;
  final CompleteWorkoutFn completeWorkoutFn;

  WorkoutBloc({
    required this.getCurrentWorkout,
    required this.saveWorkoutFn,
    required this.getAllWorkoutsFn,
    required this.createWorkoutFn,
    required this.toggleExerciseFn,
    required this.deleteWorkoutFn, required this.completeWorkoutFn,
  }):super(const WorkoutInitial()){
    on<WourtkoutLoaded>(_onLoaded);
    on<WourtkoutUpdated>(_onUpdated);
    // on<WourtkoutStarted>((){});
    on<WorkoutExerciseToggled>(_onExerciseToggled);
    on<WorkoutOnDeleted>(_onDeleted);
    on<WorkoutOnCompleted>(_onCompleted);

    // on<WorkoutSaved>(_onSaved);
    // on<WorkoutResumed>(_onResumed)
  }


  Future<void> _onLoaded(
    WourtkoutLoaded event,
    Emitter<WorkoutState> emit,
  ) async {
    Logger.info('WorkoutBloc', 'emit WorkoutLoading');
    emit(const WorkoutLoading());
    final result = await getCurrentWorkout();
    result.fold(
      (failure) {
        if (failure.message.contains('Nessun')) {
          Logger.info('WorkoutBloc', 'emit WorkoutEmpty');
          emit(const WorkoutEmpty());
        } else {
          Logger.info('WorkoutBloc', 'emit WorkoutError: ${failure.message}');
          emit(WorkoutError(failure.message));
        }
      },
      (workout) async {
        Logger.info('WorkoutBloc', 'emit WorkoutLoaded: id=${workout.id}');
        emit(WorkoutLoaded(workout));
      },
    );
  }




  Future<void> _onExerciseToggled(
    WorkoutExerciseToggled event,
    Emitter<WorkoutState> emit,
  ) async {
    // Debug log: exercise toggle requested
    Logger.info('WorkoutBloc', 'ToggleExercise requested: id=${event.exerciseId}');
    final result = await toggleExerciseFn(event.workout, event.exerciseId);

    await result.fold(
      (failure) async {
        Logger.info('WorkoutBloc', 'emit WorkoutError: ${failure.message}');
        emit(WorkoutError(failure.message));
      },
      (workout) async {
        final allCompleted =
            workout.completedExerciseIds.length == workout.scheda.esercizi.length;
        Logger.info('WorkoutBloc', 'ToggleExercise success: workoutId=${workout.id} allCompleted=$allCompleted');

        if (allCompleted) {
          final completed = workout.copyWith(isCompleted: true);
          final completeResult = await completeWorkoutFn(completed);

          completeResult.fold(
            (failure) {
              Logger.info('WorkoutBloc', 'emit WorkoutError: ${failure.message}');
              emit(WorkoutError(failure.message));
            },
            (_) {
        Logger.info('WorkoutBloc', 'no full completion after toggle for workoutId=${workout.id}');
        // Emit the updated workout so the UI reflects the toggled exercise
        emit(WorkoutLoaded(workout));
              emit(WorkoutCompleted(workout: completed));
            },
          );
          return;
        }
        emit(WorkoutLoaded(workout));
        Logger.info('WorkoutBloc', 'no full completion after toggle for workoutId=${workout.id}');
      },
    );
  }

  Future<void> _onUpdated(
    WourtkoutUpdated event,
    Emitter<WorkoutState> emit,
  ) async {
    Logger.info('WorkoutBloc', 'Received WourtkoutUpdated -> emit WorkoutLoaded: id=${event.workoutModel.id}');
    emit(WorkoutLoaded(event.workoutModel));
  }

  Future<void> _onDeleted(
    WorkoutOnDeleted event,
    Emitter<WorkoutState> emit,
  ) async {
    final today = DateTime.now().weekday;

    // If the deleted workout concerns today, we should update the UI state.
    final affectsToday = event.workout.dayOfWeek == today;

    if (affectsToday) {
      Logger.info('WorkoutBloc', 'emit WorkoutLoading (delete affects today)');
      emit(const WorkoutLoading());
    } else {
      Logger.info('WorkoutBloc', 'Deleting non-today workout; preserving UI state');
    }

    final result = await deleteWorkoutFn(event.workout);
    result.fold(
      (failure) {
        Logger.error('WorkoutBloc', 'Delete failed: ${failure.message}');
        if (affectsToday) {
          emit(WorkoutError(failure.message));
        } else {
          Logger.info('WorkoutBloc', 'Preserving state after delete failure: ${this.state.runtimeType}');
          emit(this.state);
        }
      },
      (_) {
        Logger.info('WorkoutBloc', 'Deleted workout persisted: id=${event.workout.id} day=${event.workout.dayOfWeek}');
        if (affectsToday) {
          Logger.info('WorkoutBloc', 'emit WorkoutDeleted for today: id=${event.workout.id}');
          emit(WorkoutDeleted(dayOfWeek: event.workout.dayOfWeek, id: event.workout.id));
        } else {
          Logger.info('WorkoutBloc', 'Deleted non-today workout; no UI change in WorkoutBloc');
          emit(this.state);
        }
      },
    );
  }



  Future<void> _onCompleted(
    WorkoutOnCompleted event,
    Emitter<WorkoutState> emit,
  ) async {
    Logger.info('WorkoutBloc', 'emit WorkoutLoading');
    emit(const WorkoutLoading());
    final result = await completeWorkoutFn(event.workout);
    result.fold(
      (failure) {
        Logger.info('WorkoutBloc', 'emit WorkoutError: ${failure.message}');
        emit(WorkoutError(failure.message));
      },
      (_) {
        Logger.info('WorkoutBloc', 'emit WorkoutCompleted: id=${event.workout.id}');
        emit(WorkoutCompleted(workout: event.workout));
      },
    );
  }
}