import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/Theme/app_colors.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 72),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff7a7a7a),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
