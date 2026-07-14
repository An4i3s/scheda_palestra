 
import 'package:flutter/material.dart';

class Metrics extends StatelessWidget {
  const Metrics({super.key, required this.value, required this.title, this.description});

  final int? value;
  final String title;
  final String? description;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title:"),
        const SizedBox(width: 4),
        if(value!=null) Text(value!.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
        if (description != null)
          Expanded(
            child: Text(
              description!,
              style: const TextStyle(fontWeight: FontWeight.bold),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
      ],
    );
  }
}

class StrengthMetricsWidget extends StatelessWidget {
  const StrengthMetricsWidget({super.key, required this.series, required this.reps, required this.rest, required this.weight});
  final int? series ;
  final int? reps ;
  final int? rest;
  final int? weight;

  @override
  Widget build(BuildContext context) =>              GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 6,
                  children: [
                     Metrics(title: 'Serie', value: series??0, ),
                     Metrics(title: 'Reps', value: reps??0, ),
                     Metrics(title: 'Weight', value: weight??0, ),
                     Metrics(title: 'Rest', value: rest??0, ),
                  ]);
  

}

class CardioMetricsWidget extends StatelessWidget {
  const CardioMetricsWidget({super.key, required this.time, required this.km, required this.series});
  final int? time;
  final int? km;
  final int? series;

  @override
  Widget build(BuildContext context) => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 6,
                  children: [
                     Metrics(title: 'Time', value: time??0, ),
                     Metrics(title: 'Km', value: km??0, ),
                     Metrics(title: 'Series', value: series??0, ),
                  ]);
}


class WalkingMetricsWidget extends StatelessWidget {
  const WalkingMetricsWidget({super.key, required this.time, required this.km, required this.series, required this.elevation});
  final int? time;
  final int? km;
  final int? series;
  final int? elevation;

  @override
  Widget build(BuildContext context) => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 6,
                  children: [
                     Metrics(title: 'Time', value: time??0, ),
                     Metrics(title: 'Km', value: km??0, ),
                     Metrics(title: 'Series', value: series??0, ),
                     Metrics(title: 'Elevation', value: elevation??0, ),
                  ]);
}

class GenericExerciseWidget extends StatelessWidget {
  const GenericExerciseWidget({super.key, required this.time, required this.series, required this.description});
  final int? time;
  final int? series;
  final String? description;

  @override
  Widget build(BuildContext context) => GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 6,
                  children: [
                     Metrics(title: 'Time', value: time??0, ),
                     if(series!=null) Metrics(title: 'Series', value: series!, ),
                     if(description!=null) Metrics(title: 'Description', value: null, description: description, ),
                  ]);
}
