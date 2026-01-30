import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// An animated progress bar with smooth transitions
class AnimatedProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final Color? backgroundColor;
  final Gradient? progressGradient;
  final Color? progressColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final bool showPercentage;
  final BorderRadius? borderRadius;

  const AnimatedProgressBar({
    super.key,
    required this.progress,
    this.height = 8,
    this.backgroundColor,
    this.progressGradient,
    this.progressColor,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeOutCubic,
    this.showPercentage = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor =
        backgroundColor ??
        (isDark ? AppColors.darkBorder : AppColors.lightBorder);

    final defaultGradient = LinearGradient(
      colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
    );

    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(height / 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showPercentage) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: context.textTheme.bodySmall?.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: animationDuration,
                curve: animationCurve,
                builder: (context, value, child) {
                  return Text(
                    '${(value * 100).toInt()}%',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: effectiveBorderRadius,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress.clamp(0.0, 1.0)),
                    duration: animationDuration,
                    curve: animationCurve,
                    builder: (context, value, child) {
                      return Container(
                        width: constraints.maxWidth * value,
                        decoration: BoxDecoration(
                          gradient: progressColor != null
                              ? null
                              : (progressGradient ?? defaultGradient),
                          color: progressColor,
                          borderRadius: effectiveBorderRadius,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  (progressColor ??
                                          AppColors.primaryGradientStart)
                                      .withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Circular progress indicator with animation
class AnimatedCircularProgress extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? backgroundColor;
  final Gradient? progressGradient;
  final Color? progressColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final Widget? child;

  const AnimatedCircularProgress({
    super.key,
    required this.progress,
    this.size = 80,
    this.strokeWidth = 8,
    this.backgroundColor,
    this.progressGradient,
    this.progressColor,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.animationCurve = Curves.easeOutCubic,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final bgColor =
        backgroundColor ??
        (isDark ? AppColors.darkBorder : AppColors.lightBorder);

    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: progress.clamp(0.0, 1.0)),
        duration: animationDuration,
        curve: animationCurve,
        builder: (context, value, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: Size(size, size),
                painter: _CircularProgressPainter(
                  progress: value,
                  strokeWidth: strokeWidth,
                  backgroundColor: bgColor,
                  progressColor:
                      progressColor ?? AppColors.primaryGradientStart,
                  progressGradient: progressGradient,
                ),
              ),
              if (child != null) child!,
            ],
          );
        },
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final Gradient? progressGradient;

  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
    this.progressGradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (progressGradient != null) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      progressPaint.shader = progressGradient!.createShader(rect);
    } else {
      progressPaint.color = progressColor;
    }

    const startAngle = -90 * (3.14159 / 180); // Start from top
    final sweepAngle = progress * 2 * 3.14159;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor;
  }
}
