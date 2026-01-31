import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_training_tracker/main.dart';
import 'package:nexus_training_tracker/screens/main_screen.dart';

void main() {
  testWidgets('App structural test', (tester) async {
    // Initialize the root app widget.
    await tester.pumpWidget(const NexusApp());

    // Verify MainScreen presence.
    expect(find.byType(MainScreen), findsOneWidget);

    // Verify NavigationBar exists for core navigation.
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
