import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/core/i18n/local_cubit.dart';
import 'package:scheda_palestra/core/theme/app_theme.dart';

import 'package:scheda_palestra/core/utils/router/app_router.dart';
import 'package:scheda_palestra/core/widgets/custom_keyboard_host.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model_adapter.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model_adapter.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model_adapter.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model_adapter.dart';
import 'package:scheda_palestra/l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> _registerHiveAdapters() async {
  if (!Hive.isAdapterRegistered(SchedaModelAdapter().typeId)) {
    Hive.registerAdapter(SchedaModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ExerciseModelAdapter().typeId)) {
    Hive.registerAdapter(ExerciseModelAdapter());
  }
  if (!Hive.isAdapterRegistered(WorkoutModelAdapter().typeId)) {
    Hive.registerAdapter(WorkoutModelAdapter());
  }
  if (!Hive.isAdapterRegistered(WorkoutLogModelAdapter().typeId)) {
    Hive.registerAdapter(WorkoutLogModelAdapter());
  }
}

bool _isValidLegacyValue(String boxName, Object? value) {
  switch (boxName) {
    case 'schede':
      return value is SchedaModel;
    case 'workouts':
      return value is WorkoutModel;
    case 'workout_logs':
      return value is WorkoutLogModel;
    default:
      return value != null;
  }
}

Future<void> _clearLegacyHiveBoxes() async {
  const boxNames = ['schede', 'workouts', 'workout_logs'];

  for (final boxName in boxNames) {
    try {
      final exists = await Hive.boxExists(boxName);
      if (!exists) continue;

      if (Hive.isBoxOpen(boxName)) {
        final openBox = Hive.box<dynamic>(boxName);
        if (openBox.isOpen) {
          await openBox.close();
        }
      }

      Box<dynamic> legacyBox;
      try {
        legacyBox = await Hive.openBox<dynamic>(boxName);
      } on HiveError catch (_) {
        await Hive.deleteBoxFromDisk(boxName);
        continue;
      } catch (_) {
        await Hive.deleteBoxFromDisk(boxName);
        continue;
      }

      try {
        final staleKeys = <dynamic>[];
        for (final entry in legacyBox.toMap().entries) {
          final value = entry.value;
          if (!_isValidLegacyValue(boxName, value)) {
            staleKeys.add(entry.key);
          }
        }

        for (final key in staleKeys) {
          try {
            await legacyBox.delete(key);
          } catch (_) {}
        }
      } catch (_) {
        await Hive.deleteBoxFromDisk(boxName);
      } finally {
        if (legacyBox.isOpen) {
          await legacyBox.close();
        }
      }
    } catch (_) {
      try {
        await Hive.deleteBoxFromDisk(boxName);
      } catch (_) {}
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await _registerHiveAdapters();
  await _clearLegacyHiveBoxes();

  runApp(
    BlocProvider(
      create: (_) => LocaleCubit(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: locale,
          supportedLocales: const [
            Locale('it'),
            Locale('en'),
            Locale('es'),
            Locale('fr'),
          ],
           localizationsDelegates:  [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.lightTheme, 
          routerConfig: AppRouter.router,
          builder: (context, child) {
            return Stack(
              children: [
                if (child != null) child,
                const CustomKeyboardHost(),
              ],
            );
          }
        );
      }
    );
  }
}