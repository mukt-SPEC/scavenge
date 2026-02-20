import 'package:flutter/material.dart';
import 'package:scavenge/Theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final int? maxLines;
  final IconData? prefixIcon;
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool obscureText;
  final GlobalKey<FormState>? formKey;

  const AuthTextField({
    this.prefixIcon,
    required this.obscureText,
    required this.placeholder,
    required this.label,
    super.key,
    this.formKey,
    this.maxLines,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        TextFormField(
          cursorColor: Colors.white,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
          key: formKey,
          maxLines: maxLines ?? 1,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon, color: Colors.white),
            hintText: placeholder,
            enabledBorder: enabledBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.backgroundLight),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder enabledBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.white),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
