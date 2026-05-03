import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:scheda_palestra/core/utils/router/app_router.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_model_adapter.dart';
import 'package:scheda_palestra/features/exercises/data/models/exercise_type_model_adapter.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model_adapter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SchedaModelAdapter());
  Hive.registerAdapter(ExerciseModelAdapter());
  Hive.registerAdapter(ExerciseTypeModelAdapter());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
    );
  }
}