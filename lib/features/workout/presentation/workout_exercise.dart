
import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';

class ExerciseWorkout extends StatelessWidget {
  const ExerciseWorkout({
    super.key, required this.exerciseModel, required this.onPressed, required this.isPressed
  });
  final ExerciseModel exerciseModel;
  final void Function() onPressed;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey)
        ),
        child: Row(
          spacing: 16,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isPressed ? Colors.red : Colors.white,
                borderRadius: BorderRadius.circular(64),
                border: Border.all(color: Colors.grey)
      
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exerciseModel.name, style: TextStyle(fontWeight: FontWeight(600)),),
                  Wrap(
                    spacing: 16,
                    
                    direction: Axis.horizontal,
                    children: [
                    if(exerciseModel.series!=0)Text("Serie: ${exerciseModel.series}"),
                    if(exerciseModel.repetitions!=0) Text("Ripetizioni: ${exerciseModel.repetitions}"),
                     if(exerciseModel.km!=0)Text("km: ${exerciseModel.km}"),
                    if(exerciseModel.elevation!=null && exerciseModel.elevation!=0)Text("elevation: ${exerciseModel.elevation}"),
                    if(exerciseModel.restTime!=0) Text("Rest: ${exerciseModel.restTime}"),
                  ],)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
