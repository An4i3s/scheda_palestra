
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/core/utils/weekday_name.dart';
import 'package:scheda_palestra/features/home/data/home_model.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/days_of_week.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class WeeklyPlanWidget extends StatefulWidget {
  const WeeklyPlanWidget({
    super.key,
     required this.homeModel, required this.onPressed,
  });

  // final DaysOfWeek daysOfWeek;
  final HomeModel homeModel;
  final void Function(BuildContext c,  int dayOfWeek,  WorkoutModel? selectedWorkout) onPressed;

  @override
  State<WeeklyPlanWidget> createState() => _WeeklyPlanWidgetState();
}

class _WeeklyPlanWidgetState extends State<WeeklyPlanWidget> {
  late List<String> days;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    days = getWeekdayNames(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderContainerColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 8,
            children: [
      
               Icon(Icons.calendar_today, color: AppColors.primaryBtnColor, size: 18,),
                             Text(
                context.i18n.weeklyPlan,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                  fontSize: 18
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 7,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final dayIndex = index + 1;
          
          
           final assignments = widget.homeModel.weeklyAssignments.isEmpty ? [ ]: widget.homeModel.weeklyAssignments
                            .where((workout) => workout.dayOfWeek == dayIndex)
                            .toList();
                        final workout = assignments.isEmpty ? null : assignments.first;
               
              
              return DaysOfWeekWidget(workout: workout, onPressed: (co, i, workout) =>  widget.onPressed(context, dayIndex, workout), dayOfWeek: dayIndex,);
            },
          ),
        ],
      ),
    );
  }
}
