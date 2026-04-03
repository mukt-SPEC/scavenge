import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:scavenge/features/Profile/model/profile_state.dart';
import 'package:scavenge/features/Profile/service/profile_service.dart';
import 'package:scavenge/features/authentication/model/auth_failure.dart';
import 'package:scavenge/features/authentication/model/authstate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scavenge/features/onboarding/provider/onboarding_provider.dart';
import 'package:scavenge/model/user.dart';

final profileControllerProvider =
    StateNotifierProvider.autoDispose<ProfileController, UserState>((ref) {
      final profileService = ref.watch(profileServiceProvider);
      return ProfileController(profileService: profileService, ref: ref);
    });

class ProfileController extends StateNotifier<UserState> {
  final ProfileService _profileService;
  final Ref _ref;
  ProfileController({required ProfileService profileService, required Ref ref})
    : _profileService = profileService,
      _ref = ref,
      super(UserInitial());

  Future<UserModel?> getCurrentUser() async {
    try {
      final currentUser = await _ref
          .read(profileServiceProvider)
          .getCurrentUser();

      state = UserSuccess(user: currentUser);
      return currentUser;
    } on AuthFailure catch (error) {
      state = UserFailure(error: error.message);
      return null;
    } catch (e) {
      state = UserFailure(error: e.toString());
      return null;
    }
  }

  Future<UserModel?> saveUserFromOnboarding(
    OnboardingState onboardingState,
  ) async {
    UserLoading();
    try {
      await _profileService.saveUserFromOnboarding(onboardingState);
      final user = await getCurrentUser();
      state = UserSuccess(user: user);
      return user;
    } on AuthFailure catch (error) {
      state = UserFailure(error: error.message);
      return null;
    } catch (e) {
      state = UserFailure(error: e.toString());
      return null;
    }
  }

  Future<void> saveUserToDatabase(UserModel userModel) async {
    try {
      await _profileService.saveUserToDatabase(userModel);
      state = UserSuccess(user: userModel);
      _profileService.currentUser();
    } on AuthFailure catch (error) {
      state = UserFailure(error: error.message);
    } catch (e) {
      state = UserFailure(error: e.toString());
    }
  }
}
