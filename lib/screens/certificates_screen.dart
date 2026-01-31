import 'package:flutter/material.dart';

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({Key? key}) : super(key: key);

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Certificates & Credentials'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Digital Certificates',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return _buildCertificateCard(context, index);
              },
            ),
            const SizedBox(height: 24),
            Text(
              'Digital Badges',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 0.9,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildBadge('🌟', 'Top Performer'),
                _buildBadge('🚀', 'Fast Learner'),
                _buildBadge('🏆', 'Master'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateCard(BuildContext context, int index) {
    final certificates = [
      {
        'title': 'Flutter Development Professional',
        'issuer': 'Nexus Academy',
        'date': 'Jan 15, 2025',
        'status': 'Active',
      },
      {
        'title': 'Data Science Specialist',
        'issuer': 'Tech Institute',
        'date': 'Dec 20, 2024',
        'status': 'Active',
      },
      {
        'title': 'Cloud Computing Architect',
        'issuer': 'Cloud Masters',
        'date': 'Nov 10, 2024',
        'status': 'Expired',
      },
      {
        'title': 'Leadership Excellence',
        'issuer': 'Management Academy',
        'date': 'Oct 05, 2024',
        'status': 'Active',
      },
    ];

    final cert = certificates[index];
    final isExpired = cert['status'] == 'Expired';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:
                (isExpired ? Colors.grey : Colors.blue).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.workspace_premium_rounded,
            color: isExpired ? Colors.grey : Colors.blue,
          ),
        ),
        title: Text(
          cert['title'] as String,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${cert['issuer']} • ${cert['date']}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color:
                (isExpired ? Colors.red : Colors.green).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            cert['status'] as String,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isExpired ? Colors.red : Colors.green,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String emoji, String label) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
