import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scheda_palestra/core/i18n/local_cubit.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

class WorkoutLogCard extends StatelessWidget {
  const WorkoutLogCard({
    super.key,
    required ExpansibleController controller,
    required this.workoutLogModel,
  }) : _controller = controller;

  final ExpansibleController _controller;
  final WorkoutLogModel workoutLogModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderContainerColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              spacing: 16,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(0xFFc8e8ea),
                  ),
                  child: Text("🏋🏻‍♀️", style: TextStyle(fontSize: 16)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      workoutLogModel.workout.scheda.nome,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Text("🗓️", style: TextStyle(fontSize: 12)),
                        Text(
                          DateFormat(
                            "dd MMMM yyyy HH:mm",
                            context.read<LocaleCubit>().state.toString(),
                          ).format(workoutLogModel.date),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Divider(
            color: AppColors.borderContainerColor,
            height: 2,
            thickness: 2,
          ),
          Expansible(
            headerBuilder: (BuildContext context, Animation<double> animation) {
              return ListTile(
                title: Text(
                  context.i18n.exercisesCount2(workoutLogModel.workout.scheda.esercizi.length),
                  style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
                onTap: () {
                  if (_controller.isExpanded) {
                    _controller.collapse();
                  } else {
                    _controller.expand();
                  }
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _controller.isExpanded ? context.i18n.close : context.i18n.details,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RotationTransition(
                      turns: Tween<double>(
                        begin: 0.0,
                        end: 0.5,
                      ).animate(animation),
                      child: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            },
            bodyBuilder: (BuildContext context, Animation<double> animation) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...workoutLogModel.workout.scheda.esercizi.map(
                    (e) => Container(
                      padding: EdgeInsets.all(16),
                      color: Color(0xFFfafdfd),
                      child: Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 16,
                            children: [
                              Expanded(
                                child: Row(
                                  spacing: 16,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFe6f3f5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        (workoutLogModel.workout.scheda.esercizi
                                                    .indexOf(e) +
                                                1)
                                            .toString(),
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        e.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Wrap(
                                  spacing: 8,
                                  
                                  children: [
                                    if (e.km != null)
                                      Text(
                                        "Km ${e.km}",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    if (e.repetitions != null)
                                      Text(
                                        "Reps ${e.repetitions}",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    if (e.series != 0)
                                      Text(
                                        "Series ${e.series}",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    if (e.elevation != null)
                                      Text(
                                        "Elev. ${e.elevation}",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    if (e.weight != null && e.weight!=0)
                                      Text(
                                        "Weight ${e.weight}",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 12,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // ExerciseStatsList(exerciseModel: e),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
