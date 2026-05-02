import 'package:equatable/equatable.dart';

/// Base class per tutti gli errori del dominio.
/// Usato insieme a [dartz.Either] nei repository e use case.
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Errore nella cache locale']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Errore di rete']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Elemento non trovato']);
}

