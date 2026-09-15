import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';

class RestDayView extends StatelessWidget{
  const RestDayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.restDayColor,
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          spacing: 32,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  // color: Color(0xFF2E5559)
                  color: AppColors.darkContainerColor
              ),
              child: SvgPicture.asset("assets/icons/moon.svg", colorFilter: ColorFilter.mode(AppColors.accentColor, BlendMode.srcIn), width: 72,)
            ),
            Text(context.i18n.restDay, style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),),
            Text("Il recupero è parte dell'allenamento.\nIl tuo corpo sta crescendo proprio adesso.",  style: TextStyle(color: AppColors.greyTextColor, fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}