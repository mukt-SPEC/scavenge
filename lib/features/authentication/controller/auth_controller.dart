import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart'
    show StateNotifierProvider, StateNotifier;
import 'package:scavenge/core/typedef.dart';
import 'package:scavenge/features/Profile/service/profile_service.dart';
import 'package:scavenge/features/authentication/model/auth_failure.dart';
import 'package:scavenge/features/authentication/model/authstate.dart';
import 'package:scavenge/features/authentication/service/auth_service.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(authservice: ref.read(authServiceProvider), ref: ref);
  },
);

class AuthController extends StateNotifier<AuthState> {
  final AuthService _authService;

  final Ref _ref;

  AuthController({required AuthService authservice, required Ref ref})
    : _authService = authservice,

      _ref = ref,
      super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    state = AuthLoading();
    try {
      await _authService.signIn(email, password);
      final user = await _ref.read(profileServiceProvider).getCurrentUser();
      state = AuthSuccess(user: user);
    } on AuthFailure catch (failure) {
      state = AuthError(message: failure.message);
    } catch (e) {
      state = AuthError(message: 'An unexpected error occurred.');
    }
  }

  Futurevoid signUp(String email, String password) async {
    state = AuthLoading();
    try {
      await _authService.signUp(email, password);
      state = AuthSuccess();
    } on AuthFailure catch (failure) {
      state = AuthError(message: failure.message);
    } catch (e) {
      state = AuthError(message: e.toString());
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
