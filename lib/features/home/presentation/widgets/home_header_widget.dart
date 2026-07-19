
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/strikes_badge.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key, required this.streaksDays,
  });
  final int streaksDays;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.setsTextColors
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bentornato!", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),),
                  Text("Continua cosi!", style:  TextStyle(color: Colors.white, fontSize: 16,),)
                ],
              ),
              Text("🔥", style: TextStyle(fontSize: 32),)
            ],
          ),
          StreaksBadgeWidget(streaksDays: streaksDays,)
        ],
      ),
    );
  }
}
