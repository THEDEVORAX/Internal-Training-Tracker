import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

/// Animated gradient background with flowing color transitions
class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;
  final Duration animationDuration;
  final List<Color>? colors;

  const AnimatedGradientBackground({
    super.key,
    required this.child,
    this.animationDuration = const Duration(seconds: 8),
    this.colors,
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    final defaultColors = isDark
        ? [
            const Color(0xFF0F172A),
            const Color(0xFF1E1B4B),
            const Color(0xFF312E81),
            const Color(0xFF1E3A5F),
          ]
        : [
            const Color(0xFFF0F4FF),
            const Color(0xFFE8EEFF),
            const Color(0xFFF5F0FF),
            const Color(0xFFEFF6FF),
          ];

    final colors = widget.colors ?? defaultColors;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.lerp(
                Alignment.topLeft,
                Alignment.topRight,
                _controller.value,
              )!,
              end: Alignment.lerp(
                Alignment.bottomRight,
                Alignment.bottomLeft,
                _controller.value,
              )!,
              colors: colors,
              stops: [
                0.0,
                0.3 + (_controller.value * 0.2),
                0.6 + (_controller.value * 0.1),
                1.0,
              ],
            ),
          ),
          child: child,
        );
      },
      child: Stack(
        children: [
          // Floating orbs for visual interest
          ..._buildFloatingOrbs(isDark),
          widget.child,
        ],
      ),
    );
  }

  List<Widget> _buildFloatingOrbs(bool isDark) {
    final orbColors = isDark
        ? [
            AppColors.accentBlue.withOpacity(0.15),
            AppColors.accentPurple.withOpacity(0.12),
            AppColors.accentPink.withOpacity(0.10),
          ]
        : [
            AppColors.accentBlue.withOpacity(0.08),
            AppColors.accentPurple.withOpacity(0.06),
            AppColors.accentPink.withOpacity(0.05),
          ];

    return [
      Positioned(
        top: -100,
        right: -50,
        child: _FloatingOrb(
          size: 300,
          color: orbColors[0],
          duration: const Duration(seconds: 6),
        ),
      ),
      Positioned(
        bottom: 100,
        left: -100,
        child: _FloatingOrb(
          size: 250,
          color: orbColors[1],
          duration: const Duration(seconds: 8),
        ),
      ),
      Positioned(
        top: 200,
        left: 100,
        child: _FloatingOrb(
          size: 150,
          color: orbColors[2],
          duration: const Duration(seconds: 5),
        ),
      ),
    ];
  }
}

class _FloatingOrb extends StatelessWidget {
  final double size;
  final Color color;
  final Duration duration;

  const _FloatingOrb({
    required this.size,
    required this.color,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [color, color.withOpacity(0)]),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(begin: 0, end: 30, duration: duration, curve: Curves.easeInOut)
        .moveX(
          begin: 0,
          end: 20,
          duration: Duration(milliseconds: duration.inMilliseconds + 500),
          curve: Curves.easeInOut,
        );
  }
}
