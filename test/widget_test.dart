import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_training_tracker/main.dart';
import 'package:nexus_training_tracker/screens/main_screen.dart';

void main() {
  testWidgets('App structural test', (WidgetTester tester) async {
    // Provide a mock image provider to handle NetworkImage issues if they occur at root level
    await tester.pumpWidget(const NexusApp());

    // Check for MainScreen
    expect(find.byType(MainScreen), findsOneWidget);

    // Check for NavigationBar
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
