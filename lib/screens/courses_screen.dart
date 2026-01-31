import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/course_card.dart';
import '../providers/course_provider.dart';
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

  @override
  void initState() {
    super.initState();
    // Load courses when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseProvider>().loadCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final courseProvider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Courses'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          // --- Search Bar Section ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              onChanged: (value) => courseProvider.searchCourses(value),
              decoration: InputDecoration(
                hintText: 'Search for courses, tools...',
                prefixIcon: const Icon(Icons.search_rounded,
                    color: AppTheme.primaryColor),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // --- Category Selector ---
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
                    onSelected: (val) {
                      setState(() => _selectedCategoryIndex = index);
                      if (_categories[index] == 'All') {
                        courseProvider.loadCourses();
                      } else {
                        courseProvider.filterByCategory(_categories[index]);
                      }
                    },
                    selectedColor:
                        theme.colorScheme.primary.withValues(alpha: 0.1),
                    checkmarkColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.textTheme.bodyMedium?.color
                              ?.withValues(alpha: 0.6),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // --- Course Grid ---
          Expanded(
            child: courseProvider.courseResult.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text('Error: $message')),
              success: (_) {
                final courses = courseProvider.filteredCourses;
                if (courses.isEmpty) {
                  return const Center(
                      child: Text('No courses found matching your criteria.'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return CourseCard(
                      course: courses[index],
                      onTap: () {
                        // Navigation to detail page can be added here
                      },
                    );
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
