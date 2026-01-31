import 'package:flutter/material.dart';

/// [ProgressBar] is a reusable widget for displaying progress with optional labels.
class ProgressBar extends StatelessWidget {
  /// Progress value between 0.0 and 1.0.
  final double progress;

  final String? label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;

  /// Standard constructor using [super.key].
  const ProgressBar({
    required this.progress,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.height = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
    final fg = foregroundColor ?? theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: fg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            minHeight: height,
            value: progress.clamp(0.0, 1.0),
            backgroundColor: bg,
            valueColor: AlwaysStoppedAnimation<Color>(fg),
          ),
        ),
      ],
    );
  }
}
