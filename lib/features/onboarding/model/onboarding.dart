import 'package:shared_preferences/shared_preferences.dart';

class Onboarding {
  final SharedPreferences? _sharedPreferences;

  Onboarding({required SharedPreferences? sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  Future<void> onboarded(bool value) async {
    await _sharedPreferences!.setBool('isOnboarded', value);
  }

  bool isOnboarded() {
    bool isOnboarded = _sharedPreferences!.getBool('isOnboarded') ?? false;
    return isOnboarded;
  }
}
