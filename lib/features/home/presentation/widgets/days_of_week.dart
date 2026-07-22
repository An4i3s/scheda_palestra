
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/home/presentation/views/home_page.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class DaysOfWeekWidget extends StatefulWidget {
  const DaysOfWeekWidget({
    super.key,
    required this.workout, required this.onPressed, required this.dayOfWeek,
  });

  final WorkoutModel? workout;
  final void Function(BuildContext c, int? selectedDay, WorkoutModel? selectedWorkout) onPressed;
  final DaysOfWeek dayOfWeek;

  @override
  State<DaysOfWeekWidget> createState() => _DaysOfWeekWidgetState();
}

class _DaysOfWeekWidgetState extends State<DaysOfWeekWidget> {
  //prevede una diversa Box decoration a secondo dello stato

  bool _isToday(){
    int currentDay = DateTime.now().weekday;
    return currentDay == DaysOfWeek.values.indexOf(widget.dayOfWeek)+1; 
  }

  BoxDecoration _getBoxDecoration(){
    if(_isToday()){
      return BoxDecoration(
        color: Color(0xFF00a0aa),
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
        color: Color(0xFFeff8f8),
         borderRadius: BorderRadius.circular(16),
         border: Border.all(color: Color(0xFFc9e7e8))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>  widget.onPressed(context,  DaysOfWeek.values.indexOf(widget.dayOfWeek)+1, widget.workout),
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
                    widget.dayOfWeek.name,
                    style:  TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color:  _isToday() ? Colors.white :Colors.black
                    ),
                  ),
                   Container(width: 1, height: 20, 
            color: _isToday() ? Colors.white :AppColors.setsTextColors,
            ),
                ],
              ),
            ),
                       
            widget.workout!=null ? Text("🏋️") : Icon(Icons.add, size: 16,),
            Text(
              widget.workout?.scheda.nome ?? 'Riposo',
              style: TextStyle(
                fontSize: 16,
                color:  _isToday() ? Colors.white : widget.workout != null
                    ? AppColors.textColor
                    : Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}