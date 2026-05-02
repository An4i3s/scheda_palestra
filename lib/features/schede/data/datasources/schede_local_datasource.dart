import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

/// Contratto per il datasource locale.
/// In futuro può essere sostituito con Hive, SQLite, ecc.
abstract class SchedeLocalDatasource {
  Future<List<SchedaModel>> getSchede();
  Future<SchedaModel> getSchedaById(String id);
  Future<SchedaModel> saveScheda(SchedaModel scheda);
  Future<void> deleteScheda(String id);
}

