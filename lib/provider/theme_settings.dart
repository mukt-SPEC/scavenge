import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/core/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = FutureProvider.autoDispose((ref) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  return pref;
});

final themeSettingsProvider = Provider.autoDispose((ref) async {
  final prefs = await ref.watch(sharedPrefProvider.future);
  return ThemeSettings(prefs);
});

class ThemeSettings {
  SharedPreferences? _sharedPreferences;

  ThemeSettings(SharedPreferences sharedPreferences)
    : _sharedPreferences = sharedPreferences,
      super();

  Futurevoid toggleTheme(bool newValue) async {
    await _sharedPreferences!.setBool('isDark', newValue);
  }

  bool isDark() {
    bool isDark = _sharedPreferences!.getBool('isDark') ?? true;
    return isDark;
  }
}
