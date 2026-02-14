import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/core/exceptions.dart';
import 'package:scavenge/core/logger.dart';
import 'package:scavenge/core/typedef.dart';
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
          throw 'Please enter a valid email address.';
        case 'user-disabled':
          throw 'This account has been disabled. Please contact support.';
        case 'user-not-found':
          throw 'No account found with this email. Please sign up first.';
        case 'wrong-password':
          throw 'Incorrect password. Please try again.';
        default:
          throw 'An error occurred during sign in. Please try again.';
      }
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw NoInternetException();
    } catch (e) {
      AppLogger.error(e.toString());
      throw UnexpectedException();
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
          throw 'This email is already registered. Please sign in instead.';

        case 'invalid-email':
          throw 'Please enter a valid email address.';
        case 'operation-not-allowed':
          throw 'Email/password accounts are not enabled. Please contact support.';
        case 'weak-password':
          throw 'The password is too weak. Please use a stronger password.';
        default:
          throw 'An error occurred during sign up. Please try again.';
      }
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw NoInternetException();
    } catch (e) {
      AppLogger.error(e.toString());
      throw UnexpectedException();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw NoInternetException();
    } catch (e) {
      AppLogger.error(e.toString());
      throw UnexpectedException();
    }
  }

  Future<bool> emailVerified() async {
    try {
      await _firebaseAuth.currentUser!.reload();
      return _firebaseAuth.currentUser!.emailVerified;
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw NoInternetException();
    } catch (e) {
      AppLogger.error(e.toString());
      throw UnexpectedException();
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw NoInternetException();
    } catch (e) {
      AppLogger.error(e.toString());
      throw UnexpectedException();
    }
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: _firebaseAuth.currentUser!.email!,
      );
    } on SocketException catch (e) {
      AppLogger.error(e.toString());
      throw NoInternetException();
    } catch (e) {
      AppLogger.error(e.toString());
      throw UnexpectedException();
    }
  }
}
