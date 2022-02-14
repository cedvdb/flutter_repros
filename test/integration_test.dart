import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp());
      // make the test hang to try to ctrl + c
      await Future.delayed(const Duration(seconds: 100));
    });
  });
}
