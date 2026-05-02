import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/home/data/home_model.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_events.dart';
import 'package:scheda_palestra/features/home/presentation/home_bloc/home_state.dart';

typedef GetHomeSummary = Future<Either<Failure, HomeModel>> Function();

class HomeBloc  extends Bloc<HomeEvents, HomeState> {
  final GetHomeSummary getHomeSummary;
  
  HomeBloc({
    required this.getHomeSummary,
  }) : super(const HomeInitial()) {
    on<HomeStarted>(_onStarted);
    // on<SchedaSaved>(_onSaved);
    // on<SchedaDeleted>(_onDeleted);
  }


  Future<void> _onStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    final result = await getHomeSummary();
    result.fold(
      (failure) => emit(HomeError()),
      (homeModel) => emit(HomeLoaded(homeModel)),
    );
  }


}