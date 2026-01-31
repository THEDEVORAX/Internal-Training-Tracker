import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String? label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;

  const ProgressBar({
    Key? key,
    required this.progress,
    this.label,
    this.backgroundColor,
    this.foregroundColor,
    this.height = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? Colors.grey[300]!;
    final fg = foregroundColor ?? Colors.blue;

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
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
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
