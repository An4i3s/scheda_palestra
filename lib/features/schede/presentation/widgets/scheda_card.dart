import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_scheda.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/scheda_delete_dialog.dart';

class SchedaCard extends StatefulWidget {
  const SchedaCard({
    super.key,
    required this.scheda,
    required this.onEdit,
    required this.onDelete,
  });
  final SchedaModel scheda;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  State<SchedaCard> createState() => _SchedaCardState();
}

class _SchedaCardState extends State<SchedaCard> {
  final _controller = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.neutralColor,
        border: Border.all(color: Colors.grey[350] ?? Colors.grey, width: 1),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.scheda.nome,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      constraints: BoxConstraints( maxHeight: 22),
                      padding: EdgeInsets.zero,
                      onPressed: widget.onEdit,
                      icon: SvgPicture.asset("assets/icons/edit.svg", colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
                    ),
                    IconButton(
                      constraints: BoxConstraints(maxHeight: 48),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showDialog(context: context, builder: (c){
                          return SchedaDeleteDialog(schedaModel: widget.scheda, onDelete: widget.onDelete,);
                        });
                      },
                      icon: SvgPicture.asset("assets/icons/trash.svg",colorFilter: ColorFilter.mode(AppColors.accentColor, BlendMode.srcIn),),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              widget.scheda.descrizione.isNotEmpty
                  ? widget.scheda.descrizione
                  : context.i18n.noDescription,
              style: TextStyle(
                color: widget.scheda.descrizione.isNotEmpty
                    ? Colors.black87
                    : Colors.grey[600],
              ),
            ),
            SizedBox(height: 4,),
            // Text("${widget.scheda.esercizi.length} esercizi"),
            Text(context.i18n.exercisesCount2(widget.scheda.esercizi.length)),
            Expansible(
              headerBuilder:
                  (BuildContext context, Animation<double> animation) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: _controller.isExpanded
                          ? Text(
                              context.i18n.hideExercise,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : Text(
                              context.i18n.showExercise,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      onTap: () {
                        if (_controller.isExpanded) {
                          _controller.collapse();
                        } else {
                          _controller.expand();
                        }
                      },
                      trailing: RotationTransition(
                        
                        turns: Tween<double>(
                          begin: 0.0,
                          end: 0.5,
                        ).animate(animation),
                        child: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
              bodyBuilder: (BuildContext context, Animation<double> animation) {
                final exercises = widget.scheda.esercizi
                    .where((e) => e is ExerciseModel)
                    .map((e) => e as ExerciseModel)
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: exercises
                      .asMap()
                      .entries
                      .map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: ExerciseInScheda(
                            index: entry.key + 1,
                            exercise: entry.value,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
