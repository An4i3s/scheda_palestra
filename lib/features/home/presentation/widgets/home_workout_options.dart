
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';

class HomeWorkoutOptions extends StatelessWidget {
  const HomeWorkoutOptions({
    super.key, required this.isRest, required this.schedaName, required this.onTap, required this.isSelected,
  });
  final bool isRest;
  final bool isSelected;
  final String schedaName;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderContainerColor),
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? AppColors.primaryColor: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                spacing: 16,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.containerColor,
                      borderRadius: BorderRadius.circular(32)
                    ),
                    child: isRest ?  Text("😴", style: TextStyle(fontSize: 18),): Text("🏋🏻‍♀️", style: TextStyle(fontSize: 18),),),
                  Expanded(
                    child: isRest ?  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.i18n.restDay, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),), Text(context.i18n.noWorkout)],
                    )
                  : Text(schedaName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700,), overflow: TextOverflow.ellipsis, maxLines: 1,),
                  ),
                ],
              ),
            ),
            if(isSelected) Icon(Icons.check_circle_outline, color: AppColors.secondaryBtnColor,)
          ],
        ),
      ),
    );
  }
}
