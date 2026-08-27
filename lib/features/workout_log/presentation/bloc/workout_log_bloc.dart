import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_event.dart';
import 'package:scheda_palestra/features/workout_log/presentation/bloc/workout_log_state.dart';

typedef GetPastWorkoutstFn = Future<Either<Failure, List<WorkoutLogModel>>>  Function();
typedef RegisterWorkoutstFn = Future<Either<Failure, WorkoutLogModel>>  Function(WorkoutLogModel);



class WorkoutLogBloc extends Bloc<WorkoutLogEvent, WorkoutLogState>{
  
  final GetPastWorkoutstFn getPastWorkoutstFn;
  final RegisterWorkoutstFn registerWorkoutstFn;

  WorkoutLogBloc({required this.getPastWorkoutstFn, required this.registerWorkoutstFn}):super(const WorkoutLogLoading()){
    // on<WorkoutLogOnLoading>(_onInitial);
    on<WorkoutLogOnLoad>(_onLoading);
    on<WorkoutLogOnRegistered>(_onRegistered);
  }


    Future<void> _onLoading(
      WorkoutLogOnLoad event,
      Emitter<WorkoutLogState> emit
    ) async {
      emit(WorkoutLogLoading());
      final result = await getPastWorkoutstFn();
      result.fold(
        (failure){ 
          emit(WorkoutLogError());
        }, 
        (workouts) async{
          workouts.isEmpty ? emit(WorkoutLogEmpty()):emit(WorkoutLogLoaded(workouts: workouts));
        }
        );
    }

    Future<void> _onRegistered(
      WorkoutLogOnRegistered event,
      Emitter<WorkoutLogState> emit
    ) async{
      // emit(WorkoutLogLoading());
      final result = await registerWorkoutstFn(event.workout);
      await result.fold((failure){
         emit(WorkoutLogError());
      }, (workout) async{
        emit(WorkoutRegistered());
        final updatedList = await getPastWorkoutstFn();
        await updatedList.fold((f){
          return;
        },
        (workoutList){
          // if(!emit.isDone){
            emit(WorkoutLogLoaded(workouts: workoutList));
          // }
          
        }
        );
        
      });
    }
}