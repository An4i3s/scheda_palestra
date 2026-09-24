import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scheda_palestra/core/back_up_service/back_up_abstract.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

class BoxConfig<T extends BackupableModel> {
  final String name;
  final T Function(Map<String, dynamic>) fromJson;
  final Future<Box<T>> Function() openBox;

  BoxConfig({required this.name, required this.fromJson, required this.openBox});
}

class BackupService {
  static final List<BoxConfig> _configs = [
    BoxConfig<SchedaModel>(
      name: 'schede',
      fromJson: SchedaModel.fromJson,
      openBox: () async => Hive.isBoxOpen('schede') ? Hive.box<SchedaModel>('schede') : await Hive.openBox<SchedaModel>('schede'),
    ),
    BoxConfig<WorkoutModel>(
      name: 'workouts',
      fromJson: WorkoutModel.fromJson,
      openBox: () async => Hive.isBoxOpen('workouts') ? Hive.box<WorkoutModel>('workouts') : await Hive.openBox<WorkoutModel>('workouts'),
    ),
    BoxConfig<WorkoutLogModel>(
      name: 'workout_logs',
      fromJson: WorkoutLogModel.fromJson,
      openBox: () async => Hive.isBoxOpen('workout_logs') ? Hive.box<WorkoutLogModel>('workout_logs') : await Hive.openBox<WorkoutLogModel>('workout_logs'),
    ),
  ];

  static Future<File> exportBackup() async {
    final Map<String, dynamic> boxesData = {};

    for (final config in _configs) {
      final box = await config.openBox();
      try {
        final entries = <String, dynamic>{};

        for (final key in box.keys) {
          final value = box.get(key);
          if (value is! BackupableModel) continue;
          entries[key.toString()] = value.toJson();
        }

        boxesData[config.name] = entries;
      } finally {
        if (box.isOpen) {
          await box.close();
        }
      }
    }

    final backupData = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'boxes': boxesData,
    };

    final jsonString = jsonEncode(backupData);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/backup_${DateTime.now().millisecondsSinceEpoch}.miobackup');
    await file.writeAsString(jsonString);
    return file;
  }

  static Future<void> importBackup(File file) async {
    final jsonString = await file.readAsString();
    final decoded = jsonDecode(jsonString);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Backup non valido');
    }

    final version = decoded['version'] is int ? decoded['version'] as int : 1;
    if (version > 1) {
      throw Exception('Backup creato con una versione più recente dell\'app');
    }

    final rawBoxes = decoded['boxes'];
    if (rawBoxes is! Map) {
      throw Exception('Backup senza contenuto');
    }

    final boxesData = <String, Map<String, dynamic>>{};
    for (final entry in rawBoxes.entries) {
      final value = entry.value;
      if (value is Map) {
        boxesData[entry.key.toString()] = Map<String, dynamic>.from(value);
      }
    }

    for (final config in _configs) {
      final boxData = boxesData[config.name];
      if (boxData == null || boxData.isEmpty) continue;

      final box = await config.openBox();
      try {
        final merged = <String, dynamic>{
          for (final currentEntry in box.toMap().entries)
            currentEntry.key.toString(): currentEntry.value,
        };

        for (final entry in boxData.entries) {
          final value = entry.value;
          if (value is! Map) continue;

          try {
            final obj = config.fromJson(Map<String, dynamic>.from(value));
            merged[entry.key.toString()] = obj;
          } catch (_) {
            // record legacy invalido: lo ignoro senza bloccare l'import
          }
        }

        await box.clear();
        for (final entry in merged.entries) {
          final value = entry.value;
          if (value is BackupableModel) {
            await box.put(entry.key, value);
          }
        }
      } finally {
        if (box.isOpen) {
          await box.close();
        }
      }
    }
  }
}