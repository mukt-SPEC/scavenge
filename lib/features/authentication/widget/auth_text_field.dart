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
          key: formKey,
          maxLines: maxLines ?? 1,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            hintText: placeholder,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.backgroundLight),
            ),
          ),
        ),
      ],
    );
  }
}
