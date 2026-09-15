import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class WorkoutCategoryContainer extends StatefulWidget {
  const WorkoutCategoryContainer({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });
  final WorkoutCategory? selectedCategory;
  final void Function(WorkoutCategory c) onCategorySelected;

  @override
  State<WorkoutCategoryContainer> createState() =>
      _WorkoutCategoryContainerState();
}

class _WorkoutCategoryContainerState extends State<WorkoutCategoryContainer> {
  WorkoutCategory? _selectedCategory;

  @override
  initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  void onCategoryTap(WorkoutCategory category) {
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
          Text(
            context.i18n.workoutType,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: [
              WorkoutTileContainer(
                name: context.i18n.ruuning,
                description: context.i18n.ruuningDescription,
                onTap: () => onCategoryTap(WorkoutCategory.ruuning),
                isSelected: _selectedCategory == WorkoutCategory.ruuning,
                icon: '🏃‍♂️',
              ),
              WorkoutTileContainer(
                name: context.i18n.walking,
                description: context.i18n.walkingDescription,
                onTap: () => onCategoryTap(WorkoutCategory.walking),
                isSelected: _selectedCategory == WorkoutCategory.walking,
                icon: '🚶',
              ),
              WorkoutTileContainer(
                name: context.i18n.strenght,
                description: context.i18n.strenghtDescription,
                onTap: () => onCategoryTap(WorkoutCategory.strength),
                isSelected: _selectedCategory == WorkoutCategory.strength,
                icon: '💪',
              ),
              WorkoutTileContainer(
                name: context.i18n.bicycle,
                description: context.i18n.bicycleDescription,
                onTap: () => onCategoryTap(WorkoutCategory.cycling),
                isSelected: _selectedCategory == WorkoutCategory.cycling,
                icon: '🚴',
              ),
              WorkoutTileContainer(
                name: context.i18n.pilates,
                description: context.i18n.pilatesDescription,
                onTap: () => onCategoryTap(WorkoutCategory.pilates),
                isSelected: _selectedCategory == WorkoutCategory.pilates,
                icon: '🧘',
              ),
              WorkoutTileContainer(
                name: context.i18n.swimming,
                description: context.i18n.swimmingDescription,
                onTap: () => onCategoryTap(WorkoutCategory.swimming),
                isSelected: _selectedCategory == WorkoutCategory.swimming,
                icon: '🏊',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkoutTileContainer extends StatelessWidget {
  const WorkoutTileContainer({
    super.key,
    required this.name,
    required this.description,
    required this.onTap,
    required this.isSelected,
    required this.icon,
  });
  final String name;
  final String icon;
  final String description;
  final void Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.containerColor,
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? null
              : Border.all(color: AppColors.borderContainerColor),
        ),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                Text(icon, style: TextStyle(fontSize: 20)),
                Text(
                  name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
