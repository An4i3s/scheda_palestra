import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/views/rest_day_view.dart';
import 'package:scheda_palestra/features/workout/presentation/views/success_view.dart';
import 'package:scheda_palestra/features/workout/presentation/widgets/success_animation.dart';
import 'package:scheda_palestra/features/workout/presentation/widgets/workout_exercises_list.dart';
import 'package:scheda_palestra/features/workout/presentation/widgets/workout_header.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_bloc.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_event.dart';
import 'package:scheda_palestra/features/workout/presentation/workout_bloc/workout_state.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({super.key});

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  void _showSuccessAnimation(WorkoutModel w) {
    if (!mounted || _overlayEntry != null) {
      return;
    }

    final overlay = Overlay.of(context, rootOverlay: true);
    _overlayEntry = OverlayEntry(
      builder: (context) => SuccessOverlay(
        onDismiss: () {
          if (!mounted) return;
          _overlayEntry?.remove();
          _overlayEntry = null;
        },
      ),
    );

    overlay.insert(_overlayEntry!);
    context.read<WorkoutBloc>().add(WorkoutOnSuccess(w));

  }

  void _triggerSuccessAnimationIfNeeded(WorkoutState state) {
    if (state is WorkoutCompleted && _overlayEntry == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _overlayEntry != null) return;
        _showSuccessAnimation(state.workout);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {

         
          if(state is WorkoutCompleted){
             _triggerSuccessAnimationIfNeeded(state);
          }


          if (state is WorkoutEmpty || state is WorkoutDeleted) {
            return RestDayView();
          }

          if (state is WorkoutLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.secondaryBtnColor,
              ),
            );
          }

          if (state is WorkoutError) {
            return Center(child: Text('Errore: ${state.message}'));
          }

          if (state is WorkoutSuccess || state is WorkoutCompleted) {
             final workout = (state is WorkoutSuccess)
                ? state.workout
                : (state as WorkoutCompleted).workout;
            return SuccessView(workoutName: workout.scheda.nome);
          }

          if (state is WorkoutLoaded) {
            final workout = state.workout;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  WorkoutHeader(workout: workout),
                  const SizedBox(height: 42),
                  BlocSelector<WorkoutBloc, WorkoutState, WorkoutModel>(
                    selector: (state) {
                      if (state is WorkoutLoaded) return state.workout;
                      if (state is WorkoutCompleted) return state.workout;
                      if (state is WorkoutSuccess) return state.workout;
                      return workout;
                    },
                    builder: (context, currentWorkout) {
                      if (currentWorkout.isCompleted) {
                       
                     
                         context.read<WorkoutBloc>().add(
                          WorkoutOnCompleted(workout),
                        );
                      }
                      return WorkoutExerciseList(workout: currentWorkout);
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
