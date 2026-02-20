import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/features/authentication/controller/auth_controller.dart';
import 'package:scavenge/features/authentication/model/authstate.dart';
import 'package:scavenge/features/authentication/widget/auth_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isSignIn = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (_, next) {
      if (next is AuthFailure) {}

      if (next is AuthSuccess) {}
    });
    final authState = ref.watch(authControllerProvider);
    return switch (authState) {
      AuthLoading() => SizedBox(),
      _ => Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: SafeArea(
          child: Column(
            children: [
              AuthTextField(
                prefixIcon: MingCuteIcons.mgc_user_3_fill,
                obscureText: false,
                placeholder: 'Enter Email',
                label: 'Email',
                controller: _emailController,
              ),
            ],
          ),
        ),
      ),
    };
  }
}
