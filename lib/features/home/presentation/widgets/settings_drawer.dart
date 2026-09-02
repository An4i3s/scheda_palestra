
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/back_up_widget.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: Container(
        color: AppColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                spacing: 8,
                children: [
                  Icon(Icons.settings, color: AppColors.secondaryBtnColor,),
                  Text(context.i18n.settings, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
                ]
              ),
            ),
            Divider(color: AppColors.borderContainerColor, thickness: 2,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BackupWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
