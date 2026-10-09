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
    side: WidgetStatePropertyAll(BorderSide(color: Color(0xFFEDE4D8),  width: 1.5 )),
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    padding: WidgetStatePropertyAll(EdgeInsetsGeometry.zero),
    backgroundColor: WidgetStatePropertyAll(Colors.white),
    foregroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
    textStyle: WidgetStatePropertyAll(
      TextStyle(fontWeight: FontWeight.bold, fontSize: 24,),
    ),
    
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
      decoration: BoxDecoration(
        color: Color(0xFFFFF7F0),
         border: Border.all(width: 1, color: Color(0xFFEDE4D8)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(42),
          topRight: Radius.circular(42),
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
                  color: AppColors.restDayColor,
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
              // mainAxisSpacing: 8,
              // crossAxisSpacing: 8,
            ),
            // itemCount: mode == CustomKeyboardMode.reps ? 11 : 10,
            itemCount: 12,
            itemBuilder: (context, index) {
              final isMaxButton = mode == CustomKeyboardMode.reps && index == 9;

              if (isMaxButton) {
                return OutlinedButton(
                  onPressed: () {
                    controller.text = 'MAX';
                  },
                  style: buttonStyle,
                  child: const Text('MAX'),
                );

              }
               if(mode != CustomKeyboardMode.reps && index == 9) {
                return SizedBox();
              }

              final number = index + 1;
              if (number == 11) {
                return OutlinedButton(
                  onPressed: () {
                    if (controller.text.trim() == 'MAX') {
                      controller.clear();
                    }
                    controller.text += '0';
                  },
                  style: buttonStyle,
                  child: const Text('0'),
                );
              }

              if (number == 12) {
                return OutlinedButton(
                  onPressed: () {
                    if (controller.text.trim() == 'MAX') {
                      controller.clear();
                    }
                  if(controller.text.isNotEmpty)  controller.text = controller.text.substring(0, controller.text.length-1);
                  },
                  style: buttonStyle,
                  child: Icon(Icons.keyboard_double_arrow_left_outlined),
                );
              }

              return OutlinedButton(
                style: buttonStyle,
                onPressed: () {
                  if (controller.text.trim() == 'MAX') {
                    controller.clear();
                  }
                  controller.text += number.toString();
                },
                child: Text(number.toString()),
              );
            },
          ),
        ],
      ),
    );
  }
}
