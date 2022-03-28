// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_repros/auth_service.dart';
import 'package:flutter_repros/firebase_options.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/auth_helper.dart';

void main() {
  Firebase.initializeApp(
    name: 'test',
    options: DefaultFirebaseOptions.android,
  );
  final fAuth = FirebaseAuth.instance;
  fAuth.useAuthEmulator(
    '10.0.2.2', // android or localhost for other platforms
    9099,
  );
  final authService = AuthService(fAuth);
  final authHelper = AuthHelper(authService);

  group('authentication', () {
    testWidgets('Should authenticate', (tester) async {});

    testWidgets('Should authenticate once more', (tester) async {});
  });
}
