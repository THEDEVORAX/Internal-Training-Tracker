import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_training_tracker/main.dart';

void main() {
  testWidgets('App smoke test', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NexusApp());

    // Verify that the dashboard title is present.
    expect(find.text('Nexus Dashboard'), findsOneWidget);
  });
}
