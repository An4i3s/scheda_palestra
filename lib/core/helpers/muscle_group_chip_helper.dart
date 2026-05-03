import 'dart:ui';

import 'package:scheda_palestra/features/exercises/data/models/exercise_model.dart';

class MuscleGroupChipHelper{
  static Color getColorForMuscleGroup(TargetMuscleGroup muscleGroup){
    switch(muscleGroup){
      case TargetMuscleGroup.chest:
        return const Color(0xFFE57373);
      case TargetMuscleGroup.back:
        return const Color(0xFF64B5F6);
      case TargetMuscleGroup.shoulders:
        return const Color(0xFFFFB74D);
      case TargetMuscleGroup.arms:
        return const Color(0xFF81C784);
      case TargetMuscleGroup.legs:
        return const Color(0xFFBA68C8);
      case TargetMuscleGroup.core:
        return const Color(0xFFFF8A65);
      // default:
      //   return const Color(0xFF90A4AE);
    }
  }
}