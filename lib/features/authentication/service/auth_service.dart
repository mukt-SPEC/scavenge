import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/core/logger.dart';
import 'package:scavenge/features/authentication/model/auth_failure.dart';
import 'package:scavenge/provider/providers.dart';

// abstract class InterfaceAuthService{
//   Futurevoid SignIn({required String email,required String password,required String name,});

// }

final authServiceProvider = Provider.autoDispose((ref) {
  return AuthService(firebaseAuth: ref.watch(firebaseAuthProvider));
});

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth,

      super();

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw const InvalidEmailFailure();
        case 'user-disabled':
          throw const UserDisabledFailure();
        case 'user-not-found':
          throw const UserNotFoundFailure();
        case 'wrong-password':
          throw const WrongPasswordFailure();
        default:
          throw const UnknownAuthFailure();
      }
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw const NetworkFailure();
    } catch (e) {
      AppLogger.error(e.toString());
      throw const UnknownAuthFailure();
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firebaseAuth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw const EmailAlreadyInUseFailure();

        case 'invalid-email':
          throw const InvalidEmailFailure();
        case 'operation-not-allowed':
          throw const OperationNotAllowedFailure();
        case 'weak-password':
          throw const WeakPasswordFailure();
        default:
          throw const UnknownAuthFailure();
      }
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw const NetworkFailure();
    } catch (e) {
      AppLogger.error(e.toString());
      throw const UnknownAuthFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw const NetworkFailure();
    } catch (e) {
      AppLogger.error(e.toString());
      throw const UnknownAuthFailure();
    }
  }

  Future<bool> emailVerified() async {
    try {
      await _firebaseAuth.currentUser!.reload();
      return _firebaseAuth.currentUser!.emailVerified;
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw const NetworkFailure();
    } catch (e) {
      AppLogger.error(e.toString());
      throw const UnknownAuthFailure();
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw const InvalidEmailFailure();
        default:
          throw const UnknownAuthFailure();
      }
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw const NetworkFailure();
    } catch (e) {
      AppLogger.error(e.toString());
      throw const UnknownAuthFailure();
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw const InvalidEmailFailure();
        case 'user-not-found':
          throw const UserNotFoundFailure();
        default:
          throw const ResetPasswordFailure();
      }
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw const NetworkFailure();
    } catch (e) {
      AppLogger.error(e.toString());
      throw const UnknownAuthFailure();
    }
  }
}
