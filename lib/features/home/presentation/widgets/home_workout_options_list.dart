import 'package:flutter/material.dart';
import 'package:scheda_palestra/features/home/presentation/widgets/home_workout_options.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';

class HomeWorkoutOptionsList extends StatefulWidget {
  final List<SchedaModel> schede;
  final WorkoutModel? selectedModel;
  final Function(String? id) onChanged;

  const HomeWorkoutOptionsList({
    super.key,
    required this.schede,
    required this.onChanged,
    required this.selectedModel,
  });

  @override
  State<HomeWorkoutOptionsList> createState() => _HomeWorkoutOptionsListState();
}

class _HomeWorkoutOptionsListState extends State<HomeWorkoutOptionsList> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    // if (widget.selectedModel!=null && widget.selectedModel?.scheda!=null) {
    //   setState(() {
    //     _selectedIndex = (widget.schede.indexOf(widget.selectedModel!.scheda));
    //   });
    // } 

      final schedaId = widget.selectedModel?.scheda.id;
  if (schedaId != null) {
    final idx = widget.schede.indexWhere((s) => s.id == schedaId);
    _selectedIndex = idx == -1 ? null : idx; // -1 -> null, non "riposo selezionato per errore"
  }
    
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        HomeWorkoutOptions(
          isRest: true,
          schedaName: '',
          onTap: () {
            setState(() {
              _selectedIndex = null;
             
            });
             widget.onChanged(null);
          },
          isSelected: _selectedIndex == null,
        ),
        ...widget.schede.map(
          (e) => HomeWorkoutOptions(
            isRest: false,
            schedaName: e.nome,
            onTap: () {
              setState(() {
                _selectedIndex = widget.schede.indexOf(e);
                
              });
               widget.onChanged(widget.schede[_selectedIndex!].id);
            },
            isSelected: _selectedIndex == widget.schede.indexOf(e),
          ),
        ),
      ],
    );
  }
}
