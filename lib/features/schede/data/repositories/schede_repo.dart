import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';


abstract class SchedeRepository {
  Future<Either<Failure, List<SchedaModel>>> getSchede();
  Future<Either<Failure, SchedaModel>> getSchedaById(String id);
  Future<Either<Failure, SchedaModel>> saveScheda(SchedaModel scheda);
  Future<Either<Failure, void>> deleteScheda(String id);
}