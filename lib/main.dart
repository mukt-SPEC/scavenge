import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/Theme/app_theme.dart';
import 'package:scavenge/features/Home/view/home_page.dart';
import 'package:scavenge/provider/theme_provider';

void main() {
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
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
