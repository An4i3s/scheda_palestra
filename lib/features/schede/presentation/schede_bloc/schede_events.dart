

import 'package:equatable/equatable.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

abstract class SchedeEvent extends Equatable {
  const SchedeEvent();

  @override
  List<Object?> get props => [];
}

/// Carica la lista delle schede all'avvio della pagina.
class SchedeStarted extends SchedeEvent {
  const SchedeStarted();
}

/// Salva (crea o aggiorna) una scheda.
class SchedaSaved extends SchedeEvent {
  final SchedaModel scheda;
  const SchedaSaved(this.scheda);

  @override
  List<Object?> get props => [scheda];
}

/// Elimina una scheda tramite id.
class SchedaDeleted extends SchedeEvent {
  final String id;
  const SchedaDeleted(this.id);

  @override
  List<Object?> get props => [id];
}