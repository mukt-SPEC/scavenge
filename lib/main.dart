import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scavenge/common/error_screen.dart';
import 'package:scavenge/provider/providers.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/Theme/app_theme.dart';
import 'package:scavenge/features/home/view/home_page.dart';
import 'package:scavenge/provider/theme_provider';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: ScavengeApp()));
}

class ScavengeApp extends ConsumerWidget {
  const ScavengeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: ref
          .watch(authStateChangesProvider)
          .when(
            data: (user){
              if(user == null){
                
              }
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
              return SizedBox();
            },
          ),
      debugShowCheckedModeBanner: false,
    );
  }
}
