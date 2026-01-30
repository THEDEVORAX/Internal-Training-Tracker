import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

/// A metric display tile with icon, value, label, and optional trend indicator
class MetricTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? iconColor;
  final Color? valueColor;
  final TrendDirection? trend;
  final String? trendValue;
  final bool animate;

  const MetricTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor,
    this.valueColor,
    this.trend,
    this.trendValue,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final isDark = context.isDarkMode;

    final defaultIconColor = iconColor ?? AppColors.accentBlue;
    final defaultValueColor =
        valueColor ?? (isDark ? AppColors.darkText : AppColors.lightText);
    final labelColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: defaultIconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: defaultIconColor, size: 22),
            ),
            if (trend != null) ...[
              const Spacer(),
              _TrendBadge(direction: trend!, value: trendValue),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Text(
          value,
          style: textTheme.headlineMedium?.copyWith(
            color: defaultValueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: labelColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    if (animate) {
      content = content
          .animate()
          .fadeIn(duration: 400.ms, curve: Curves.easeOut)
          .slideY(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOut);
    }

    return content;
  }
}

/// Trend direction indicator
enum TrendDirection { up, down, neutral }

/// Badge showing trend direction and optional value
class _TrendBadge extends StatelessWidget {
  final TrendDirection direction;
  final String? value;

  const _TrendBadge({required this.direction, this.value});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (direction) {
      TrendDirection.up => (Icons.trending_up_rounded, AppColors.success),
      TrendDirection.down => (Icons.trending_down_rounded, AppColors.error),
      TrendDirection.neutral => (
        Icons.trending_flat_rounded,
        AppColors.warning,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          if (value != null) ...[
            const SizedBox(width: 4),
            Text(
              value!,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Compact version of MetricTile for smaller spaces
class CompactMetricTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? color;

  const CompactMetricTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final isDark = context.isDarkMode;
    final effectiveColor = color ?? AppColors.accentBlue;
    final labelColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: effectiveColor, size: 18),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(color: labelColor),
            ),
          ],
        ),
      ],
    );
  }
}
