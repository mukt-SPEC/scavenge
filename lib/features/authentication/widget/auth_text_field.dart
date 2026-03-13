import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:scavenge/Theme/app_colors.dart';

class AuthTextField extends StatefulWidget {
  final int? maxLines;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool obscureText;
  final bool enableObscureToggle;

  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const AuthTextField({
    this.keyboardType,
    this.enableObscureToggle = false,
    this.suffixIcon,
    this.onSaved,
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
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant AuthTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _isObscured = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final canToggleObscure = widget.obscureText && widget.enableObscureToggle;

    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.bodySmall),
        TextFormField(
          keyboardType: widget.keyboardType,
          //textAlign: TextAlign.center,
          cursorColor: Colors.white,
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(color: Colors.white),

          validator: widget.validator,
          onSaved: widget.onSaved,
          maxLines: widget.maxLines ?? 1,
          controller: widget.controller,
          obscureText: canToggleObscure ? _isObscured : widget.obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //  prefixIcon: Icon(widget.prefixIcon, color: Colors.white) ,
            suffixIcon: canToggleObscure
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    icon: Icon(
                      _isObscured
                          ? MingCuteIcons.mgc_eye_close_fill
                          : MingCuteIcons.mgc_eye_fill,
                      color: Colors.white,
                    ),
                  )
                : (widget.suffixIcon == null
                      ? null
                      : Icon(widget.suffixIcon, color: Colors.white)),
            hintText: widget.placeholder,
            hintStyle: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: Color(0xffb9b9b9)),
            enabledBorder: enabledBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.cardDark),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder enabledBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.cardDark),
      borderRadius: BorderRadius.circular(12),
    );
  }
}
