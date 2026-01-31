import 'package:flutter/material.dart';
import '../widgets/course_card.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Courses'), elevation: 0),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _mockCourses.length,
              itemBuilder: (context, index) {
                final course = _mockCourses[index];
                return CourseCard(
                  courseTitle: course['title'],
                  instructor: course['instructor'],
                  rating: course['rating'],
                  enrollmentCount: course['enrollments'],
                  onTap: () {
                    // Navigate to course details
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
