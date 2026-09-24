
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scheda_palestra/features/schede/data/datasources/schede_local_datasource.dart';
import 'package:scheda_palestra/features/schede/data/models/scheda_model.dart';

class SchedeLocalDatasourceImpl implements SchedeLocalDatasource {
  static const _boxName = 'schede';

  Future<Box<SchedaModel>> get _box async {
    if (Hive.isBoxOpen(_boxName)) {
      try {
        final existing = Hive.box<SchedaModel>(_boxName);
        if (existing.isOpen) return existing;
      } catch (_) {
        final staleBox = Hive.box<SchedaModel>(_boxName);
        if (staleBox.isOpen) {
          await staleBox.close();
        }
      }
    }

    return Hive.openBox<SchedaModel>(_boxName);
  }

  @override
  Future<List<SchedaModel>> getSchede() async {
    final box = await _box;
    return box.values.toList();
  }

  @override
  Future<SchedaModel> getSchedaById(String id) async {
    final box = await _box;
    final scheda = box.get(id);
    if (scheda == null) throw Exception('Scheda $id non trovata');
    return scheda;
  }

  @override
  Future<SchedaModel> saveScheda(SchedaModel scheda) async {
    final box = await _box;
    await box.put(scheda.id, scheda);
    return scheda;
  }

  @override
  Future<void> deleteScheda(String id) async {
    final box = await _box;
    await box.delete(id);
  }
}