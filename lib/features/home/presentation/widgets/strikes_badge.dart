import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';

class StreaksBadgeWidget extends StatelessWidget{
  const StreaksBadgeWidget({super.key, required this.streaksDays});
  final int streaksDays;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryBtnColor,
        borderRadius: BorderRadius.circular(24)
      ),
      child: Text(context.i18n.workoutStreak(streaksDays), style: TextStyle(color: Colors.white),),
    );
  }
}