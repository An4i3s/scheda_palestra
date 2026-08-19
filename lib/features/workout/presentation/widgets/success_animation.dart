import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessOverlay extends StatelessWidget {
  final VoidCallback onDismiss;
  final String message;

  const SuccessOverlay({
    super.key,
    required this.onDismiss,
    this.message = 'Operazione completata!',
  });

  @override
  Widget build(BuildContext context) {
     return Material(
      color: Colors.transparent,
      child: SizedBox.expand(
        child: Lottie.asset(
          'assets/animations/congratulation.json',
          fit: BoxFit.fitHeight, // or BoxFit.contain if you don't want cropping
          repeat: false,
          onLoaded: (composition) {
            Future.delayed(composition.duration, onDismiss);
          },
        ),
      ),
    );
      
  }
}