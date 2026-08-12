import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class WorkoutCategoryContainer extends StatefulWidget{
  const WorkoutCategoryContainer({super.key, required this.selectedCategory, required this.onCategorySelected});
  final WorkoutCategory? selectedCategory;
  final void Function(WorkoutCategory c) onCategorySelected;

  @override
  State<WorkoutCategoryContainer> createState() => _WorkoutCategoryContainerState();
}

class _WorkoutCategoryContainerState extends State<WorkoutCategoryContainer> {

  WorkoutCategory? _selectedCategory;

  @override
  initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  void onCategoryTap(WorkoutCategory category){
    setState(() => _selectedCategory = category);
    widget.onCategorySelected(category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderContainerColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text("Tipo di Allenamento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
          SizedBox(height: 8,),
          Row(
            spacing: 8,
            children: [
              Expanded(child: WorkoutTileContainer(name: 'Corsa', description: 'Corsa outdoor o tapis roulant', onTap:() => onCategoryTap(WorkoutCategory.ruuning), isSelected: _selectedCategory==WorkoutCategory.ruuning, icon: '🏃‍♂️',)),
              Expanded(child: WorkoutTileContainer(name: 'Camminata', description: 'Camminata veloce o in pendenza', onTap: () => onCategoryTap(WorkoutCategory.walking), isSelected:  _selectedCategory==WorkoutCategory.walking, icon: '🚶',)),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(child: WorkoutTileContainer(name: 'Forza', description: 'Allenamento di forza', onTap: () => onCategoryTap(WorkoutCategory.strength), isSelected:  _selectedCategory==WorkoutCategory.strength, icon: '💪',)),
              Expanded(child: WorkoutTileContainer(name: 'Bicicletta', description: 'Bici o cyclette', onTap: () => onCategoryTap(WorkoutCategory.cycling), isSelected:  _selectedCategory==WorkoutCategory.cycling, icon: '🚴',)),

            ],
          )       ,
             Row(
            spacing: 8,
            children: [
              Expanded(child: WorkoutTileContainer(name: 'Pilates', description: 'Sessione di Pilates', onTap: () => onCategoryTap(WorkoutCategory.pilates), isSelected:  _selectedCategory==WorkoutCategory.pilates, icon: '🧘',)),
              Expanded(child: WorkoutTileContainer(name: 'Nuoto', description: 'Nuoto', onTap: () => onCategoryTap(WorkoutCategory.swimming), isSelected:  _selectedCategory==WorkoutCategory.swimming, icon: '🏊',)),

            ],
          )   
        ],
      ),
    );
  }
}

class WorkoutTileContainer extends StatelessWidget {
  const WorkoutTileContainer({
    super.key, required this.name, required this.description, required this.onTap, required this.isSelected, required this.icon,
  });
  final String name;
  final String icon;
  final String description;
  final void Function( ) onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() =>  onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryBtnColor  : AppColors.containerColor,
          borderRadius: BorderRadius.circular(24),
          border: isSelected ? null : Border.all(color: AppColors.borderContainerColor)
        ),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                Text(icon, style: TextStyle(fontSize: 20),),
                Text(name, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
              ],
            ),
            Text(description, style: TextStyle(fontSize: 13, color:  isSelected ? Colors.white : Colors.black))
          ],
        ),
      ),
    );
  }
}