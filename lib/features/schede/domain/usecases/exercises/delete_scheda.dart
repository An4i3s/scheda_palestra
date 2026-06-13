
import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/schede/data/repositories/schede_repo.dart';

class DeleteScheda {
  final SchedeRepository repository;
  const DeleteScheda({required this.repository});

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteScheda(id);
  }
}