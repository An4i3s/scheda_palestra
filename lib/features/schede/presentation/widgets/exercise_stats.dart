 
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';

class Metrics extends StatelessWidget {
  const Metrics({super.key, required this.value, required this.title, this.description});

  final Object? value;
  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    final hasDescription = description != null && description!.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if(!hasDescription) Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blueGrey),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(width: 4),
          if (hasDescription)
            Expanded(
              child: Text(
                description!.trim(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey),
              ),
            )
          else if (hasValue)
            Text(
              value!.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blueGrey),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
        ],
      ),
    );
  }
}

class StrengthMetricsWidget extends StatelessWidget {
  const StrengthMetricsWidget({
    super.key,
    required this.series,
    required this.reps,
    required this.rest,
    required this.weight,
  });

  final int? series;
  final String? reps;
  final int? rest;
  final int? weight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 16) / 2;
        return Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            SizedBox(width: itemWidth, child: Metrics(title: context.i18n.serie, value: series ?? 0)),
            SizedBox(width: itemWidth, child: Metrics(title: context.i18n.reps, value: reps ?? '0')),
            SizedBox(width: itemWidth, child: Metrics(title: context.i18n.weight, value: weight ?? 0)),
            SizedBox(width: itemWidth, child: Metrics(title: context.i18n.rest, value: rest ?? 0)),
          ],
        );
      },
    );
  }
}

class CardioMetricsWidget extends StatelessWidget {
  const CardioMetricsWidget({
    super.key,
    required this.time,
    required this.km,
    required this.series,
  });

  final int? time;
  final int? km;
  final int? series;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 16) / 2;
        return Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            SizedBox(width: itemWidth, child: Metrics(title:  context.i18n.time, value: time ?? 0)),
            SizedBox(width: itemWidth, child: Metrics(title: context.i18n.km, value: km ?? 0)),
            SizedBox(width: itemWidth, child: Metrics(title:  context.i18n.serie, value: series ?? 0)),
          ],
        );
      },
    );
  }
}

class WalkingMetricsWidget extends StatelessWidget {
  const WalkingMetricsWidget({
    super.key,
    required this.time,
    required this.km,
    required this.series,
    required this.elevation,
  });

  final int? time;
  final int? km;
  final int? series;
  final int? elevation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 16) / 2;
        return Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            SizedBox(width: itemWidth, child: Metrics(title:  context.i18n.time, value: time ?? 0)),
            SizedBox(width: itemWidth, child: Metrics(title:  context.i18n.km, value: km ?? 0)),
            SizedBox(width: itemWidth, child: Metrics(title:  context.i18n.serie, value: series ?? 0)),
            SizedBox(width: itemWidth, child: Metrics(title:  context.i18n.elevation, value: elevation ?? 0)),
          ],
        );
      },
    );
  }
}

class GenericExerciseWidget extends StatelessWidget {
  const GenericExerciseWidget({
    super.key,
    required this.time,
    required this.series,
    required this.description,
  });

  final int? time;
  final int? series;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - 16) / 2;
        return Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            SizedBox(width: itemWidth, child: Metrics(title:  context.i18n.time, value: time ?? 0)),
            if (series != null)
              SizedBox(width: itemWidth, child: Metrics(title:  context.i18n.serie, value: series!)),
            if (description != null && description!.trim().isNotEmpty)
              SizedBox(
                width: itemWidth,
                child: Metrics(title:  context.i18n.description, value: null, description: description),
              ),
          ],
        );
      },
    );
  }
}
