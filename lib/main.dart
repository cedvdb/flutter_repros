import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_repros/app.dart';

import 'auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('a');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  print('b');
  final fAuth = FirebaseAuth.instance;
  await fAuth.useAuthEmulator(
    '10.0.2.2', // android or localhost for other platforms
    9099,
  );
  print('c');
  final authService = AuthService(fAuth);
  runApp(TestApp(authService: authService));
}
