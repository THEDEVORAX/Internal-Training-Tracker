/// Extension methods for common operations
import 'package:intl/intl.dart';

extension StringExtension on String {
  /// Capitalize first letter of string
  String capitalize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  /// Check if string is a valid email
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid phone number (basic)
  bool isValidPhone() {
    return isNotEmpty &&
        length >= 10 &&
        RegExp(r'^[0-9+\-\s()]+$').hasMatch(this);
  }

  /// Truncate string with ellipsis
  String truncate(int length, {String ellipsis = '...'}) {
    if (this.length <= length) return this;
    return '${substring(0, length - ellipsis.length)}$ellipsis';
  }

  /// Convert to slug format
  String toSlug() => toLowerCase()
      .trim()
      .replaceAll(RegExp(r'\s+'), '-')
      .replaceAll(RegExp(r'[^\w-]+'), '');
}

extension DateTimeExtension on DateTime {
  /// Format date to readable string
  String toReadableString() => DateFormat('MMM dd, yyyy').format(this);

  /// Format date and time to readable string
  String toReadableDateTimeString() =>
      DateFormat('MMM dd, yyyy - hh:mm a').format(this);

  /// Check if date is today
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Get relative time string (e.g., "2 days ago")
  String toRelativeString() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 60) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    if (difference.inDays < 30)
      return '${(difference.inDays / 7).round()}w ago';
    if (difference.inDays < 365)
      return '${(difference.inDays / 30).round()}mo ago';

    return '${(difference.inDays / 365).round()}y ago';
  }

  /// Check if date is in the past
  bool isPast() => isBefore(DateTime.now());

  /// Check if date is in the future
  bool isFuture() => isAfter(DateTime.now());

  /// Get formatted time (e.g., "02:30 PM")
  String toTimeString() => DateFormat('hh:mm a').format(this);
}

extension DurationExtension on Duration {
  /// Format duration to readable string
  String toReadableString() {
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);
    final hours = inHours;

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Format duration as hours and minutes (e.g., "2h 30m")
  String toShortString() {
    if (inHours > 0) {
      final minutes = inMinutes.remainder(60);
      return '${inHours}h ${minutes}m';
    }
    return '${inMinutes}m';
  }
}

extension DoubleExtension on double {
  /// Format percentage to string with 1 decimal
  String toPercentageString({int decimals = 1}) =>
      toStringAsFixed(decimals) + '%';

  /// Clamp value between min and max
  double clampBetween(double min, double max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Check if double is between two values
  bool isBetween(double min, double max) => this >= min && this <= max;
}

extension IntExtension on int {
  /// Convert seconds to readable duration string
  String secondsToDurationString() {
    final duration = Duration(seconds: this);
    return duration.toReadableString();
  }

  /// Format large numbers with commas
  String toFormattedString() {
    return toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)},',
    );
  }

  /// Check if number is even
  bool get isEven => this % 2 == 0;

  /// Check if number is odd
  bool get isOdd => this % 2 != 0;
}

extension ListExtension<T> on List<T> {
  /// Get first element or null without throwing
  T? getFirstOrNull() => isNotEmpty ? first : null;

  /// Get last element or null without throwing
  T? getLastOrNull() => isNotEmpty ? last : null;

  /// Duplicate the list
  List<T> duplicated() => [...this];

  /// Shuffle list without modifying original
  List<T> shuffled() {
    final list = [...this];
    list.shuffle();
    return list;
  }
}

extension MapExtension<K, V> on Map<K, V> {
  /// Get value or default without throwing
  V? getValueOrNull(K key) => containsKey(key) ? this[key] : null;

  /// Merge two maps
  Map<K, V> merge(Map<K, V> other) => {...this, ...other};
}
