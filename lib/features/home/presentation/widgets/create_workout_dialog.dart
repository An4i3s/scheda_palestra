import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/home/presentation/views/home_page.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/home_workout_options.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/home_workout_options_list.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class CreateWorkoutBottomSheet extends StatefulWidget {
  final List<SchedaModel> schede;
  final Function(WorkoutModel) onCreateWorkout;
  final Function(WorkoutModel) onDeleteWorkout;
  final int selectedDay;
  final WorkoutModel? selectedWorkout;

  const CreateWorkoutBottomSheet({
    super.key,
    required this.schede,
    required this.onCreateWorkout, required this.selectedDay, this.selectedWorkout, required this.onDeleteWorkout
  });

  @override
  State<CreateWorkoutBottomSheet> createState() => _CreateWorkoutBottomSheetState();
}

class _CreateWorkoutBottomSheetState extends State<CreateWorkoutBottomSheet> {
  String? _selectedSchedaId;

  @override
  void initState() {
    super.initState();
   _selectedSchedaId = widget.selectedWorkout?.scheda.id;
  }

  void _createAndClose(){
    
 if (_selectedSchedaId == null) {
    if (widget.selectedWorkout != null) {
      widget.onDeleteWorkout(widget.selectedWorkout!);
    }
    Navigator.pop(context);
    return;
  }

final selectedScheda = widget.schede
                          .firstWhere((s) => s.id == _selectedSchedaId);
                      final workout = WorkoutModel(
                        id: widget.selectedWorkout?.id ??  DateTime.now().millisecondsSinceEpoch.toString(),
                        completedExercises: [],
                        date: DateTime.now(),
                        dayOfWeek: widget.selectedDay,
                        scheda: selectedScheda,
                      );
                      widget.onCreateWorkout(workout);
                      Navigator.pop(context);
                          
                      
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DaysOfWeek.values[widget.selectedDay-1].name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                   Text("Schegli una scheda da assegnare"),
                ],
              ),
              IconButton(onPressed:  
              _createAndClose
               
                      
              , 
              icon: Icon(Icons.close))
            ],
          ),
          widget.schede.isEmpty ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text("Nessuna scheda disponibile. Creane una nel tab Schede!"),
          ) : HomeWorkoutOptionsList(
            schede: widget.schede, onChanged: (i) {
            setState(() {
              _selectedSchedaId = i;
            });
            }, 
            selectedModel: widget.selectedWorkout,)
        ],
      ),
    );
    
  
  }
}
