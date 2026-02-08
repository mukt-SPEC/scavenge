import 'package:flutter/material.dart';
import 'package:scavenge/constants/app_images.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Save the Planet',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Color(0xfff2f2f2)),
            ),
            Text(
              'Recycle and Earn.',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Color(0xffb9b9b9)),
            ),
          ],
        ),
        Image.asset(AppImages.earth, width: 96, height: 96),
      ],
    );
  }
}
