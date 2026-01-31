import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/stat_card.dart';
import '../theme/app_theme.dart';
import '../providers/assessment_provider.dart';
import '../providers/app_provider.dart';

/// [AnalyticsScreen] visualizes user performance data through charts and metrics.
/// It helps users understand their skill progression and career trends.
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<AppProvider>().userId ?? 'user_1';
      context.read<AssessmentProvider>().loadUserTestResults(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final assessmentProv = context.watch<AssessmentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Insights'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Core KPI Section ---
            Text(
              'Performance Overview',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                StatCard(
                  title: 'Success Rate',
                  value: '${assessmentProv.passRate.toStringAsFixed(0)}%',
                  icon: Icons.track_changes_rounded,
                  backgroundColor: Colors.teal,
                ),
                StatCard(
                  title: 'Average Score',
                  value: '${assessmentProv.averageScore.toStringAsFixed(1)}%',
                  icon: Icons.auto_awesome_rounded,
                  backgroundColor: Colors.indigo,
                ),
                StatCard(
                  title: 'Tests Taken',
                  value:
                      '${assessmentProv.passedResults.length + assessmentProv.failedResults.length}',
                  icon: Icons.assignment_turned_in_rounded,
                  backgroundColor: Colors.amber,
                ),
                StatCard(
                  title: 'Skill Level',
                  value: 'Expert',
                  icon: Icons.workspace_premium_rounded,
                  backgroundColor: Colors.pink,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // --- Skill DNA / Radial-like Progress Section ---
            Text(
              'Skill DNA Breakdown',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildSkillProgress(
                        theme, 'Mobile Development', 0.92, Colors.blue),
                    const SizedBox(height: 20),
                    _buildSkillProgress(
                        theme, 'UI/UX Design', 0.78, Colors.purple),
                    const SizedBox(height: 20),
                    _buildSkillProgress(
                        theme, 'Backend Logics', 0.85, Colors.orange),
                    const SizedBox(height: 20),
                    _buildSkillProgress(
                        theme, 'Agile Methodology', 0.88, Colors.green),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // --- AI Insights Summary ---
            Text(
              'AI Recommendations',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInsightCard(
              theme,
              'Career Path Trend',
              'You are trending towards a Senior Flutter Architect role. Focus on System Design next.',
              Icons.trending_up_rounded,
              AppTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to build a skill progress bar with label and percentage.
  Widget _buildSkillProgress(
      ThemeData theme, String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text('${(value * 100).toInt()}%',
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 10,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  /// Builds a descriptive insight card.
  Widget _buildInsightCard(
      ThemeData theme, String title, String desc, IconData icon, Color color) {
    return Card(
      color: color.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(desc,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
