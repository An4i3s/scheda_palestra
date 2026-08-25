// lib/domain/workout_stats.dart

import 'package:scheda_palestra/features/workout_log/data/model/workout_log_model.dart';

extension WorkoutStats on List<WorkoutLogModel> {
  int get currentStreak {
    if (isEmpty) return 0;
    
    final dates = map((w) => DateTime(w.date.year, w.date.month, w.date.day))
        .toSet() // rimuove duplicati stesso giorno
        .toList()
      ..sort((a, b) => b.compareTo(a)); // dal più recente

    final today = DateTime.now();
    final todayNormalized = DateTime(today.year, today.month, today.day);
    
    // Lo streak è valido solo se l'ultimo workout è oggi o ieri
    final mostRecent = dates.first;
    final gapFromToday = todayNormalized.difference(mostRecent).inDays;
    if (gapFromToday > 1) return 0;

    int streak = 1;
    for (int i = 0; i < dates.length - 1; i++) {
      final diff = dates[i].difference(dates[i + 1]).inDays;
      if (diff == 1) {
        streak++;
      } else if (diff > 1) {
        break;
      }
    }
    return streak;
  }

  int countInMonth(DateTime month) {
    return where((w) => w.date.year == month.year && w.date.month == month.month).length;
  }
}