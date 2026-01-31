import 'package:flutter/material.dart';

/// [CertificatesScreen] displays the user's earned credentials and badges.
/// It uses a mix of lists for certificates and grids for visual badges.
class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({super.key});

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Credentials'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.verified_rounded, color: Colors.blue)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section: Digital Certificates ---
            Text(
              'Digital Certificates',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildCertificateList(),
            const SizedBox(height: 32),

            // --- Section: Achievement Badges ---
            Text(
              'Achievement Badges',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildBadgeGrid(),
          ],
        ),
      ),
    );
  }

  /// Builds the list of certificates using premium list tiles.
  Widget _buildCertificateList() {
    final certs = [
      {
        'title': 'Expert Flutter Developer',
        'issuer': 'Nexus Core',
        'date': 'Jan 2025',
        'active': true
      },
      {
        'title': 'Advanced UI Architecture',
        'issuer': 'Design Lab',
        'date': 'Dec 2024',
        'active': true
      },
      {
        'title': 'Legacy Systems Migration',
        'issuer': 'IT Academy',
        'date': 'Oct 2024',
        'active': false
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: certs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final cert = certs[index];
        final isActive = cert['active'] as bool;

        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (isActive ? Colors.blue : Colors.grey)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isActive
                    ? Icons.workspace_premium_rounded
                    : Icons.history_rounded,
                color: isActive ? Colors.blue : Colors.grey,
              ),
            ),
            title: Text(cert['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${cert['issuer']} • ${cert['date']}',
                style: const TextStyle(fontSize: 12)),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Colors.grey[400]),
          ),
        );
      },
    );
  }

  /// Builds a grid of badges.
  Widget _buildBadgeGrid() {
    final badges = [
      {'emoji': '🎯', 'label': 'On Target'},
      {'emoji': '⚡', 'label': 'Fast Learner'},
      {'emoji': '🔥', 'label': '7 Day Streak'},
      {'emoji': '🧠', 'label': 'Quiz Master'},
      {'emoji': '🙌', 'label': 'Team Helper'},
      {'emoji': '💎', 'label': 'Top 1%'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: badges.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(badges[index]['emoji']!,
                  style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 8),
              Text(
                badges[index]['label']!,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
