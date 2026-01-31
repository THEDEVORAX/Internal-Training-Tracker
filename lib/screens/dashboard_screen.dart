import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../theme/app_theme.dart';

/// [DashboardScreen] is the central hub for the user, providing a high-level
/// overview of their learning journey, statistics, and recent updates.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Nexus Dashboard'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=nexus'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        // Added standard padding and safe area considerations
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 70,
            left: 20,
            right: 20,
            bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Welcome Header Section ---
            _buildPremiumHeader(theme),
            const SizedBox(height: 32),

            // --- Stats Dashboard ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Progress',
                  style: theme.textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View Detailed Analytics'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: const [
                StatCard(
                  title: 'Courses Completed',
                  value: '12',
                  icon: Icons.school_rounded,
                  backgroundColor: AppTheme.primaryColor,
                ),
                StatCard(
                  title: 'Certificates Earned',
                  value: '08',
                  icon: Icons.verified_user_rounded,
                  backgroundColor: AppTheme.successColor,
                ),
                StatCard(
                  title: 'Current Skill Score',
                  value: '87%',
                  icon: Icons.auto_graph_rounded,
                  backgroundColor: AppTheme.warningColor,
                ),
                StatCard(
                  title: 'Active Streaks',
                  value: '15',
                  icon: Icons.local_fire_department_rounded,
                  backgroundColor: AppTheme.errorColor,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // --- Recent Activity Section ---
            Text(
              'Recent Learning Activity',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildActivityList(theme),
          ],
        ),
      ),
    );
  }

  /// Builds a premium, gradient-styled header for the dashboard.
  Widget _buildPremiumHeader(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Keep Learning, Alex!',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You have 3 courses in progress. Complete them to earn your next badge.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Continue Learning'),
          ),
        ],
      ),
    );
  }

  /// Builds a list of activities using modern list items.
  Widget _buildActivityList(ThemeData theme) {
    final activities = [
      {
        'title': 'Module Completed',
        'subtitle': 'Advanced Flutter UI Patterns',
        'icon': Icons.check_circle_rounded,
        'color': AppTheme.successColor,
        'time': '2h ago'
      },
      {
        'title': 'New Course Enrolled',
        'subtitle': 'Enterprise Architecture 101',
        'icon': Icons.add_to_photos_rounded,
        'color': AppTheme.primaryColor,
        'time': '5h ago'
      },
      {
        'title': 'Assessment Passed',
        'subtitle': 'Cloud Security Basics',
        'icon': Icons.grade_rounded,
        'color': AppTheme.warningColor,
        'time': 'Yesterday'
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = activities[index];
        return Card(
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (item['color'] as Color).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(item['icon'] as IconData,
                  color: item['color'] as Color, size: 24),
            ),
            title: Text(item['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['subtitle'] as String,
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            trailing: Text(item['time'] as String,
                style: theme.textTheme.bodySmall?.copyWith(fontSize: 10)),
          ),
        );
      },
    );
  }
}
