import 'package:flutter/material.dart';
import 'index.dart';

/// [MainScreen] serves as the root navigation hub of the application.
/// It utilizes a [PageView] for smooth horizontal transitions between
/// top-level screens and a modern M3 [NavigationBar].
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // --- State Variables ---
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // --- Screens List ---
  final List<Widget> _screens = [
    const DashboardScreen(),
    const CoursesScreen(),
    const AnalyticsScreen(),
    const CertificatesScreen(),
  ];

  /// Handles tap events from the NavigationBar.
  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    // Animate to the selected page with a smooth curve
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuart,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PageView provides the horizontal sliding effect
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        // We disable user swiping to maintain deterministic navigation
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),

      // Modern Navigation Bar with custom shadow and M3 aesthetics
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 24,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          elevation: 0, // Shadow is handled by the container
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.grid_view_rounded),
              selectedIcon: Icon(Icons.grid_view_sharp),
              label: 'Overview',
            ),
            NavigationDestination(
              icon: Icon(Icons.school_outlined),
              selectedIcon: Icon(Icons.school_rounded),
              label: 'Learning',
            ),
            NavigationDestination(
              icon: Icon(Icons.insert_chart_outlined_rounded),
              selectedIcon: Icon(Icons.insert_chart_rounded),
              label: 'Metrics',
            ),
            NavigationDestination(
              icon: Icon(Icons.workspace_premium_outlined),
              selectedIcon: Icon(Icons.workspace_premium_rounded),
              label: 'Badges',
            ),
          ],
        ),
      ),
    );
  }
}
