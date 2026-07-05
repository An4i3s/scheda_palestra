import 'dart:ui';

import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class WorkoutChipHelper {
  static String getChipLabel(WorkoutCategory category) {
    switch (category) {
      case WorkoutCategory.strength:
        return 'Forza';
      case WorkoutCategory.ruuning:
        return 'Corsa';
      case WorkoutCategory.walking:
        return 'Camminata';
      case WorkoutCategory.cycling:
        return 'Bicicletta';
      case WorkoutCategory.swimming:
        return 'Nuoto';
      case WorkoutCategory.pilates:
        return 'Pilates';
      case WorkoutCategory.yoga:
        return 'Yoga';
      case WorkoutCategory.crossfit:
        return 'Crossfit';
    }
  } 

   static Color getChipColors(WorkoutCategory category){
    switch (category) {
      case WorkoutCategory.strength:
        return AppColors.strengthChipColor;
      case WorkoutCategory.ruuning:
      case WorkoutCategory.cycling:
      case WorkoutCategory.swimming:
        return AppColors.cardioChipColor;
      case WorkoutCategory.walking:
        return AppColors.enduranceChipColor;
      case WorkoutCategory.pilates:
      case WorkoutCategory.yoga:
        return AppColors.flexibilityChipColor;
      case WorkoutCategory.crossfit:
        return AppColors.strengthChipColor;
    }
   }
}