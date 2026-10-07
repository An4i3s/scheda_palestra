
import 'package:flutter/material.dart';
import 'package:scheda_palestra/core/i18n/local_extension.dart';
import 'package:scheda_palestra/core/theme/app_colors.dart';
import 'package:scheda_palestra/features/workout/presentation/widgets/timer_controller.dart';


class TimerButton extends StatelessWidget {
  const TimerButton({super.key, required this.controller});
  final TimerController controller;
 
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => showTimerSheet(context, controller),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 42, vertical: 16),
            width: 140,
        decoration: BoxDecoration(color: AppColors.darkContainerColor, shape: BoxShape.circle),
            child: Column(
              spacing: 4,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(controller.finished ? Icons.alarm_on : Icons.timer_outlined, color: AppColors.accentColor, size: 32,),
                if(!controller.isIdle ) Text(controller.isIdle ? "" : formatTimer(controller.remaining), style: TextStyle(color: AppColors.accentColor,),),
              ],
            ),
          ),
        );
      },
    );
  }
}
 
Future<void> showTimerSheet(BuildContext context, TimerController controller) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (_) => TimerSheet(controller: controller),
  );
}
 
class TimerSheet extends StatelessWidget {
  const TimerSheet({super.key, required this.controller});
  final TimerController controller;
 
  static const _presets = [
    Duration(seconds: 30),
    Duration(minutes: 1),
    Duration(minutes: 1, seconds: 30),
    Duration(minutes: 2),
    Duration(minutes: 3),
    Duration(minutes: 5),
  ];
 
  @override
  Widget build(BuildContext context) {
    final c = controller;
    final theme = Theme.of(context);
 
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: ListenableBuilder(
          listenable: c,
          builder: (context, _) {
            final label = c.running
                ? context.i18n.pause
                : c.finished
                    ? context.i18n.restart
                    : c.remaining != c.total
                        ? context.i18n.resume
                        : context.i18n.start;
 
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(context.i18n.timer, style: theme.textTheme.titleLarge),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      tooltip: context.i18n.close,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: CircularProgressIndicator(
                          value: c.finished ? 1 : c.progress,
                          strokeWidth: 8,
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          color: c.finished ? theme.colorScheme.error : AppColors.primaryColor,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            formatTimer(c.remaining),
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontFeatures: const [FontFeature.tabularFigures()],
                            ),
                          ),
                          if (c.finished) Text("Finished", style: theme.textTheme.titleMedium),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final d in _presets)
                      ChoiceChip(
                        label: Text(formatTimer(d)),
                        color: WidgetStatePropertyAll(AppColors.containerColor),
                        selected: c.total == d,
                        onSelected: (_) => c.setDuration(d),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => c.add(const Duration(seconds: -10)),
                       style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.containerColor,)),
                      child: const Text('-10s', style: TextStyle(color: AppColors.primaryColor),),
                    ),
                    IconButton(
                      tooltip: context.i18n.reinitialize,
                      onPressed: c.reset,
                      icon: const Icon(Icons.refresh, color: AppColors.primaryColor,),
                    ),
                    FilledButton.icon(
                      onPressed: c.running ? c.pause : c.start,
                      icon: Icon(c.running ? Icons.pause : Icons.play_arrow),
                      label: Text(label),
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor)),
                    ),
                    OutlinedButton(
                      onPressed: () => c.add(const Duration(seconds: 10)),
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.containerColor,)),
                      child: const Text('+10s', style: TextStyle(color: AppColors.primaryColor)),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
 