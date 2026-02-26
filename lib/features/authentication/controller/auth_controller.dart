import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart' show StateNotifierProvider, StateNotifier;
import 'package:scavenge/features/authentication/model/auth_failure.dart';
import 'package:scavenge/features/authentication/model/authstate.dart';
import 'package:scavenge/features/authentication/service/auth_service.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(authservice: ref.read(authServiceProvider), ref: ref);
});

class AuthController extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthController({required AuthService authservice, required Ref ref})
    : _authService = authservice,
      super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    state = AuthLoading();
    try {
      await _authService.signIn(email, password);
      state = AuthSuccess();
    } on AuthFailure catch (failure) {
      state = AuthError(message: failure.message);
    } catch (e) {
      state = AuthError(message: 'An unexpected error occurred.');
    }
  }

  Future<void> signOut() async {
    state = AuthLoading();
    try {
      await _authService.signOut();
      state = AuthSuccess();
    } on AuthFailure catch (failure) {
      state = AuthError(message: failure.message);
    } catch (e) {
      state = AuthError(message: 'An unexpected error occurred.');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = AuthLoading();
    try {
      await _authService.sendPasswordResetEmail(email);
      state = AuthSuccess();
    } on AuthFailure catch (failure) {
      state = AuthError(message: failure.message);
    } catch (e) {
      state = AuthError(message: 'An unexpected error occurred.');
    }
  }
}
