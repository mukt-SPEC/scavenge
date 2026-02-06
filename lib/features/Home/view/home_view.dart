import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/features/home/widget/quick_actions.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Map<String, dynamic>> gridData = [
    {
      'icon': MingCuteIcons.mgc_wallet_3_fill,
      'label': 'Wallet',
      'backgroundColor': Colors.green,
    },

    {
      'icon': MingCuteIcons.mgc_group_3_fill,
      'label': 'Agents',
      'backgroundColor': Colors.blue,
    },
    {
      'icon': MingCuteIcons.mgc_shop_fill,
      'label': 'Trade',
      'backgroundColor': Colors.purple,
    },
    {
      'icon': MingCuteIcons.mgc_recycle_fill,
      'label': 'Recycle',
      'backgroundColor': Colors.teal,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Padding(
        padding: const EdgeInsets.only(top: 72.0, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Action',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Color(0xffffffff)),
            ),

            Expanded(
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: gridData.length,
                itemBuilder: (context, index) {
                  final item = gridData[index];
                  return QuickAction(
                    iconColor: Colors.black,
                    icon: item['icon'],
                    text: item['label'],
                    backgroundColor: item['backgroundColor'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
