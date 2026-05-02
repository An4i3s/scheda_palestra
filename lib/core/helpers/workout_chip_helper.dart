import 'dart:ui';

import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class WorkoutChipHelper {
  static String getChipLabel(WorkoutCategory category) {
    switch (category) {

      case WorkoutCategory.strength:
        return 'Forza';
      case WorkoutCategory.cardio:
       return 'Cardio';
      case WorkoutCategory.endurance:
      return 'Resistenza';
      case WorkoutCategory.flexibility:
        return 'Flessibilità';
    }
  } 

   static Color getChipColors(WorkoutCategory category){
    switch (category) {
      case WorkoutCategory.strength:
        // return const Color(0xFFCCFF00);
        return AppColors.strengthChipColor;
      case WorkoutCategory.cardio:
        // return const Color(0xFF03DAC6);
          return AppColors.cardioChipColor;
      case WorkoutCategory.endurance:
        // return const Color(0xFFFF2E63);
          return AppColors.enduranceChipColor;
      case WorkoutCategory.flexibility:
        // return const Color(0xFF6200EE);
          return AppColors.flexibilityChipColor;
    }
   }
}