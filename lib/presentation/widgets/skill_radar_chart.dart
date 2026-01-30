import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/services/training_analytics_service.dart';

/// Interactive Radar (Spider Web) Chart for skill visualization
class SkillRadarChart extends StatefulWidget {
  final List<SkillRadarData> data;
  final int? selectedIndex;
  final ValueChanged<int?>? onDataPointTapped;
  final double size;

  const SkillRadarChart({
    super.key,
    required this.data,
    this.selectedIndex,
    this.onDataPointTapped,
    this.size = 280,
  });

  @override
  State<SkillRadarChart> createState() => _SkillRadarChartState();
}

class _SkillRadarChartState extends State<SkillRadarChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  int? _touchedIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(SkillRadarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: RadarChart(
            RadarChartData(
              radarShape: RadarShape.polygon,
              radarBorderData: BorderSide(
                color: isDark
                    ? AppColors.darkBorder.withOpacity(0.5)
                    : AppColors.lightBorder,
                width: 1,
              ),
              gridBorderData: BorderSide(
                color: isDark
                    ? AppColors.darkBorder.withOpacity(0.3)
                    : AppColors.lightBorder.withOpacity(0.5),
                width: 1,
              ),
              tickCount: 4,
              ticksTextStyle: TextStyle(
                color: Colors.transparent,
                fontSize: 10,
              ),
              tickBorderData: BorderSide(
                color: isDark
                    ? AppColors.darkBorder.withOpacity(0.2)
                    : AppColors.lightBorder.withOpacity(0.3),
                width: 1,
              ),
              getTitle: (index, angle) {
                if (index >= widget.data.length)
                  return RadarChartTitle(text: '');
                final skill = widget.data[index];
                final isSelected =
                    widget.selectedIndex == index || _touchedIndex == index;

                return RadarChartTitle(
                  text:
                      '${skill.category.emoji}\n${skill.category.displayName}',
                  angle: angle,
                  positionPercentageOffset: 0.15,
                );
              },
              titleTextStyle: TextStyle(
                color: isDark ? AppColors.darkText : AppColors.lightText,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
              titlePositionPercentageOffset: 0.2,
              dataSets: [_buildDataSet(isDark)],
              radarTouchData: RadarTouchData(
                enabled: true,
                touchCallback: (event, response) {
                  if (event is FlTapUpEvent || event is FlLongPressEnd) {
                    final touchedSpot = response?.touchedSpot;
                    if (touchedSpot != null) {
                      setState(() {
                        _touchedIndex = touchedSpot.touchedDataSetIndex == 0
                            ? touchedSpot.touchedRadarEntryIndex
                            : null;
                      });
                      widget.onDataPointTapped?.call(_touchedIndex);
                    }
                  }
                },
              ),
            ),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
          ),
        );
      },
    );
  }

  RadarDataSet _buildDataSet(bool isDark) {
    final animatedData = widget.data.map((skill) {
      return RadarEntry(value: skill.score * _animation.value);
    }).toList();

    return RadarDataSet(
      fillColor: AppColors.primaryGradientStart.withOpacity(0.2),
      borderColor: AppColors.primaryGradientStart,
      borderWidth: 2.5,
      entryRadius: 4,
      dataEntries: animatedData,
    );
  }
}

/// Legend item for radar chart
class RadarChartLegend extends StatelessWidget {
  final List<SkillRadarData> data;
  final int? selectedIndex;
  final ValueChanged<int?>? onItemTapped;

  const RadarChartLegend({
    super.key,
    required this.data,
    this.selectedIndex,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final textTheme = context.textTheme;

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: data.asMap().entries.map((entry) {
        final index = entry.key;
        final skill = entry.value;
        final isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () => onItemTapped?.call(isSelected ? null : index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryGradientStart.withOpacity(0.15)
                  : (isDark ? AppColors.darkSurface : AppColors.lightSurface)
                        .withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryGradientStart
                    : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(skill.category.emoji),
                const SizedBox(width: 6),
                Text(
                  skill.category.displayName,
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getScoreColor(skill.score).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${skill.score.toStringAsFixed(0)}%',
                    style: textTheme.labelSmall?.copyWith(
                      color: _getScoreColor(skill.score),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.warning;
    return AppColors.error;
  }
}
