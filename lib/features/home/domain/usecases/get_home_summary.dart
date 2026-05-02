import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/home/data/home_model.dart';
import 'package:scheda_palestra/features/home/data/repositories/home_repo.dart';

class GetHomeSummary {
  final HomeRepository repository;

  GetHomeSummary({required this.repository});

  Future<Either<Failure, HomeModel>> call() async {
    return await repository.getHomeSummary();
  }
}