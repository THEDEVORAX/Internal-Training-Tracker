import 'dart:math';
import 'package:uuid/uuid.dart';
import '../../domain/entities/entities.dart';

/// Factory for generating realistic dummy data for testing and development
class DummyDataFactory {
  static final _uuid = Uuid();
  static final _random = Random(42); // Seeded for reproducibility

  static final _firstNames = [
    'Sarah',
    'Michael',
    'Emily',
    'David',
    'Jessica',
    'James',
    'Ashley',
    'Robert',
    'Amanda',
    'William',
    'Olivia',
    'Daniel',
    'Sophia',
    'Matthew',
    'Emma',
    'Christopher',
    'Ava',
    'Andrew',
    'Isabella',
    'Joshua',
  ];

  static final _lastNames = [
    'Johnson',
    'Williams',
    'Brown',
    'Jones',
    'Garcia',
    'Miller',
    'Davis',
    'Rodriguez',
    'Martinez',
    'Hernandez',
    'Lopez',
    'Gonzalez',
    'Wilson',
    'Anderson',
    'Thomas',
    'Taylor',
    'Moore',
    'Jackson',
    'Martin',
    'Lee',
  ];

  static final _departments = [
    'Engineering',
    'Product',
    'Design',
    'Marketing',
    'Sales',
    'Human Resources',
    'Finance',
    'Operations',
    'Customer Success',
  ];

  static final _courseTemplates = <(String, CourseCategory, List<String>)>[
    (
      'Flutter Advanced Development',
      CourseCategory.technical,
      [
        'Widget Lifecycle',
        'State Management',
        'Performance Optimization',
        'Testing Strategies',
      ],
    ),
    (
      'Leadership Fundamentals',
      CourseCategory.leadership,
      [
        'Team Dynamics',
        'Communication Skills',
        'Decision Making',
        'Conflict Resolution',
      ],
    ),
    (
      'Effective Communication',
      CourseCategory.softSkills,
      [
        'Active Listening',
        'Presentation Skills',
        'Written Communication',
        'Feedback Techniques',
      ],
    ),
    (
      'Data Privacy Compliance',
      CourseCategory.compliance,
      [
        'GDPR Basics',
        'Data Handling',
        'Privacy by Design',
        'Incident Response',
      ],
    ),
    (
      'Product Overview 2024',
      CourseCategory.productKnowledge,
      ['Core Features', 'Integration APIs', 'Roadmap', 'Competitive Analysis'],
    ),
    (
      'Workplace Safety',
      CourseCategory.safety,
      [
        'Emergency Procedures',
        'Ergonomics',
        'Hazard Identification',
        'First Aid Basics',
      ],
    ),
    (
      'Customer Excellence',
      CourseCategory.customerService,
      [
        'Empathy Mapping',
        'Problem Resolution',
        'Service Recovery',
        'Customer Journey',
      ],
    ),
    (
      'Cloud Architecture',
      CourseCategory.technical,
      ['AWS Fundamentals', 'Microservices', 'Kubernetes', 'CI/CD Pipelines'],
    ),
    (
      'Agile Leadership',
      CourseCategory.leadership,
      ['Scrum Mastery', 'Kanban Flow', 'Sprint Planning', 'Retrospectives'],
    ),
    (
      'Negotiation Skills',
      CourseCategory.softSkills,
      [
        'Win-Win Strategies',
        'BATNA Analysis',
        'Persuasion Techniques',
        'Closing Deals',
      ],
    ),
  ];

  static final _instructors = [
    'Dr. Alice Chen',
    'Prof. Marcus Webb',
    'Jennifer Lopez, MBA',
    'Tech Lead Ryan Kim',
    'Sarah Mitchell, PMP',
    'David Park, CISM',
  ];

  /// Generate a random assessment
  static Assessment generateAssessment({
    required DateTime baseDate,
    double? targetScore,
  }) {
    final types = AssessmentType.values;
    final type = types[_random.nextInt(types.length)];
    final score = targetScore ?? (60 + _random.nextDouble() * 40);

    return Assessment(
      id: _uuid.v4(),
      title: '${type.displayName} Assessment',
      score: score,
      maxScore: 100,
      completionDate: baseDate.add(Duration(days: _random.nextInt(7))),
      type: type,
    );
  }

  /// Generate a random module
  static Module generateModule({
    required String title,
    required DifficultyLevel difficulty,
    required DateTime baseDate,
    required ModuleStatus status,
  }) {
    final assessments = status == ModuleStatus.completed
        ? List.generate(
            2 + _random.nextInt(2),
            (i) => generateAssessment(
              baseDate: baseDate.add(Duration(days: i * 3)),
              targetScore: 65 + _random.nextDouble() * 35,
            ),
          )
        : <Assessment>[];

    return Module(
      id: _uuid.v4(),
      title: title,
      description:
          'Comprehensive training module covering $title concepts and practices.',
      difficultyLevel: difficulty,
      duration: Duration(hours: 2 + _random.nextInt(6)),
      assessments: assessments,
      status: status,
    );
  }

  /// Generate a random course
  static Course generateCourse({
    required String title,
    required CourseCategory category,
    required List<String> moduleTitles,
    required DateTime startDate,
    required double completionProgress,
  }) {
    final difficulties = DifficultyLevel.values;
    final completedModules = (moduleTitles.length * completionProgress).round();

    final modules = moduleTitles.asMap().entries.map((entry) {
      final index = entry.key;
      final moduleTitle = entry.value;

      ModuleStatus status;
      if (index < completedModules) {
        status = ModuleStatus.completed;
      } else if (index == completedModules && completionProgress > 0) {
        status = ModuleStatus.inProgress;
      } else {
        status = ModuleStatus.notStarted;
      }

      return generateModule(
        title: moduleTitle,
        difficulty: difficulties[index % difficulties.length],
        baseDate: startDate.add(Duration(days: index * 7)),
        status: status,
      );
    }).toList();

    final isCompleted = completionProgress >= 1.0;

    return Course(
      id: _uuid.v4(),
      title: title,
      description:
          'Master $title with hands-on exercises and real-world scenarios.',
      category: category,
      imageUrl: 'assets/images/course_${category.name}.png',
      modules: modules,
      startDate: startDate,
      completionDate: isCompleted
          ? startDate.add(
              Duration(days: moduleTitles.length * 7 + _random.nextInt(14)),
            )
          : null,
      instructor: _instructors[_random.nextInt(_instructors.length)],
    );
  }

  /// Generate a random employee with realistic training data
  static Employee generateEmployee({int? courseCount}) {
    final firstName = _firstNames[_random.nextInt(_firstNames.length)];
    final lastName = _lastNames[_random.nextInt(_lastNames.length)];
    final name = '$firstName $lastName';
    final email =
        '${firstName.toLowerCase()}.${lastName.toLowerCase()}@company.com';
    final department = _departments[_random.nextInt(_departments.length)];
    final roles = EmployeeRole.values;
    final role = roles[_random.nextInt(roles.length)];

    final hireDate = DateTime.now().subtract(
      Duration(days: 365 + _random.nextInt(1095)), // 1-4 years ago
    );

    final numCourses = courseCount ?? (3 + _random.nextInt(5));
    final selectedTemplates = <(String, CourseCategory, List<String>)>[];
    final templatesCopy = List.of(_courseTemplates)..shuffle(_random);

    for (var i = 0; i < numCourses && i < templatesCopy.length; i++) {
      selectedTemplates.add(templatesCopy[i]);
    }

    final courses = selectedTemplates.asMap().entries.map((entry) {
      final index = entry.key;
      final (title, category, modules) = entry.value;

      // Earlier courses have higher completion rates
      final completionProgress = index < numCourses - 2
          ? 0.75 +
                _random.nextDouble() *
                    0.25 // 75-100%
          : _random.nextDouble() * 0.6; // 0-60%

      return generateCourse(
        title: title,
        category: category,
        moduleTitles: modules,
        startDate: hireDate.add(Duration(days: 30 + index * 45)),
        completionProgress: completionProgress,
      );
    }).toList();

    final skills = <String>[];
    for (final course in courses.where((c) => c.isCompleted)) {
      skills.add(course.title.split(' ').first);
    }

    return Employee(
      id: _uuid.v4(),
      name: name,
      email: email,
      role: role,
      department: department,
      avatarUrl: 'https://i.pravatar.cc/150?u=$email',
      hireDate: hireDate,
      courses: courses,
      skills: skills,
    );
  }

  /// Generate a sample employee for demo purposes
  static Employee generateSampleEmployee() {
    final hireDate = DateTime(2022, 3, 15);

    final courses = [
      generateCourse(
        title: 'Flutter Advanced Development',
        category: CourseCategory.technical,
        moduleTitles: [
          'Widget Lifecycle',
          'State Management',
          'Performance Optimization',
          'Testing Strategies',
        ],
        startDate: DateTime(2022, 4, 1),
        completionProgress: 1.0,
      ),
      generateCourse(
        title: 'Leadership Fundamentals',
        category: CourseCategory.leadership,
        moduleTitles: [
          'Team Dynamics',
          'Communication Skills',
          'Decision Making',
          'Conflict Resolution',
        ],
        startDate: DateTime(2022, 6, 15),
        completionProgress: 1.0,
      ),
      generateCourse(
        title: 'Cloud Architecture',
        category: CourseCategory.technical,
        moduleTitles: [
          'AWS Fundamentals',
          'Microservices',
          'Kubernetes',
          'CI/CD Pipelines',
        ],
        startDate: DateTime(2022, 9, 1),
        completionProgress: 0.75,
      ),
      generateCourse(
        title: 'Data Privacy Compliance',
        category: CourseCategory.compliance,
        moduleTitles: [
          'GDPR Basics',
          'Data Handling',
          'Privacy by Design',
          'Incident Response',
        ],
        startDate: DateTime(2023, 1, 10),
        completionProgress: 1.0,
      ),
      generateCourse(
        title: 'Effective Communication',
        category: CourseCategory.softSkills,
        moduleTitles: [
          'Active Listening',
          'Presentation Skills',
          'Written Communication',
          'Feedback Techniques',
        ],
        startDate: DateTime(2023, 4, 1),
        completionProgress: 0.5,
      ),
      generateCourse(
        title: 'Customer Excellence',
        category: CourseCategory.customerService,
        moduleTitles: [
          'Empathy Mapping',
          'Problem Resolution',
          'Service Recovery',
          'Customer Journey',
        ],
        startDate: DateTime(2023, 7, 15),
        completionProgress: 0.25,
      ),
    ];

    return Employee(
      id: 'emp-001',
      name: 'Sarah Chen',
      email: 'sarah.chen@company.com',
      role: EmployeeRole.senior,
      department: 'Engineering',
      avatarUrl: 'https://i.pravatar.cc/150?u=sarah.chen@company.com',
      hireDate: hireDate,
      courses: courses,
      skills: ['Flutter', 'Leadership', 'Compliance'],
    );
  }

  /// Generate multiple employees
  static List<Employee> generateEmployees(int count) {
    return List.generate(count, (_) => generateEmployee());
  }
}
