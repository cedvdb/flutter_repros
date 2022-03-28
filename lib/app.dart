import 'package:flutter/material.dart';
import 'package:flutter_repros/auth_helper.dart';
import 'package:flutter_repros/auth_service.dart';
import 'package:flutter_repros/auth_state.dart';

class TestApp extends StatelessWidget {
  final AuthService authService;
  late final AuthHelper authHelper = AuthHelper(authService);
  TestApp({Key? key, required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test app',
      home: Scaffold(
        body: Center(
          child: StreamBuilder<AuthState>(
            stream: authService.watchAuthState(),
            builder: (state, snap) {
              if (!snap.hasData) {
                return Container();
              }
              final state = snap.data!;
              print(state);
              if (state is Unauthenticated) {
                return ElevatedButton(
                  onPressed: () => authHelper.signIn(),
                  child: const Text('sign in'),
                );
              }
              if (state is Authenticated) {
                return ElevatedButton(
                  onPressed: () => authHelper.signOut(),
                  child: const Text('sign out'),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
