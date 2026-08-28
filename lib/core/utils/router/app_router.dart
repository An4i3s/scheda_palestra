
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scheda_palestra/app/app.dart';
import 'package:scheda_palestra/features/home/data/datasources/home_local_datasource_impl.dart';
import 'package:scheda_palestra/features/home/data/repositories/home_repo_impl.dart';
import 'package:scheda_palestra/features/home/domain/usecases/get_home_summary.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_bloc.dart'  hide GetHomeSummary;
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_events.dart';
import 'package:scheda_palestra/features/schede/data/datasources/schede_local_datasource_impl.dart';
import 'package:scheda_palestra/features/schede/data/repositories/schede_repo_impl.dart';
import 'package:scheda_palestra/features/schede/domain/usecases/exercises/delete_scheda.dart';
import 'package:scheda_palestra/features/schede/domain/usecases/exercises/get_schede.dart';
import 'package:scheda_palestra/features/schede/domain/usecases/exercises/save_scheda.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_bloc.dart';
import 'package:scheda_palestra/features/schede/presentation/schede_bloc/schede_events.dart';
import 'package:scheda_palestra/features/workout/data/datasources/workout_local_datasource_impl.dart';
import 'package:scheda_palestra/features/workout/data/repositories/workout_repository_impl.dart';
import 'package:scheda_palestra/features/workout/domain/usecases/complete_workout.dart';
import 'package:scheda_palestra/features/workout/domain/usecases/create_workout.dart';
import 'package:scheda_palestra/features/workout/domain/usecases/delete_workout.dart';
import 'package:scheda_palestra/features/workout/domain/usecases/get_all_workouts.dart';
import 'package:scheda_palestra/features/workout/domain/usecases/get_current_workout.dart';
import 'package:scheda_palestra/features/workout/domain/usecases/save_workout.dart';
import 'package:scheda_palestra/features/workout/domain/usecases/success_workout.dart';
import 'package:scheda_palestra/features/workout/domain/usecases/toggle_exercise.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_bloc.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';
import 'package:scheda_palestra/features/workout_log/data/datasources/workout_log_datasource_impl.dart';
import 'package:scheda_palestra/features/workout_log/data/repositories/workout_log_repository_impl.dart';
import 'package:scheda_palestra/features/workout_log/domain/usecases/register_workout.dart';
import 'package:scheda_palestra/features/workout_log/domain/usecases/get_past_workout.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_bloc.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_event.dart';

abstract class AppRouter {
  static const String home = '/';

  // ─── Dipendenze ───────────────────────────────────────────────────────────
  static final _schedeDataSource = SchedeLocalDatasourceImpl();
  static final _schedeRepository = SchedeRepositoryImpl(datasource: _schedeDataSource);
  static final _getSchede = GetSchede(repository: _schedeRepository);
  static final _saveScheda = SaveScheda(repository: _schedeRepository);
  static final _deleteScheda = DeleteScheda(repository: _schedeRepository);

  static final _homeDataSource = HomeLocalDatasourceImpl();
  static final _homeRepository = HomeRepositoryImpl(datasource: _homeDataSource);
  static final _getHomeSummary = GetHomeSummary(repository: _homeRepository);
  
  // static final _exerciseDataSource = ExerciseLocalDatasource();
  // static final _exerciseRepository = ExercisesRepositoryImpl(datasource: _exerciseDataSource);
  // static final _getExercises = GetExercise(repository: _exerciseRepository);
  // static final _saveExercise = SaveExercise(repository: _exerciseRepository);

  static final _workoutDataSource = WorkoutLocalDatasourceImpl();
  static final _workoutRepository = WorkoutRepositoryImpl(datasource: _workoutDataSource);
  static final _getCurrentWorkout = GetCurrentWorkout(repository: _workoutRepository);
  static final _saveWorkout = SaveWorkout(repository: _workoutRepository);
  static final _getAllWorkouts = GetAllWorkouts(repository: _workoutRepository);
  static final _createWorkout = CreateWorkout(repository: _workoutRepository);
  static final _toggleExercise = ToggleExercise(repository: _workoutRepository);
  static final _deleteWorkout = DeleteWorkout(repository: _workoutRepository);
  static final _completeWorkout = CompleteWorkout(repository: _workoutRepository);
  static final _successWorkout = SuccessWorkout(repository: _workoutRepository);

  static final _workoutLogDataSource = WorkoutLogDatasourceImpl();
  static final _workoutLogRepository = WorkoutLogRepositoryImpl(datasource: _workoutLogDataSource);
  static final _getPastWorkouts = GetPastWorkouts(repository: _workoutLogRepository);
  static final _registerWorkout = RegisterWorkout(repository: _workoutLogRepository);



  // ─── BLoC (creati una volta sola) ─────────────────────────────────────────
  static final _homeBloc = HomeBloc(
    getHomeSummary: _getHomeSummary.call,
    createWorkout: _createWorkout.call,
    deleteWorkout: _deleteWorkout.call,
  )..add(const HomeStarted());

  static final _schedeBloc = SchedeBloc(
    getSchede: _getSchede.call,
    saveScheda: _saveScheda.call,
    deleteScheda: _deleteScheda.call,
  )..add(const SchedeStarted());

  // static final _exercisesBloc = ExercisesBloc(
  //   getExercises: _getExercises.call,
  //   saveExercise: _saveExercise.call,
  // )..add(const ExercisesStarted());

  static final _workoutBloc = WorkoutBloc(
    getCurrentWorkout: _getCurrentWorkout.call,
    saveWorkoutFn: _saveWorkout.call,
    getAllWorkoutsFn: _getAllWorkouts.call,
    createWorkoutFn: _createWorkout.call,
    toggleExerciseFn: _toggleExercise.call,
    deleteWorkoutFn: _deleteWorkout.call,
    completeWorkoutFn: _completeWorkout.call, 
    successWorkoutFn: _successWorkout.call,
    
  )..add(const WourtkoutLoaded());

  static final _workoutLogBloc = WorkoutLogBloc(
    getPastWorkoutstFn: _getPastWorkouts.call,
    registerWorkoutstFn: _registerWorkout.call
  )..add(const WorkoutLogOnLoad());

  // ─── Router ───────────────────────────────────────────────────────────────
  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _homeBloc),
            BlocProvider.value(value: _schedeBloc),
            // BlocProvider.value(value: _exercisesBloc),
            BlocProvider.value(value: _workoutBloc),
            BlocProvider.value(value: _workoutLogBloc)
          ],
          child: const App(),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Pagina non trovata: ${state.error}')),
    ),
  );
}