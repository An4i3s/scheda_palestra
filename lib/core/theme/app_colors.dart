import 'package:flutter/material.dart';

class AppColors {
  static const Color neutralColor = Color(0xFFFFFFFF);
  static const Color greenSelectionColor = Color(0xFFCCFF00);
  static const Color textColor = Color(0xFF121212);
  // static const Color backgroundColor = Color(0xFFf4fdfd);
  static const Color backgroundColor = Color(0xFFF9F8F6);
  //? dove usarlo?
  static const Color mutedColor = Color(0xFFF0EFE9);

  // MainColors
  // static const Color primaryColor = Color(0xFFBA1650);
  static const Color accentColor = Color(0xFFFFD600);

  static const LinearGradient primaryLinearGradient = LinearGradient(
    begin: Alignment(-0.364, -1.0),
    end: Alignment(0.364, 1.0),
    colors: [AppColors.restDayColor, Color(0xFF1A1A18), Color(0xFFFF5500)],
    stops: [0.0, 0.5, 1.0],
  );

  static const Color primaryColor = Color(0xFFFF5500);

  //Container

  static const Color containerColor = Color(0xFFFFF2ED);
  static const Color borderContainerColor = Color(0xFFc7e8ea);
  static const Color darkContainerColor = Color(0xFF2E2E2D);
  static const Color secondaryBorderContainerColor = Color(0xFFFFE3D9);
  static const Color homeBadgeContainerColor = Color(0xFFA55C23);
  static const Color homeBadgeBorderContainerColor = Color(0xFFBE761F);

  static const Color restDayColor = Color(0xFF41424C);

  //TEXT
  static const Color greyTextColor = Color(0xFF90908F);
}
