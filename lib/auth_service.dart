import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'auth_state.dart';

const errorNetworkFailure = 'network-request-failed';
const errorInvalidPhone = 'invalid-phone-number';
const errorInvalidSmsCode = 'invalid-verification-code';

class AuthService {
  final FirebaseAuth _authFire;
  // used for getting user credentials after phone authentication
  String? _phoneVerificationId;
  // web used for getting user credentials after phone authentication
  ConfirmationResult? _confirmationResult;
  // used for resend sms
  String? _lastPhoneNumber;
  int? _smsResendToken;

  AuthService(this._authFire);

  Stream<AuthState> watchAuthState() {
    return _authFire
        .authStateChanges()
        .map(
          (user) =>
              user == null ? const Unauthenticated() : Authenticated(user.uid),
        )
        .asBroadcastStream();
  }

  Future<void> confirmSmsCode(String smsCode) async {
    try {
      if (kIsWeb) {
        await _confirmationResult!.confirm(smsCode);
      } else {
        AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _phoneVerificationId!,
          smsCode: smsCode,
        );
        // Sign the user in (or link) with the credential
        await _authFire.signInWithCredential(phoneAuthCredential);
      }
    } catch (e) {
      if (e is FirebaseAuthException && e.code == errorNetworkFailure) {
        throw 'NetworkFailureException()';
      }
      if (e is FirebaseAuthException && e.code == errorInvalidSmsCode) {
        throw '''InvalidInputException(
          'sms_code',
          description: 'The sms code you provided was incorrect',
        )''';
      }
      rethrow;
    }
  }

  Future<void> signOut() {
    return _authFire.signOut();
  }

  Future<void> sendSmsVerificationCode(String phoneNumber) async {
    _lastPhoneNumber = phoneNumber;
    if (kIsWeb) {
      _confirmationResult = await _authFire.signInWithPhoneNumber(phoneNumber);
      _phoneVerificationId = _confirmationResult!.verificationId;
    } else {
      await _verifyPhoneNumber(phoneNumber);
    }
  }

  Future<void> resendSmsVerificationCode() async {
    if (kIsWeb) {
      _confirmationResult =
          await _authFire.signInWithPhoneNumber(_lastPhoneNumber!);
      _phoneVerificationId = _confirmationResult!.verificationId;
    } else {
      await _verifyPhoneNumber(_lastPhoneNumber!, token: _smsResendToken!);
    }
  }

  Future<void> _verifyPhoneNumber(String phoneNumber, {int? token}) async {
    Completer completer = Completer<void>();
    _authFire.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: token,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // android only
        await _authFire.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == errorInvalidPhone) {
          completer.completeError(
            '''InvalidInputException(
              'phone_number',
              description: 'The phone number provided is incorrect',
            )''',
          );
        }
        if (e.code == errorNetworkFailure) {
          completer.completeError('NetworkFailureException()');
        }
        completer.completeError(e);
      },
      codeSent: (String verificationId, int? resendToken) async {
        _smsResendToken = resendToken;
        _phoneVerificationId = verificationId;
        completer.complete();
      },
      timeout: const Duration(seconds: 20),
      codeAutoRetrievalTimeout: (String id) {},
    );
    return completer.future;
  }
}
