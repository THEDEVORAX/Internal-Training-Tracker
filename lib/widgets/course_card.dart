import 'package:flutter/material.dart';

/// [CourseCard] represents a single course item in a grid or list.
/// Designed with a high-fidelity aesthetic, it includes a thumbnail placeholder,
/// course details, ratings, and enrollment stats.
class CourseCard extends StatelessWidget {
  final String courseTitle;
  final String instructor;
  final double rating;
  final int enrollmentCount;
  final String? thumbnail;
  final VoidCallback onTap;

  /// Standard constructor with the new super.key syntax.
  const CourseCard({
    super.key,
    required this.courseTitle,
    required this.instructor,
    required this.rating,
    required this.enrollmentCount,
    this.thumbnail,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        // Card properties are inherited from AppTheme.cardTheme
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Area - Uses a soft colored background if no image exists
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withValues(alpha: 0.15),
                      theme.colorScheme.primary.withValues(alpha: 0.05),
                    ],
                  ),
                ),
                child: thumbnail != null
                    ? Image.network(thumbnail!, fit: BoxFit.cover)
                    : Center(
                        child: Icon(
                          Icons.school_rounded,
                          size: 44,
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.4),
                        ),
                      ),
              ),
            ),

            // Content Area
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Course Title & Instructor
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: theme.colorScheme.primary
                                  .withValues(alpha: 0.1),
                              child: Icon(Icons.person,
                                  size: 10, color: theme.colorScheme.primary),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                instructor,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.textTheme.bodySmall?.color
                                      ?.withValues(alpha: 0.6),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Rating & Enrollment Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rating Badge
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              rating.toStringAsFixed(1),
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),

                        // Enrollment Count
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '$enrollmentCount Enrolled',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
