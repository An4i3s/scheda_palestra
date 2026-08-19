import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';

class RestDayView extends StatelessWidget{
  const RestDayView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
      begin: const Alignment(-0.364, -1.0),
      end: const Alignment(0.364, 1.0),
      colors: const [
        Color(0xFF00484D), 
        Color(0xFF00A0AA), 
        Color(0xFF002629), 
      ],
      stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          spacing: 32,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  color: Color(0xFF2E5559)
              ),
              child: SvgPicture.asset("assets/icons/moon.svg", colorFilter: ColorFilter.mode(AppColors.secondaryBtnColor, BlendMode.srcIn), width: 72,)
            ),
            Text("Giorno di riposo", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}