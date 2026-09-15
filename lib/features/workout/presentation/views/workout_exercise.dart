
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_stats_list.dart';

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
          border: Border.all(color: widget.isPressed ?   AppColors.primaryColor: Colors.grey),
          color: widget.isPressed ? Color(0xFFebf9f9) : Colors.white
        ),
        child: Row(
          spacing: 16,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.isPressed ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(64),
                border: Border.all(color: widget.isPressed ?   AppColors.primaryColor: Colors.grey),
              ),
              child:  widget.isPressed ? Icon(Icons.check_circle_outline, color: Colors.white,):null,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.exerciseModel.name, style: TextStyle(fontWeight: FontWeight(600), color:  widget.isPressed ? AppColors.primaryColor : Colors.black, decoration:widget.isPressed ? TextDecoration.lineThrough:null),),
                  Wrap(
                    spacing: 16,
                    
                    direction: Axis.horizontal,
                    children: [
                    ExerciseStatsList(exerciseModel: widget.exerciseModel),
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

