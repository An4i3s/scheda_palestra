

import 'package:dartz/dartz.dart';
import 'package:scheda_palestra/core/utils/failures.dart';
import 'package:scheda_palestra/features/home/data/home_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel >> getHomeSummary();
}