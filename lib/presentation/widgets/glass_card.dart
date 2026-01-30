import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// A glassmorphism-styled card widget with frosted glass effect
///
/// Uses [BackdropFilter] with [ImageFilter.blur] for the frosted glass effect.
/// Supports light/dark mode and customizable blur, gradient, and border radius.
class GlassCard extends StatelessWidget {
  final Widget child;
  final double blurX;
  final double blurY;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final bool enableHover;

  const GlassCard({
    super.key,
    required this.child,
    this.blurX = 10.0,
    this.blurY = 10.0,
    this.borderRadius = 24.0,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.gradient,
    this.onTap,
    this.enableHover = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    final defaultGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? [AppColors.glassDark, AppColors.glassDark.withOpacity(0.05)]
          : [AppColors.glassLight, AppColors.glassLight.withOpacity(0.2)],
    );

    final borderColor = isDark
        ? AppColors.glassBorderDark
        : AppColors.glassBorderLight;

    Widget card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurX, sigmaY: blurY),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: gradient ?? defaultGradient,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );

    if (enableHover && onTap != null) {
      card = _HoverGlassCard(
        onTap: onTap!,
        borderRadius: borderRadius,
        child: card,
      );
    } else if (onTap != null) {
      card = GestureDetector(onTap: onTap, child: card);
    }

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    return card;
  }
}

/// Hover effect wrapper for GlassCard
class _HoverGlassCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double borderRadius;

  const _HoverGlassCard({
    required this.child,
    required this.onTap,
    required this.borderRadius,
  });

  @override
  State<_HoverGlassCard> createState() => _HoverGlassCardState();
}

class _HoverGlassCardState extends State<_HoverGlassCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) =>
              Transform.scale(scale: _scaleAnimation.value, child: child),
          child: widget.child,
        ),
      ),
    );
  }
}
