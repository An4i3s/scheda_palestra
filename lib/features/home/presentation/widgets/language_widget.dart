
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';

class LanguageContainerWidget extends StatelessWidget {
  const LanguageContainerWidget({
    super.key, required this.flag, required this.language, required this.isSelected, required this.onPressed,
  });
  final String flag;
  final String language;
  final bool isSelected;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFebf9fa): Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.borderContainerColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 16,
              children: [
                Text(flag,),
                Text(language, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: isSelected ? AppColors.primaryColor:Colors.black),),
              ],
            ),
          if(isSelected) Icon(Icons.check_circle, color: AppColors.primaryColor,)
          ],
        ),
      ),
    );
  }
}
