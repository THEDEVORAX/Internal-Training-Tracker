import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Employee avatar widget with gradient border and optional status indicator
class EmployeeAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final Gradient? borderGradient;
  final double borderWidth;
  final bool showStatus;
  final EmployeeStatus status;
  final VoidCallback? onTap;
  final String? heroTag;

  const EmployeeAvatar({
    super.key,
    required this.imageUrl,
    this.size = 60,
    this.borderGradient,
    this.borderWidth = 3,
    this.showStatus = false,
    this.status = EmployeeStatus.online,
    this.onTap,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final defaultGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
    );

    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: borderGradient ?? defaultGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGradientStart.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: ClipOval(
          child: Container(
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? AppColors.darkSurface
                  : AppColors.lightSurface,
              shape: BoxShape.circle,
            ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: context.isDarkMode
                      ? AppColors.darkSurface
                      : AppColors.lightBorder,
                  child: Icon(
                    Icons.person_rounded,
                    size: size * 0.5,
                    color: context.isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    if (heroTag != null) {
      avatar = Hero(tag: heroTag!, child: avatar);
    }

    if (showStatus) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            right: 2,
            bottom: 2,
            child: _StatusIndicator(status: status, size: size * 0.22),
          ),
        ],
      );
    }

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }
}

/// Employee online status
enum EmployeeStatus { online, offline, away, busy }

/// Status indicator dot
class _StatusIndicator extends StatelessWidget {
  final EmployeeStatus status;
  final double size;

  const _StatusIndicator({required this.status, required this.size});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      EmployeeStatus.online => AppColors.success,
      EmployeeStatus.offline => AppColors.lightTextSecondary,
      EmployeeStatus.away => AppColors.warning,
      EmployeeStatus.busy => AppColors.error,
    };

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: context.isDarkMode
              ? AppColors.darkBackground
              : AppColors.lightBackground,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

/// Large employee avatar with name and role for profile headers
class EmployeeProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;
  final double avatarSize;
  final String? heroTag;

  const EmployeeProfileAvatar({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.role,
    this.avatarSize = 100,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final isDark = context.isDarkMode;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        EmployeeAvatar(
          imageUrl: imageUrl,
          size: avatarSize,
          heroTag: heroTag,
          borderWidth: 4,
        ),
        const SizedBox(height: 16),
        Text(
          name,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          role,
          style: textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
