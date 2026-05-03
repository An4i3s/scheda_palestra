import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/helpers/muscle_group_chip_helper.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';

class MuscleGroupChip extends StatelessWidget {
  const MuscleGroupChip({super.key, required this.muscleGroup});

  final TargetMuscleGroup muscleGroup;

  @override
  Widget build(BuildContext context) {

    return Text(
      muscleGroup.name,
      style:  TextStyle(color:  MuscleGroupChipHelper.getColorForMuscleGroup(muscleGroup), fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}