import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/core/i18n/local_cubit.dart';
import 'package:scheda_palestra/core/theme/app_theme.dart';

import 'package:scheda_palestra/core/utils/router/app_router.dart';
import 'package:scheda_palestra/features/schede/data/models/exercise_model_adapter.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model_adapter.dart';
import 'package:scheda_palestra/features/workout/data/model/workout_model_adapter.dart';
import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model_adapter.dart';
import 'package:scheda_palestra/l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SchedaModelAdapter());
  Hive.registerAdapter(ExerciseModelAdapter());
  Hive.registerAdapter(WorkoutModelAdapter());
  Hive.registerAdapter(WorkoutLogModelAdapter());
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
        );
      }
    );
  }
}