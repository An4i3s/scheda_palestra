import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SuccessView extends StatelessWidget{
  const SuccessView({super.key, required this.workoutName});
  final String workoutName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.all(16),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  color: Color(0xFF2E5559).withAlpha(180)
              ),
              child: Text("🏃‍♂️", style: TextStyle(fontSize: 72),)
            ),
            Text("🏆 Workout Completato!", style:  TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w600)),
            Text(workoutName, style:  TextStyle(fontSize: 16, color: Colors.white) ),
          ],
        ),
    ),);
  }
}