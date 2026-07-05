import 'package:flutter_bloc/flutter_bloc.dart';
import 'exercises_events.dart';
import 'exercises_state.dart';

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  ExercisesBloc() : super(ExercisesInitial()) {
    on<ExercisesStarted>((event, emit) async {
      emit(ExercisesLoading());
      emit(const ExercisesLoaded(exercises: []));
    });
  }
}
