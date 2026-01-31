import 'package:flutter/material.dart';

/// A premium [StatCard] used to display key performance indicators (KPIs).
/// It features a modern, clean look with a semantic icon and bold typography.
class StatCard extends StatelessWidget {
  /// Optimized constructor following Dart best practices.
  const StatCard({
    required this.title,
    required this.value,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    super.key,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use the provided background color or fall back to the theme's primary
    final primaryColor = backgroundColor ?? theme.primaryColor;

    return Card(
      // The card styling is now centralized in AppTheme.cardTheme
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon Container with soft background tint
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: iconColor ?? primaryColor,
                size: 28,
              ),
            ),

            // Value and Title section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color
                        ?.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
