import 'package:flutter/material.dart';
import 'package:flutter_repros/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.textContaining('1'), findsNothing);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.textContaining('1'), findsOneWidget);
    });
  });
}
