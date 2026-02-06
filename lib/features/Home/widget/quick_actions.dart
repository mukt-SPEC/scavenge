import 'package:flutter/material.dart';

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
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
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
