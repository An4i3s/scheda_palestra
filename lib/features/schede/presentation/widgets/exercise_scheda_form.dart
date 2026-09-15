import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/presentation/widgets/exercise_stats_list.dart';

class ExerciseSchedaForm extends StatefulWidget {
  final List<ExerciseModel> esercizi;
  final void Function(int index) onDelete;
  final void Function(int index, ExerciseModel e) onEdit;

  const ExerciseSchedaForm({
    super.key,
    required this.esercizi,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<ExerciseSchedaForm> createState() => _ExerciseSchedaFormState();
}

class _ExerciseSchedaFormState extends State<ExerciseSchedaForm> {
  void _reorderEsercizi(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = widget.esercizi.removeAt(oldIndex);
      widget.esercizi.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      proxyDecorator: (Widget child, int index, Animation<double> animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Material(
              color: Colors.transparent, // 👈 removes the grey background
              elevation: 16, // 👈 removes the shadow
              child: child,
            );
          },
          child: child,
        );
      },
      // proxyDecorator: (Widget child, int index, Animation<double> animation) {
      //   return child; // returns the item as-is, no Material wrapper, no elevation/background
      // },
      dragStartBehavior: DragStartBehavior.down,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.esercizi.length,
      onReorder: _reorderEsercizi,
      itemBuilder: (context, index) {
        final e = widget.esercizi[index];
        return Card(
          key: Key(index.toString()),
          child: ListTile(
            contentPadding: EdgeInsets.only(top: 8, left: 8, bottom: 8),
            selectedTileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
            selected: true,
            key: ValueKey(index),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.drag_indicator,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                e.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: ExerciseStatsList(exerciseModel: e),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () =>
                      widget.onEdit(widget.esercizi.indexOf(e), e),
                  icon: SvgPicture.asset(
                    "assets/icons/edit.svg",
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () =>
                      widget.onDelete(widget.esercizi.indexOf(e)),
                  icon: SvgPicture.asset(
                    "assets/icons/trash.svg",
                    colorFilter: ColorFilter.mode(
                      AppColors.accentColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
