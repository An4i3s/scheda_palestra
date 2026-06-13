import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_scheda.dart';

class SchedaCard extends StatefulWidget{
  const SchedaCard({super.key, required this.scheda, required this.onEdit, required this.onDelete});
  final SchedaModel scheda;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<SchedaCard> createState() => _SchedaCardState();
}

class _SchedaCardState extends State<SchedaCard> {
  bool _showExercises = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, left:16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.neutralColor,
        border: Border.all(color:Colors.grey, width: 1),
      ),
      child:  Center(child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                  Text(widget.scheda.nome, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: widget.onDelete, icon: Icon(Icons.delete, color: Colors.red, size: 18,),)
                  
            ],
          ),
          Text("Descrizione scheda"),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.amberAccent,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: const Text("Intermedio", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
              ),
              const SizedBox(width: 12),
              Text("${widget.scheda.esercizi.length} esercizi"),
              const SizedBox(width: 12),
              const Text("45 min"),
            ],
          ),
          SizedBox(
            width: 164,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _showExercises ?  Text("Nascondi esercizi", style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.w600),) :  Text("Mostra esercizi",  style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.w600)),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _showExercises = !_showExercises;
                    });
                  },
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: Center(
                      child: Icon(
                        _showExercises ? Icons.arrow_circle_up : Icons.arrow_circle_down,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_showExercises)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.scheda.esercizi
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: ExerciseInScheda(index: widget.scheda.esercizi.indexOf(e)+1, exercise: e,),
                      ))
                  .toList(),
            ),
        ],
      )),
    );
  }
}