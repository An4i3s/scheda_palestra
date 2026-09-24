import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
/// Logica del timer (nessun package esterno).
/// Vive fuori dalla UI: se chiudi il bottom sheet il timer continua.
class TimerController extends ChangeNotifier {
  Duration total = const Duration(minutes: 1);
  Duration remaining = const Duration(minutes: 1);
  bool running = false;
  bool finished = false;
 
  Timer? _ticker;
  DateTime? _endsAt;
 
  bool get isIdle => !running && !finished && remaining == total;
  double get progress =>
      total.inMilliseconds == 0 ? 0 : remaining.inMilliseconds / total.inMilliseconds;
 
  void setDuration(Duration d) {
    _stop();
    total = d;
    remaining = d;
    finished = false;
    notifyListeners();
  }
 
  void start() {
    if (running) return;
    if (remaining <= Duration.zero) remaining = total;
    finished = false;
    running = true;
    _endsAt = DateTime.now().add(remaining);
    _ticker = Timer.periodic(const Duration(milliseconds: 200), (_) => _tick());
    notifyListeners();
  }
 
  void pause() {
    if (!running) return;
    remaining = _endsAt!.difference(DateTime.now());
    if (remaining < Duration.zero) remaining = Duration.zero;
    _stop();
    notifyListeners();
  }
 
  void reset() {
    _stop();
    remaining = total;
    finished = false;
    notifyListeners();
  }
 
  void add(Duration d) {
    var next = remaining + d;
    if (next < Duration.zero) next = Duration.zero;
    if (next > const Duration(minutes: 99)) next = const Duration(minutes: 99);
    remaining = next;
    if (remaining > total) total = remaining;
    finished = false;
    if (running) {
      _endsAt = DateTime.now().add(remaining);
      if (remaining == Duration.zero) _finish();
    }
    notifyListeners();
  }
 
  void _tick() {
    final left = _endsAt!.difference(DateTime.now());
    if (left <= Duration.zero) {
      _finish();
      return;
    }
    // Aggiorna la UI solo quando cambia il secondo mostrato.
    if (_secs(left) != _secs(remaining)) {
      remaining = left;
      notifyListeners();
    } else {
      remaining = left;
    }
  }
 
  void _finish() {
    _stop();
    remaining = Duration.zero;
    finished = true;
    HapticFeedback.heavyImpact();
    SystemSound.play(SystemSoundType.alert);
    notifyListeners();
  }
 
  void _stop() {
    _ticker?.cancel();
    _ticker = null;
    running = false;
  }
 
  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
 
int _secs(Duration d) => (d.inMilliseconds + 999) ~/ 1000;
 
String formatTimer(Duration d) {
  final s = _secs(d);
  final m = (s ~/ 60).toString().padLeft(2, '0');
  final r = (s % 60).toString().padLeft(2, '0');
  return '$m:$r';
}