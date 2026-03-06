import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:scavenge/features/Profile/service/profile_service.dart';
import 'package:scavenge/features/authentication/model/auth_failure.dart';
import 'package:scavenge/features/authentication/model/authstate.dart';
import 'package:firebase_auth/firebase_auth.dart';

final profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, AuthState>((ref) {
      final profileService = ref.watch(profileServiceProvider);
      return ProfileController(profileService: profileService, ref: ref);
    });

class ProfileController extends StateNotifier<AuthState> {
  final ProfileService _profileService;
  final Ref _ref;
  ProfileController({required ProfileService profileService, required Ref ref})
    : _profileService = profileService,
      _ref = ref,
      super(AuthInitial());

  Future<User?> getCurrentUser() async {
    try {
      final currentUser = await _ref
          .read(profileServiceProvider)
          .getCurrentUser();
      state = AuthSuccess(user: currentUser);
    } on AuthFailure catch (error) {
      state = AuthError(message: error.message);
    } catch (e) {
      state = AuthError(message: e.toString());
    }
  }
}
