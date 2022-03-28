import 'dart:convert';

import 'package:flutter_repros/auth_service.dart';
import 'package:flutter_repros/auth_state.dart';
import 'package:flutter_repros/firebase_options.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class AuthHelper {
  static const testPhoneNumber = '+16505551234';
  static const testPhoneOtherUser = '+16505551235';
  final AuthService auth;

  AuthHelper(this.auth);

  Future<String> signIn() {
    return _signIn(testPhoneNumber);
  }

  Future<String> signInAnotherUser() {
    return _signIn(testPhoneOtherUser);
  }

  Future<String> _signIn(String phoneNumber) async {
    final authState = await auth
        .watchAuthState()
        .where((state) => state is! AuthStateUnknown)
        .first;

    if (authState is Unauthenticated) {
      await auth.sendSmsVerificationCode(phoneNumber);
      final code = await retrieveSmsCode();
      await auth.confirmSmsCode(code);
    }
    final authenticatedState =
        await auth.watchAuthState().whereType<Authenticated>().first;
    return authenticatedState.userId;
  }

  Future<void> signOut() async {
    final authState = await auth
        .watchAuthState()
        .where((state) => state is! AuthStateUnknown)
        .first;
    if (authState is Authenticated) {
      await auth.signOut();
    }
  }

  Future<String> retrieveSmsCode() async {
    final Uri endpoint = Uri(
      scheme: 'http',
      host: '10.0.2.2', // android or localhost for other platforms
      port: 9099,
      path:
          'emulator/v1/projects/${DefaultFirebaseOptions.android.projectId}/verificationCodes',
    );
    final response = await http.get(endpoint);
    if (response.statusCode != 200) {
      throw response.body;
    }
    Map body = jsonDecode(response.body);
    print(body);
    final code = body['verificationCodes'].last['code'];
    return code;
  }
}
