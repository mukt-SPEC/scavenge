import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class QuickAction extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final String text;
  final Color? textColor;
  const QuickAction({
    this.textColor,
    this.iconColor,
    this.backgroundColor,
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 24),
              Icon(
                MingCuteIcons.mgc_arrow_right_up_fill,
                color: Color(0xffb9b9b9),
              ),
            ],
          ),
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: textColor ?? Colors.white),
          ),
        ],
      ),
    );
  }
}
