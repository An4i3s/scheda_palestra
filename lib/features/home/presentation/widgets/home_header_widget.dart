import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/strikes_badge.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key, required this.streaksDays, required this.onSettingsPressed});
  final int streaksDays;
  final void Function() onSettingsPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.secondaryBtnColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      context.i18n.homeGreeting,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(onPressed: onSettingsPressed, icon: Icon(Icons.settings, color: AppColors.primaryBtnColor,),)
                ],
              ),
              Text(
                context.i18n.homeMessage,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          StreaksBadgeWidget(streaksDays: streaksDays),
        ],
      ),
    );
  }
}
