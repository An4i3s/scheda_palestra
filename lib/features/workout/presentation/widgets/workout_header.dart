
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/presentation/widgets/timer_button.dart';
import 'package:scheda_palestra/features/workout/presentation/widgets/timer_controller.dart';

class WorkoutHeader extends StatefulWidget {
  final WorkoutModel workout;

  const WorkoutHeader({super.key, required this.workout});

  @override
  State<WorkoutHeader> createState() => _WorkoutHeaderState();
}

class _WorkoutHeaderState extends State<WorkoutHeader> {
  final timer = TimerController();

  @override
  void dispose() {
    timer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.primaryLinearGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.workout.scheda.nome,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              // '${workout.scheda.esercizi.length} esercizi',
              context.i18n.exercisesCount2(widget.workout.scheda.esercizi.length),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            AnimatedContainer(
              duration: Durations.medium1,
              width: double.infinity,
              height: 8,
              margin: const EdgeInsets.only(top: 8, bottom: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: [
                    AnimatedFractionallySizedBox(
                      widthFactor: widget.workout.scheda.esercizi.isEmpty
                          ? 0
                          : widget.workout.completedExerciseIds.length /
                              widget.workout.scheda.esercizi.length,
                      heightFactor: 1,
                      alignment: Alignment.centerLeft,
                      duration: Durations.medium1,
                      child: Container(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // '${workout.completedExerciseIds.length} /${workout.scheda.esercizi.length} completati',
                  context.i18n.completedExercisesCount('${widget.workout.completedExerciseIds.length} /${widget.workout.scheda.esercizi.length}'),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${(100 * (widget.workout.completedExerciseIds.length / widget.workout.scheda.esercizi.length)).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}