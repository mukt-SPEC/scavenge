import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scavenge/Theme/app_colors.dart';

void displaySnackBar(
  BuildContext context,
  String message, {
  bool isError = true,
  VoidCallback? onDisplaycomplete,
}) {
  final screenHeight = MediaQuery.of(context).size.height;
  final double topPosition = screenHeight - 150;

  ScaffoldMessenger.of(context).showSnackBar(
    isError
        ? SnackBar(
            backgroundColor: Color.fromARGB(255, 248, 32, 32),
            content: Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(color: AppColors.white),
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: topPosition),
          )
        : SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: topPosition),
          ),
  );
  onDisplaycomplete;
}
