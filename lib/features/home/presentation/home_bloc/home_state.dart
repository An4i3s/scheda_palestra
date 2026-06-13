import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/home/data/home_model.dart';

class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object?> get props => [];
}


class HomeInitial extends HomeState {
  const HomeInitial();
}


class HomeLoading extends HomeState {
  const HomeLoading();
}


class HomeLoaded extends HomeState {
  final HomeModel homeModel;
  final String? lastWorkoutName;
  const HomeLoaded(this.homeModel, {this.lastWorkoutName});

  @override
  List<Object?> get props => [homeModel, lastWorkoutName];
}


class HomeError extends HomeState {
  const HomeError();
}