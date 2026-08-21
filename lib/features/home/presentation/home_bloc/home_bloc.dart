import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/core/utils/logger.dart';
import 'package:scheda_palestra/features/home/data/home_model.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_events.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_state.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

typedef GetHomeSummary = Future<Either<Failure, HomeModel>> Function();

typedef CreateWorkoutFn = Future<Either<Failure, WorkoutModel>> Function(WorkoutModel workout);
typedef DeleteWorkoutFn = Future<Either<Failure, bool>> Function(WorkoutModel workout);

class HomeBloc  extends Bloc<HomeEvents, HomeState> {
  final GetHomeSummary getHomeSummary;
  final CreateWorkoutFn? createWorkout;
  final DeleteWorkoutFn? deleteWorkout;

  HomeBloc({
    required this.getHomeSummary,
    this.createWorkout,
    this.deleteWorkout,
  }) : super(const HomeInitial()) {
    on<HomeStarted>(_onStarted);
    on<HomeCreateWorkout>(_onCreateWorkout);
    on<HomeDeleteWorkout>(_onDeleteWorkout);
  }


  Future<void> _onStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    Logger.info('HomeBloc', 'Handling HomeStarted');
    emit(const HomeLoading());
    final result = await getHomeSummary();
    result.fold(
      (failure) => emit(HomeError()),
      (homeModel) {
        Logger.info('HomeBloc', 'Emitting HomeLoaded');
        emit(HomeLoaded(homeModel));
      },
    );
  }

  Future<void> _onCreateWorkout(
    HomeCreateWorkout event,
    Emitter<HomeState> emit,
  ) async {
    if (createWorkout == null) {
      Logger.error('HomeBloc', 'createWorkout function not provided');
      return;
    }
    Logger.info('HomeBloc', 'Handling HomeCreateWorkout');
    emit(const HomeLoading());
    final result = await createWorkout!(event.workout);
    // avoid async closures inside fold which can call emit after the handler finishes
    var failed = false;
    result.fold((failure) => failed = true, (r) => null);
    if (failed) {
      emit(HomeError());
      return;
    }
    final summary = await getHomeSummary();
    summary.fold((_) => emit(HomeError()), (homeModel) => emit(HomeLoaded(homeModel)));
  }

  Future<void> _onDeleteWorkout(
    HomeDeleteWorkout event,
    Emitter<HomeState> emit,
  ) async {
    if (deleteWorkout == null) {
      Logger.error('HomeBloc', 'deleteWorkout function not provided');
      return;
    }
    Logger.info('HomeBloc', 'Handling HomeDeleteWorkout');
    emit(const HomeLoading());
    final result = await deleteWorkout!(event.workout);
    var failed = false;
    result.fold((failure) => failed = true, (r) => null);
    if (failed) {
      emit(HomeError());
      return;
    }
    final summary = await getHomeSummary();
    summary.fold((_) => emit(HomeError()), (homeModel) => emit(HomeLoaded(homeModel)));
  }


}