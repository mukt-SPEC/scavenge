import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scavenge/common/error_screen.dart';
import 'package:scavenge/features/home/view/home_view.dart';
import 'package:scavenge/features/onboarding/model/onboarding.dart';
import 'package:scavenge/features/onboarding/view/onboarding_view._default.dart';
import 'package:scavenge/provider/providers.dart';
import 'package:scavenge/provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/authentication/view/auth_page.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/Theme/app_theme.dart';
import 'package:scavenge/features/home/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: ScavengeApp(),
    ),
  );
}

class ScavengeApp extends ConsumerWidget {
  const ScavengeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    
    // Check if user has onboarded
    final prefs = ref.watch(sharedPreferencesProvider);
    final onboarding = Onboarding(sharedPreferences: prefs);
    final hasOnboarded = onboarding.isOnboarded();

    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: ref.watch(authStateChangesProvider).when(
        data: (user) {
          if (user == null) {
           
            return const AuthPage();
          }
          
         
          if (!hasOnboarded) {
            return OnboardingView();
          }

         
          return const HomeView();
        },
        error: (error, stackTrace) {
          return ErrorScreen(
            error: error.toString(),
            onRefresh: () {
              ref.invalidate(authStateChangesProvider);
            },
          );
        },
        loading: () {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
