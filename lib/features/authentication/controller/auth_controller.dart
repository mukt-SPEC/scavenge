import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:scavenge/features/authentication/model/authstate.dart';
import 'package:scavenge/features/authentication/service/auth_service.dart';

final authControllerProvider = StateNotifierProvider((ref) {
  return AuthController(authservice: ref.read(authServiceProvider), ref: ref);
});

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
    } catch (e) {
      state = AuthFailure(message: e.toString());
    }
  }
}
