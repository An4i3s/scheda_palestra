import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/core/widgets/custom_keyboard_controller.dart';

class CustomKeyboard extends StatelessWidget {
  CustomKeyboard({
    super.key,
    required this.controller,
    this.onClose,
    required this.mode,
  });

  final TextEditingController controller;
  final CustomKeyboardMode mode;
  final VoidCallback? onClose;

  final ButtonStyle buttonStyle = ButtonStyle(
    side: WidgetStatePropertyAll(BorderSide(color: AppColors.primaryColor)),
    surfaceTintColor: WidgetStatePropertyAll(AppColors.primaryColor),
    padding: WidgetStatePropertyAll(EdgeInsetsGeometry.zero),
    backgroundColor: WidgetStatePropertyAll(Colors.white),
    foregroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
    textStyle: WidgetStatePropertyAll(
      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border.all(width: 0.5, color: AppColors.restDayColor),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.homeBadgeContainerColor,
                  weight: 2,
                ),
                onPressed: onClose,
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 11,
            itemBuilder: (context, index) {
              int number = index + 1;
              if (number < 10) {
                return OutlinedButton(
                  style: buttonStyle,
                  onPressed: () {
                    if (controller.text.trim() == "MAX") {
                      controller.clear();
                    }
                    controller.text += number.toString();
                  },
                  child: Text(number.toString()),
                );
              } else if (number == 10) {
                return OutlinedButton(
                  onPressed: () {
                    if (controller.text.trim() == "MAX") {
                      controller.clear();
                    }
                    controller.text += "0";
                  },
                  style: buttonStyle,
                  child: Text("0"),
                );
              } else if (number == 11 && mode == CustomKeyboardMode.reps) {
                return OutlinedButton(
                  onPressed: () {
                    controller.text = "";
                    controller.text += "MAX";
                  },
                  style: buttonStyle,
                  child: Text("MAX"),
                );
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
