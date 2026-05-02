import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/home/data/datasources/home_local_datasource_impl.dart';
import 'package:scheda_palestra/features/home/data/home_model.dart';
import 'package:scheda_palestra/features/home/data/repositories/home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDatasource datasource;

  const HomeRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, HomeModel>> getHomeSummary() async {
    try {
      final summary = await datasource.getHomeSummary();
      return Right(summary);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}