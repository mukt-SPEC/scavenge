import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/constants/app_images.dart';
import 'package:scavenge/features/home/widget/header.dart';
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
              SizedBox(height: 24),
              HomePageHeader(),
              SizedBox(height: 8),
              Text(
                'Quick Action',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Color(0XFFB9B9B9)),
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
              SizedBox(height: 8),
              Text(
                'Analytics',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: Color(0XFFB9B9B9)),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                height: 88,

                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 48, 48, 48)),
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 4,
                          children: [
                            Icon(
                              MingCuteIcons.mgc_cash_2_fill,
                              color: Color(0xffb9b9b9),
                              size: 16,
                            ),
                            Text(
                              'Total Earning',
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(color: Color(0xffb9b9b9)),
                            ),
                          ],
                        ),
                        Text(
                          '\$ 50.00',
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(color: Color(0xfff2f2f2)),
                        ),
                      ],
                    ),
                    Image.asset(
                      AppImages.graph,
                      width: 64,
                      height: 64,
                      // scale: 0.2,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              MostRecycled(),
            ],
          ),
        ),
      ),
    );
  }
}

class MostRecycled extends StatelessWidget {
  const MostRecycled({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: 88,
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 48, 48, 48)),
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 4,
                children: [
                  Icon(
                    MingCuteIcons.mgc_wastebasket_fill,
                    color: Color(0xffb9b9b9),
                    size: 16,
                  ),
                  Text(
                    'Most Recycled Material ',
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: Color(0xffb9b9b9)),
                  ),
                ],
              ),
              Text(
                'Paper',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Color(0xfff2f2f2)),
              ),
            ],
          ),
          Image.asset(AppImages.paper, width: 64, height: 64),
        ],
      ),
    );
  }
}
