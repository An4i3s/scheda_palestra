import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/widgets/custom_keyboard.dart';
import 'package:scheda_palestra/core/widgets/custom_keyboard_controller.dart';

class CustomKeyboardHost extends StatelessWidget {
  const CustomKeyboardHost({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CustomKeyboardController.instance,
      builder: (context, _) {
        final controller = CustomKeyboardController.instance;
        if (!controller.isVisible) return const SizedBox.shrink();

        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Material(
            elevation: 8,
            color: Colors.transparent,
            child: CustomKeyboard(
              mode: controller.mode,
              controller: controller.activeController!,
              onClose: controller.close,
            ),
          ),
        );
      },
    );
  }
}