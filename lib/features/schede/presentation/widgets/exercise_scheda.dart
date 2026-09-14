
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_stats_list.dart';

class ExerciseInScheda extends StatelessWidget {
  const ExerciseInScheda({
    super.key,
    required this.exercise,
    required this.index,
  });
  final int index;
  final ExerciseModel exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryBtnColor,
              shape: BoxShape.circle
            ),
            child: Center(child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(index.toString(), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
            )),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                ExerciseStatsList(exerciseModel: exercise),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

