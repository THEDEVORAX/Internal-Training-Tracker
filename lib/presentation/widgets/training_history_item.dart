import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/entities.dart';
import 'animated_progress_bar.dart';
import 'glass_card.dart';

/// Training history list item with Hero animation support
class TrainingHistoryItem extends StatelessWidget {
  final Course course;
  final int index;
  final VoidCallback? onTap;

  const TrainingHistoryItem({
    super.key,
    required this.course,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textTheme = context.textTheme;

    return GlassCard(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course image with Hero
              Hero(
                tag: 'course_image_${course.id}',
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _getCategoryColors(course.category),
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _getCategoryColors(
                          course.category,
                        ).first.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      course.category.emoji,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Course info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            course.title,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _StatusBadge(
                          isCompleted: course.isCompleted,
                          isInProgress: course.isInProgress,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.instructor,
                      style: textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.menu_book_rounded,
                          label: '${course.modules.length} modules',
                        ),
                        const SizedBox(width: 12),
                        _InfoChip(
                          icon: Icons.schedule_rounded,
                          label: _formatDuration(course.totalDuration),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AnimatedProgressBar(
                      progress: course.progress,
                      height: 6,
                      animationDuration: Duration(
                        milliseconds: 600 + (index * 100),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(course.progress * 100).toInt()}% complete',
                          style: textTheme.labelSmall?.copyWith(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        if (course.isCompleted && course.averageScore > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getScoreColor(
                                course.averageScore,
                              ).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Score: ${course.averageScore.toStringAsFixed(0)}%',
                              style: textTheme.labelSmall?.copyWith(
                                color: _getScoreColor(course.averageScore),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: index * 80),
          duration: 400.ms,
        )
        .slideX(
          begin: 0.1,
          end: 0,
          delay: Duration(milliseconds: index * 80),
          duration: 400.ms,
          curve: Curves.easeOut,
        );
  }

  List<Color> _getCategoryColors(CourseCategory category) {
    return switch (category) {
      CourseCategory.technical => [
        const Color(0xFF3B82F6),
        const Color(0xFF1D4ED8),
      ],
      CourseCategory.leadership => [
        const Color(0xFFA855F7),
        const Color(0xFF7C3AED),
      ],
      CourseCategory.softSkills => [
        const Color(0xFFEC4899),
        const Color(0xFFDB2777),
      ],
      CourseCategory.compliance => [
        const Color(0xFF14B8A6),
        const Color(0xFF0D9488),
      ],
      CourseCategory.productKnowledge => [
        const Color(0xFFF97316),
        const Color(0xFFEA580C),
      ],
      CourseCategory.safety => [
        const Color(0xFFEF4444),
        const Color(0xFFDC2626),
      ],
      CourseCategory.customerService => [
        const Color(0xFF22C55E),
        const Color(0xFF16A34A),
      ],
    };
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.warning;
    return AppColors.error;
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) {
      return '$hours h ${minutes > 0 ? '$minutes m' : ''}';
    }
    return '$minutes min';
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isCompleted;
  final bool isInProgress;

  const _StatusBadge({required this.isCompleted, required this.isInProgress});

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = isCompleted
        ? ('Completed', AppColors.success, Icons.check_circle_rounded)
        : isInProgress
        ? ('In Progress', AppColors.warning, Icons.pending_rounded)
        : ('Not Started', AppColors.lightTextSecondary, Icons.circle_outlined);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final color = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }
}
