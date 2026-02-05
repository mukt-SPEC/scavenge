import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/features/home/widget/quick_actions.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Padding(
        padding: const EdgeInsets.only(top: 72.0, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Action',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Color(0xffffffff)),
            ),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
                childAspectRatio: 1.7,
                children: [
                  QuickAction(
                    icon: MingCuteIcons.mgc_recycle_line,
                    text: 'Recycle',
                    backgroundColor: Color(0xffb9b9b9),
                  ),
                  QuickAction(
                    icon: MingCuteIcons.mgc_refresh_2_line,
                    text: 'Trade',
                    backgroundColor: Color(0xffb9b9b9),
                  ),
                  QuickAction(
                    icon: MingCuteIcons.mgc_wallet_3_line,
                    text: 'Wallet',
                    backgroundColor: Color(0xffb9b9b9),
                  ),
                  QuickAction(
                    icon: MingCuteIcons.mgc_group_3_line,
                    text: 'Agents',
                    backgroundColor: Color(0xffb9b9b9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
