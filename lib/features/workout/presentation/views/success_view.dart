import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key, required this.workoutName});
  final String workoutName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.primaryLinearGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkContainerColor,
              ),
              child: Text("🏃‍♂️", style: TextStyle(fontSize: 72)),
            ),
            Text(
              context.i18n.workoutCompleted,
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              workoutName,
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
