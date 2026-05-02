import 'package:flutter/widgets.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model.dart';

class ExerciseTypesCard extends StatelessWidget{
  const ExerciseTypesCard({super.key, required this.exerciseType});
  final ExerciseTypeModel exerciseType;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(exerciseType.name),
          Text(exerciseType.targetMuscleGroup.toString().split('.').last),
        ],
      ),
    );
  }
}