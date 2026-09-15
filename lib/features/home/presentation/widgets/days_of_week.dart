
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/core/utils/weekday_name.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class DaysOfWeekWidget extends StatefulWidget {
  const DaysOfWeekWidget({
    super.key,
    required this.workout, required this.onPressed, required this.dayOfWeek,
  });

  final WorkoutModel? workout;
  final void Function(BuildContext c, int? selectedDay, WorkoutModel? selectedWorkout) onPressed;
  final int dayOfWeek;

  @override
  State<DaysOfWeekWidget> createState() => _DaysOfWeekWidgetState();
}

class _DaysOfWeekWidgetState extends State<DaysOfWeekWidget> {
  late List<String> days;

  //prevede una diversa Box decoration a secondo dello stato
  bool _isToday(){
    int currentDay = DateTime.now().weekday;
    // final days = getWeekdayNames(context); 
    return currentDay == widget.dayOfWeek; 
  }

  BoxDecoration _getBoxDecoration(){
    if(_isToday()){
      return BoxDecoration(
        color: AppColors.primaryColor,
         borderRadius: BorderRadius.circular(16),
      );
    }
    if(widget.workout==null){
      return BoxDecoration(
          color: Color(0xFFf6fbfb),
          borderRadius: BorderRadius.circular(16),
        );
    }else{
      return BoxDecoration(
        color: AppColors.containerColor,
         borderRadius: BorderRadius.circular(16),
         border: Border.all(color: AppColors.secondaryBorderContainerColor)
      );
    }
  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    days = getWeekdayNamesMondayFirst(context);
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>  widget.onPressed(context,  widget.dayOfWeek, widget.workout),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: _getBoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 16,
          children: [
            SizedBox(
              width: 42,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    days[widget.dayOfWeek-1].toUpperCase(),
                    style:  TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color:  _isToday() ? Colors.white :Colors.black
                    ),
                  ),
                   Container(width: 1, height: 20, 
            color: _isToday() ? Colors.white : widget.workout==null ? AppColors.greyTextColor :AppColors.primaryColor,
            ),
                ],
              ),
            ),
                       
            widget.workout!=null ? Text("🏋️") : Icon(Icons.add, size: 16,),
            Expanded(
              child: Text(
                widget.workout?.scheda.nome ?? context.i18n.rest,
                style: TextStyle(
                  fontSize: 16,
                  color:  _isToday() ? Colors.white : widget.workout != null
                      ? AppColors.textColor
                      : Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}