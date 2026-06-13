import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';


class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key, required this.e,
  });
  final ExerciseModel e;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(e.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }
}
