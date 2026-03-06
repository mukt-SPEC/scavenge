import 'package:flutter/material.dart';
import 'package:scavenge/Theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final String buttonText;
  const AppButton({
    this.height,
    this.width,
    this.backgroundColor,
    this.textColor,
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 44,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.white,
          foregroundColor: textColor ?? AppColors.backgroundDark,
          disabledBackgroundColor: Color(0xffb9b9b9),
          disabledForegroundColor: Color(0xff1e1e1e),
          elevation: 0,
        ),
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: AppColors.backgroundDark,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
