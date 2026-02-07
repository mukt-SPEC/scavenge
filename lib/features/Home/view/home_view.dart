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
  List<Map<String, dynamic>> gridData = [
    {
      'icon': MingCuteIcons.mgc_recycle_fill,
      'label': 'Recycle',
      'backgroundColor': Color(0xff008000),
    },
    {
      'icon': MingCuteIcons.mgc_shopping_bag_2_fill,
      'label': 'Trade',
      'backgroundColor': Color(0xff885902),
    },
    {
      'icon': MingCuteIcons.mgc_wallet_3_fill,
      'label': 'Withdraw',
      'backgroundColor': Color(0xffb30278),
    },
    {
      'icon': MingCuteIcons.mgc_group_3_fill,
      'label': 'Find Agents',
      'backgroundColor': Color(0xff0234b3),
    },
  ];

  List iconColors = [
    Colors.green[50],
    Colors.blue[50],
    Colors.purple[50],
    Colors.teal[50],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.cardDark,
                    child: Icon(MingCuteIcons.mgc_user_3_fill),
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: AppColors.cardDark,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Icon(
                          MingCuteIcons.mgc_notification_fill,
                          color: AppColors.white,
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: AppColors.cardDark,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Icon(
                          MingCuteIcons.mgc_more_2_fill,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Quick Action',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: Color(0xffffffff)),
              ),

              MasonryGridView.count(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 8, bottom: 8),
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemCount: gridData.length,
                itemBuilder: (context, index) {
                  final item = gridData[index];
                  return QuickAction(
                    iconColor: iconColors[index],
                    icon: item['icon'],
                    text: item['label'],
                    textColor: iconColors[index],
                    backgroundColor: item['backgroundColor'],
                  );
                },
              ),
              SizedBox(height: 16),
              Text(
                'Analytics',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: Color(0xffffffff)),
              ),
              SizedBox(height: 8),
              Container(
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
