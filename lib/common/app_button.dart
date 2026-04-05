import 'package:flutter/material.dart';
import 'package:scavenge/Theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final String buttonText;
  final bool isLoading;
  const AppButton({
    this.height,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
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
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.white,
          foregroundColor: textColor ?? AppColors.backgroundDark,
          disabledBackgroundColor: Color(0xffb9b9b9),
          disabledForegroundColor: Color(0xff1e1e1e),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.backgroundDark,
                ),
              )
            : Text(
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
