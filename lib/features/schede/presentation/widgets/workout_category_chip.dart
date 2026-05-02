import 'package:flutter/material.dart';

class WorkoutCategoryChip extends StatelessWidget{
  const WorkoutCategoryChip({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        spacing: 8,
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              // shape: BoxShape.circle,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}