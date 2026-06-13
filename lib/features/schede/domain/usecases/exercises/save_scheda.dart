import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/data/repositories/schede_repo.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class SaveScheda{
  final SchedeRepository repository;
  const SaveScheda({required this.repository});
 
  Future<Either<Failure, SchedaModel>> call(SchedaModel params) {
    return repository.saveScheda(params);
  }
}
 