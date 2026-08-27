import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scheda_palestra/core/back_up_service/back_up_abstract.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

class BoxConfig<T extends BackupableModel> {
  final String name;
  final T Function(Map<String, dynamic>) fromJson;

  BoxConfig({required this.name, required this.fromJson});
}

class BackupService {
  static final List<BoxConfig> _configs = [
    BoxConfig<ExerciseModel>(name: 'exercises', fromJson: ExerciseModel.fromJson),
    BoxConfig<SchedaModel>(name: 'categories', fromJson: SchedaModel.fromJson),
    BoxConfig<WorkoutModel>(name: 'notes', fromJson: WorkoutModel.fromJson),
    BoxConfig<WorkoutLogModel>(name: 'exercises', fromJson: WorkoutLogModel.fromJson),
  ];

  static Future<File> exportBackup() async {
    final Map<String, dynamic> boxesData = {};

    for (final config in _configs) {
      final box = await Hive.openBox(config.name);
      boxesData[config.name] = {
        for (final key in box.keys)
          key.toString(): (box.get(key) as BackupableModel).toJson(),
      };
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
    final Map<String, dynamic> data = jsonDecode(jsonString);

    final version = data['version'] as int;
    if (version > 1) {
      throw Exception('Backup creato con una versione più recente dell\'app');
    }

    final boxesData = data['boxes'] as Map<String, dynamic>;

    for (final config in _configs) {
      final boxData = boxesData[config.name] as Map<String, dynamic>?;
      if (boxData == null) continue;

      final box = await Hive.openBox(config.name);
      await box.clear();
      for (final entry in boxData.entries) {
        final obj = config.fromJson(entry.value as Map<String, dynamic>);
        await box.put(entry.key, obj);
      }
    }
  }
}