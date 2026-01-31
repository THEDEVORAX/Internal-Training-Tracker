import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics & Reporting'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Metrics',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                StatCard(
                  title: 'Completion Rate',
                  value: '85%',
                  icon: Icons.check_circle,
                  backgroundColor: Colors.teal,
                ),
                StatCard(
                  title: 'Avg Assessment Score',
                  value: '4.2/5',
                  icon: Icons.grade,
                  backgroundColor: Colors.indigo,
                ),
                StatCard(
                  title: 'Learning Hours',
                  value: '156h',
                  icon: Icons.schedule,
                  backgroundColor: Colors.amber,
                ),
                StatCard(
                  title: 'Skill Level',
                  value: 'Advanced',
                  icon: Icons.auto_awesome,
                  backgroundColor: Colors.pink,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Skill DNA Section
            Text(
              'Skill DNA Profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                    color:
                        Theme.of(context).dividerColor.withValues(alpha: 0.1)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSkillTile('Flutter Development', 92),
                    const SizedBox(height: 16),
                    _buildSkillTile('Data Analysis', 78),
                    const SizedBox(height: 16),
                    _buildSkillTile('Cloud Architecture', 85),
                    const SizedBox(height: 16),
                    _buildSkillTile('Team Leadership', 88),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Insights Section
            Text(
              'Personalized Insights',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                    color:
                        Theme.of(context).dividerColor.withValues(alpha: 0.1)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.lightbulb_rounded,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Career Growth Opportunity',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Your Cloud Architecture skills are ready for senior roles',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                            ],
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

  Widget _buildSkillTile(String skillName, double proficiency) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skillName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              '${proficiency.toInt()}%',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            minHeight: 8,
            value: proficiency / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              proficiency >= 85 ? Colors.green : Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}
