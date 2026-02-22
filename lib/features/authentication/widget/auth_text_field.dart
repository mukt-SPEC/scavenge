import 'package:flutter/material.dart';
import 'package:scavenge/Theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final int? maxLines;
  final IconData? prefixIcon;
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool obscureText;

  final String? Function(String?)? validator;
  final void Function(String?)? onsaved;

  const AuthTextField({
    this.onsaved,
    this.validator,
    this.prefixIcon,
    required this.obscureText,
    required this.placeholder,
    required this.label,
    super.key,

    this.maxLines,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        SizedBox(
          height: 30,
          child: TextFormField(
            textAlign: TextAlign.center,
            cursorColor: Colors.white,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.white),

            validator: validator,
            onSaved: onsaved,
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
