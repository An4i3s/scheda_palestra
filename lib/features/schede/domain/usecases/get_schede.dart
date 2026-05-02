
import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/data/repositories/schede_repo.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class GetSchede {
  final SchedeRepository repository;
  const GetSchede({required this.repository});

  Future<Either<Failure, List<SchedaModel>>> call() {
    return repository.getSchede();
  }
}