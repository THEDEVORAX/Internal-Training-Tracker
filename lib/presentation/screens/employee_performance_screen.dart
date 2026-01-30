import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/services/training_analytics_service.dart';
import '../bloc/employee_performance/employee_performance.dart';
import '../widgets/animated_gradient_background.dart';
import '../widgets/animated_progress_bar.dart';
import '../widgets/employee_avatar.dart';
import '../widgets/glass_card.dart';
import '../widgets/metric_tile.dart';
import '../widgets/skill_radar_chart.dart';
import '../widgets/training_history_item.dart';

/// Employee Performance Analytics Screen
///
/// A comprehensive dashboard showing employee training progress,
/// skill assessments, and performance analytics.
class EmployeePerformanceScreen extends StatelessWidget {
  const EmployeePerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EmployeePerformanceBloc()..add(const LoadEmployeePerformance()),
      child: const _EmployeePerformanceView(),
    );
  }
}

class _EmployeePerformanceView extends StatelessWidget {
  const _EmployeePerformanceView();

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: SafeArea(
        child: BlocBuilder<EmployeePerformanceBloc, EmployeePerformanceState>(
          builder: (context, state) {
            return switch (state) {
              EmployeePerformanceLoading() => const _LoadingView(),
              EmployeePerformanceSuccess() => _SuccessView(state: state),
              EmployeePerformanceEmpty() => const _EmptyView(),
              EmployeePerformanceError() => _ErrorView(state: state),
            };
          },
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading performance data...'),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person_search_rounded,
            size: 64,
            color: AppColors.lightTextSecondary,
          ),
          const SizedBox(height: 16),
          Text('No employee data found', style: context.textTheme.titleLarge),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final EmployeePerformanceError state;

  const _ErrorView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              state.message,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                context.read<EmployeePerformanceBloc>().add(
                  const RefreshEmployeePerformance(),
                );
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final EmployeePerformanceSuccess state;

  const _SuccessView({required this.state});

  @override
  Widget build(BuildContext context) {
    final employee = state.employee;
    final analytics = state.analytics;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        final isTablet = constraints.maxWidth > 600;

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Collapsible Header with Profile
            SliverPersistentHeader(
              pinned: true,
              delegate: _ProfileHeaderDelegate(
                employee: employee,
                analytics: analytics,
                expandedHeight: isWide ? 280 : 250,
                collapsedHeight: 120,
              ),
            ),

            // Performance Metrics Grid
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 32 : 16,
                  vertical: 16,
                ),
                child: _MetricsSection(analytics: analytics, isWide: isWide),
              ),
            ),

            // Analytics Section with Radar Chart
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isWide ? 32 : 16),
                child: _AnalyticsSection(
                  analytics: analytics,
                  selectedIndex: state.selectedSkillIndex,
                  isWide: isWide,
                ),
              ),
            ),

            // Training History Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  isWide ? 32 : 16,
                  24,
                  isWide ? 32 : 16,
                  12,
                ),
                child:
                    Row(
                          children: [
                            Text(
                              'Training History',
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGradientStart
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${employee.courses.length} courses',
                                style: context.textTheme.labelSmall?.copyWith(
                                  color: AppColors.primaryGradientStart,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(delay: 400.ms)
                        .slideX(begin: -0.05, end: 0, duration: 400.ms),
              ),
            ),

            // Training History List
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                isWide ? 32 : 16,
                0,
                isWide ? 32 : 16,
                32,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final course = employee.courses[index];
                  return TrainingHistoryItem(
                    course: course,
                    index: index,
                    onTap: () {
                      // TODO: Navigate to course detail
                    },
                  );
                }, childCount: employee.courses.length),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Custom SliverPersistentHeaderDelegate for profile header
class _ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  final dynamic employee;
  final EmployeeAnalytics analytics;
  final double expandedHeight;
  final double collapsedHeight;

  _ProfileHeaderDelegate({
    required this.employee,
    required this.analytics,
    required this.expandedHeight,
    required this.collapsedHeight,
  });

  @override
  double get minExtent => collapsedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  bool shouldRebuild(covariant _ProfileHeaderDelegate oldDelegate) {
    return employee != oldDelegate.employee ||
        analytics != oldDelegate.analytics;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final isDark = context.isDarkMode;
    final textTheme = context.textTheme;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      AppColors.darkBackground.withOpacity(0.9),
                      AppColors.darkBackground.withOpacity(0.7),
                    ]
                  : [
                      AppColors.lightBackground.withOpacity(0.9),
                      AppColors.lightBackground.withOpacity(0.7),
                    ],
            ),
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? AppColors.darkBorder.withOpacity(0.5)
                    : AppColors.lightBorder.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                // Expanded content
                Opacity(
                  opacity: 1 - progress,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      EmployeeProfileAvatar(
                        imageUrl: employee.avatarUrl,
                        name: employee.name,
                        role:
                            '${employee.role.displayName} • ${employee.department}',
                        avatarSize: 80 - (progress * 30),
                        heroTag: 'employee_avatar_${employee.id}',
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _HeaderInfoChip(
                            icon: Icons.calendar_today_rounded,
                            label:
                                'Joined ${DateFormat.yMMMM().format(employee.hireDate)}',
                          ),
                          const SizedBox(width: 16),
                          _HeaderInfoChip(
                            icon: Icons.school_rounded,
                            label:
                                '${employee.completedCoursesCount} completed',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Collapsed content
                Opacity(
                  opacity: progress,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      children: [
                        EmployeeAvatar(
                          imageUrl: employee.avatarUrl,
                          size: 48,
                          heroTag: 'employee_avatar_collapsed_${employee.id}',
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                employee.name,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${employee.role.displayName} • ${employee.department}',
                                style: textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedCircularProgress(
                          progress: analytics.weightedAveragePerformance / 100,
                          size: 44,
                          strokeWidth: 4,
                          child: Text(
                            '${analytics.weightedAveragePerformance.toStringAsFixed(0)}',
                            style: textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeaderInfoChip({required this.icon, required this.label});

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
        const SizedBox(width: 6),
        Text(label, style: context.textTheme.bodySmall?.copyWith(color: color)),
      ],
    );
  }
}

class _MetricsSection extends StatelessWidget {
  final EmployeeAnalytics analytics;
  final bool isWide;

  const _MetricsSection({required this.analytics, required this.isWide});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      (
        Icons.trending_up_rounded,
        '${analytics.weightedAveragePerformance.toStringAsFixed(1)}%',
        'Weighted Performance',
        AppColors.accentBlue,
        TrendDirection.up,
        '+5%',
      ),
      (
        Icons.speed_rounded,
        analytics.learningVelocity.toStringAsFixed(1),
        'Courses / Month',
        AppColors.accentPurple,
        TrendDirection.neutral,
        null,
      ),
      (
        Icons.quiz_rounded,
        '${analytics.totalAssessmentsCompleted}',
        'Assessments',
        AppColors.accentTeal,
        TrendDirection.up,
        '+12',
      ),
      (
        Icons.grade_rounded,
        '${analytics.averageAssessmentScore.toStringAsFixed(1)}%',
        'Avg Assessment Score',
        AppColors.accentOrange,
        analytics.averageAssessmentScore >= 80
            ? TrendDirection.up
            : TrendDirection.neutral,
        null,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isWide ? 4 : 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: isWide ? 1.3 : 1.4,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final (icon, value, label, color, trend, trendValue) = metrics[index];
        return GlassCard(
              padding: const EdgeInsets.all(16),
              child: MetricTile(
                icon: icon,
                value: value,
                label: label,
                iconColor: color,
                trend: trend,
                trendValue: trendValue,
              ),
            )
            .animate()
            .fadeIn(
              delay: Duration(milliseconds: 100 + (index * 80)),
              duration: 400.ms,
            )
            .slideY(
              begin: 0.1,
              end: 0,
              delay: Duration(milliseconds: 100 + (index * 80)),
              duration: 400.ms,
              curve: Curves.easeOut,
            );
      },
    );
  }
}

class _AnalyticsSection extends StatelessWidget {
  final EmployeeAnalytics analytics;
  final int? selectedIndex;
  final bool isWide;

  const _AnalyticsSection({
    required this.analytics,
    required this.selectedIndex,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return GlassCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.analytics_rounded,
                    color: AppColors.primaryGradientStart,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Skill Assessment',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Performance across different training categories',
                style: textTheme.bodyMedium?.copyWith(
                  color: context.isDarkMode
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 24),
              if (isWide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Center(
                        child: SkillRadarChart(
                          data: analytics.skillRadarData,
                          selectedIndex: selectedIndex,
                          onDataPointTapped: (index) {
                            context.read<EmployeePerformanceBloc>().add(
                              SelectSkill(skillIndex: index),
                            );
                          },
                          size: 320,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          RadarChartLegend(
                            data: analytics.skillRadarData,
                            selectedIndex: selectedIndex,
                            onItemTapped: (index) {
                              context.read<EmployeePerformanceBloc>().add(
                                SelectSkill(skillIndex: index),
                              );
                            },
                          ),
                          if (selectedIndex != null) ...[
                            const SizedBox(height: 24),
                            _SelectedSkillDetail(
                              skill: analytics.skillRadarData[selectedIndex!],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Center(
                      child: SkillRadarChart(
                        data: analytics.skillRadarData,
                        selectedIndex: selectedIndex,
                        onDataPointTapped: (index) {
                          context.read<EmployeePerformanceBloc>().add(
                            SelectSkill(skillIndex: index),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    RadarChartLegend(
                      data: analytics.skillRadarData,
                      selectedIndex: selectedIndex,
                      onItemTapped: (index) {
                        context.read<EmployeePerformanceBloc>().add(
                          SelectSkill(skillIndex: index),
                        );
                      },
                    ),
                    if (selectedIndex != null) ...[
                      const SizedBox(height: 20),
                      _SelectedSkillDetail(
                        skill: analytics.skillRadarData[selectedIndex!],
                      ),
                    ],
                  ],
                ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 300.ms, duration: 500.ms)
        .slideY(begin: 0.05, end: 0, delay: 300.ms, duration: 500.ms);
  }
}

class _SelectedSkillDetail extends StatelessWidget {
  final SkillRadarData skill;

  const _SelectedSkillDetail({required this.skill});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final isDark = context.isDarkMode;

    return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryGradientStart.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryGradientStart.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    skill.category.emoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          skill.category.displayName,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${skill.coursesCompleted} of ${skill.totalCourses} courses completed',
                          style: textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryGradientStart,
                          AppColors.primaryGradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${skill.score.toStringAsFixed(0)}%',
                      style: textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AnimatedProgressBar(
                progress: skill.score / 100,
                height: 8,
                showPercentage: false,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 300.ms,
          curve: Curves.easeOut,
        );
  }
}
