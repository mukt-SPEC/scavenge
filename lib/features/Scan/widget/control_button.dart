import 'package:flutter/cupertino.dart';
import 'package:scavenge/Theme/app_colors.dart';

class ControlButton extends StatelessWidget {
  final IconData child;
  final double? width;
  const ControlButton({this.width, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: width ?? 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.cardDark,
      ),
      child: Icon(child, color: Color(0xffb9b9b9)),
    );
  }
}
