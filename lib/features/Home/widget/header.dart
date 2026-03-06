import 'package:flutter/material.dart';
import 'package:scavenge/constants/app_images.dart';

class HomePageHeader extends StatelessWidget {
  final String? header;
  final String? subtitle;
  final String? image;

  const HomePageHeader({this.header, this.subtitle, this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          // spacing: 0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header ?? 'Save the Planet',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Color(0xfff2f2f2)),
            ),
            Text(
              subtitle ?? 'Recycle and Earn.',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: Color(0xffb9b9b9)),
            ),
          ],
        ),
        Image.asset(image ?? AppImages.earth, width: 96, height: 96),
      ],
    );
  }
}
