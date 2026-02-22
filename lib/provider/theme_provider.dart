import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialized in main');
});

class ThemeNotifier extends Notifier<bool> {
  late SharedPreferences _prefs;

  @override
  bool build() {
    _prefs = ref.watch(sharedPreferencesProvider);

    return _prefs.getBool('isDark') ?? true;
  }

  void toggleTheme(bool isDark) {
    _prefs.setBool('isDark', isDark);
    state = isDark;
  }
}

// The provider to use in your UI
final themeProvider = NotifierProvider<ThemeNotifier, bool>(() {
  return ThemeNotifier();
});
