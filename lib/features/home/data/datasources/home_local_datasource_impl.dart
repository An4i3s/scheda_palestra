
import 'package:scheda_palestra/features/home/data/home_model.dart';

abstract class HomeLocalDatasource {
  Future<HomeModel> getHomeSummary();
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  @override
  Future<HomeModel> getHomeSummary() async {
    // TODO: leggere dati reali da storage
    return const HomeModel(totalWorkouts: 0, lastWorkoutName: null);
  }
}