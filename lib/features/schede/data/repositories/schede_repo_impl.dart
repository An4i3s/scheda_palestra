import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/data/datasources/schede_local_datasource.dart';
import 'package:scheda_palestra/features/schede/data/repositories/schede_repo.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';


class SchedeRepositoryImpl implements SchedeRepository {
  final SchedeLocalDatasource datasource;

  const SchedeRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<SchedaModel>>> getSchede() async {
    try {
      final models = await datasource.getSchede();
      return Right(models);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SchedaModel>> getSchedaById(String id) async {
    try {
      final model = await datasource.getSchedaById(id);
      return Right(model);
    } catch (e) {
      return Left(NotFoundFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SchedaModel>> saveScheda(SchedaModel scheda) async {
    try {
      final model = await datasource.saveScheda(scheda);
      return Right(model);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteScheda(String id) async {
    try {
      await datasource.deleteScheda(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}