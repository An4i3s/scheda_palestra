import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scheda_palestra/core/helpers/muscle_group_chip_helper.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model.dart';
import 'package:scheda_palestra/features/exercises/presentation/widgets/muscle_group_chip.dart';

class ExerciseTypesCard extends StatelessWidget{
  const ExerciseTypesCard({super.key, required this.exerciseType});
  final ExerciseTypeModel exerciseType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: MuscleGroupChipHelper.getColorForMuscleGroup(exerciseType.targetMuscleGroup), 
        width: 6)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.fitness_center, size: 24),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  exerciseType.name,
                  style: const TextStyle(fontSize: 20, height: 1.0),
                ),
                const SizedBox(height: 6),
                MuscleGroupChip(muscleGroup: exerciseType.targetMuscleGroup),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: 20,
                visualDensity: VisualDensity.compact,
                onPressed: () {},
                icon: const Icon(Icons.edit),
                color: Colors.grey,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: 20,
                visualDensity: VisualDensity.compact,
                onPressed: () {},
                icon: const Icon(Icons.delete),
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}