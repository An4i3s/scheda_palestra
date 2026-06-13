import 'package:flutter/material.dart';
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
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(child: WorkoutTileContainer(name: 'Corsa', description: 'Corsa outdoor o tapis roulant', onTap:() => onCategoryTap(WorkoutCategory.ruuning), isSelected: _selectedCategory==WorkoutCategory.ruuning,)),
              Expanded(child: WorkoutTileContainer(name: 'Camminata', description: 'Camminata veloca o in pendenza', onTap: () => onCategoryTap(WorkoutCategory.walking), isSelected:  _selectedCategory==WorkoutCategory.walking,)),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(child: WorkoutTileContainer(name: 'Forza', description: 'Allenamento di forza', onTap: () => onCategoryTap(WorkoutCategory.strength), isSelected:  _selectedCategory==WorkoutCategory.strength,)),
              Expanded(child: WorkoutTileContainer(name: 'Bicicletta', description: 'Bici o cyclette', onTap: () => onCategoryTap(WorkoutCategory.cycling), isSelected:  _selectedCategory==WorkoutCategory.cycling,)),

            ],
          )       ,
             Row(
            spacing: 8,
            children: [
              Expanded(child: WorkoutTileContainer(name: 'Pilates', description: 'Sessione di Pilates', onTap: () => onCategoryTap(WorkoutCategory.pilates), isSelected:  _selectedCategory==WorkoutCategory.pilates,)),
              Expanded(child: WorkoutTileContainer(name: 'Nuoto', description: 'Nuoto', onTap: () => onCategoryTap(WorkoutCategory.swimming), isSelected:  _selectedCategory==WorkoutCategory.swimming,)),

            ],
          )   
        ],
      ),
    );
  }
}

class WorkoutTileContainer extends StatelessWidget {
  const WorkoutTileContainer({
    super.key, required this.name, required this.description, required this.onTap, required this.isSelected,
  });
  final String name;
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
          color: isSelected ? Colors.red[300]  : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                Icon(Icons.face_retouching_natural_rounded),
                Text(name),
              ],
            ),
            Text(description, style: TextStyle(fontSize: 12,))
          ],
        ),
      ),
    );
  }
}