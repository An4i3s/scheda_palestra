import 'package:flutter/widgets.dart';
import 'package:scheda_palestra/core/helpers/workout_chip_helper.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/workout_category_chip.dart';

class SchedaCard extends StatelessWidget{
  const SchedaCard({super.key, required this.scheda, required this.onEdit, required this.onDelete});
  final SchedaModel scheda;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.neutralColor,
        border: Border.all(color: WorkoutChipHelper.getChipColors(scheda.category), width: 2),
      ),
      // margin: const EdgeInsets.symmetric(vertical: 8),
      child:  Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Row(
            children: [
              WorkoutCategoryChip(label: WorkoutChipHelper.getChipLabel(scheda.category), color: WorkoutChipHelper.getChipColors(scheda.category)),
            ],
          ),
          Text(scheda.nome, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          Text("${scheda.esercizi.length} esercizi"),
        ],
      )),
    );
  }
}