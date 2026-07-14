
import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';

class ExerciseWorkout extends StatefulWidget {
  const ExerciseWorkout({
    super.key, required this.exerciseModel, required this.onPressed, required this.isPressed
  });
  final ExerciseModel exerciseModel;
  final void Function() onPressed;
  final bool isPressed;

  @override
  State<ExerciseWorkout> createState() => _ExerciseWorkoutState();
}

class _ExerciseWorkoutState extends State<ExerciseWorkout> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
          color: Colors.white
        ),
        child: Row(
          spacing: 16,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.isPressed ? Colors.red : Colors.white,
                borderRadius: BorderRadius.circular(64),
                border: Border.all(color: Colors.grey)
      
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.exerciseModel.name, style: TextStyle(fontWeight: FontWeight(600)),),
                  Wrap(
                    spacing: 16,
                    
                    direction: Axis.horizontal,
                    children: [
                    if(widget.exerciseModel.series!=0)Text("Serie: ${widget.exerciseModel.series}"),
                    if(widget.exerciseModel.repetitions!=0) Text("Ripetizioni: ${widget.exerciseModel.repetitions}"),
                     if(widget.exerciseModel.km!=0)Text("km: ${widget.exerciseModel.km}"),
                    if(widget.exerciseModel.elevation!=null && widget.exerciseModel.elevation!=0)Text("elevation: ${widget.exerciseModel.elevation}"),
                    if(widget.exerciseModel.restTime!=0) Text("Rest: ${widget.exerciseModel.restTime}"),
                    if(widget.exerciseModel.description!=null && widget.exerciseModel.description!.isNotEmpty)
                      Text(widget.exerciseModel.description!),
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
