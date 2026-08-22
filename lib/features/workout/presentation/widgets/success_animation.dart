import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessOverlay extends StatefulWidget {
  final VoidCallback onDismiss;
  final String message;

  const SuccessOverlay({
    super.key,
    required this.onDismiss,
    this.message = 'Operazione completata!',
  });

  @override
  State<SuccessOverlay> createState() => _SuccessOverlayState();
}

class _SuccessOverlayState extends State<SuccessOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            // Durata originale divisa per 1.5 = 50% più veloce
            _controller.duration = Duration(
              milliseconds: (composition.duration.inMilliseconds / 1.5).round(),
            );
            _controller.forward().whenComplete(widget.onDismiss);
          },
          // onLoaded: (composition) {
          //   Future.delayed(composition.duration, widget.onDismiss);
          // },
           controller: _controller,
        ),
      ),
    );
  }
}
