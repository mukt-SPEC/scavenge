import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/Theme/app_theme.dart';
import 'package:scavenge/constants/ui_constants.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _page = 0;

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: IndexedStack(index: _page, children: UiConstants.appPages),
      bottomNavigationBar: CupertinoTabBar(
        border: Border.all(style: BorderStyle.none),
        iconSize: 24,
        backgroundColor: AppColors.surfaceDark,
        currentIndex: _page,
        onTap: onPageChange,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(MingCute.home_2_fill, color: AppColors.white),
            icon: Icon(MingCute.home_2_fill),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(MingCute.wallet_fill, color: AppColors.white),
            icon: Icon(MingCute.wallet_fill),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(MingCute.sparkles_2_fill, color: AppColors.white),
            icon: Icon(MingCute.sparkles_2_fill),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(MingCute.user_3_fill, color: AppColors.white),
            icon: Icon(MingCute.user_3_fill),
          ),
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(radius: 16),
            icon: CircleAvatar(radius: 16),
          ),
        ],
      ),
    );
  }
}
