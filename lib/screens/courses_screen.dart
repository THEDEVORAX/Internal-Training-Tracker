import 'package:flutter/material.dart';
import '../widgets/course_card.dart';
import '../theme/app_theme.dart';

/// [CoursesScreen] provides the course catalog where users can explore
/// available learning opportunities. Features search and category filtering.
class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final List<String> _categories = [
    'All',
    'Design',
    'Code',
    'Business',
    'Cloud'
  ];
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _mockCourses = [
    {
      'title': 'Flutter App Development Fundamentals',
      'instructor': 'Sarah Johnson',
      'rating': 4.8,
      'enrollments': 2540,
    },
    {
      'title': 'Advanced Data Science with Python',
      'instructor': 'Dr. Ahmed Hassan',
      'rating': 4.6,
      'enrollments': 1850,
    },
    {
      'title': 'Cloud Computing Essentials',
      'instructor': 'Michael Chen',
      'rating': 4.7,
      'enrollments': 3200,
    },
    {
      'title': 'Product Management Masterclass',
      'instructor': 'Emma Williams',
      'rating': 4.9,
      'enrollments': 1200,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Courses'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.filter_list_rounded)),
        ],
      ),
      body: Column(
        children: [
          // Search Bar Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for courses, tools...',
                prefixIcon: const Icon(Icons.search_rounded,
                    color: AppTheme.primaryColor),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
                ),
              ),
            ),
          ),

          // Category Selector
          SizedBox(
            height: 60,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FilterChip(
                    label: Text(_categories[index]),
                    selected: isSelected,
                    onSelected: (val) =>
                        setState(() => _selectedCategoryIndex = index),
                    backgroundColor: Colors.white,
                    selectedColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                    checkmarkColor: AppTheme.primaryColor,
                    labelStyle: TextStyle(
                      color:
                          isSelected ? AppTheme.primaryColor : Colors.grey[700],
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : Colors.grey.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Course Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _mockCourses.length,
              itemBuilder: (context, index) {
                final course = _mockCourses[index];
                return CourseCard(
                  courseTitle: course['title'],
                  instructor: course['instructor'],
                  rating: course['rating'],
                  enrollmentCount: course['enrollments'],
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
