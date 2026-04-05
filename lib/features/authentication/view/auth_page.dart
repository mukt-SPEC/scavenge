import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/common/app_button.dart';
import 'package:scavenge/features/authentication/controller/auth_controller.dart';
import 'package:scavenge/features/authentication/model/authstate.dart';
import 'package:scavenge/features/authentication/widget/Display_sncakBar.dart';
import 'package:scavenge/features/authentication/widget/auth_text_field.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  bool isSignIn = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      await ref.read(authControllerProvider.notifier).signUp(email, password);
    }
  }

  Future<void> _logIn() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      await ref.read(authControllerProvider.notifier).signIn(email, password);
    }
  }

  Future<void> _forgotPassword() async {
    final email = _emailController.text.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid email first.')),
      );
      return;
    }
    await ref
        .read(authControllerProvider.notifier)
        .sendPasswordResetEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (_, next) {
      if (!context.mounted) return;

      if (next is AuthError) {
        displaySnackBar(
          context,
          next.message,
          isError: true,
          onDisplaycomplete: () => ref.invalidate(authControllerProvider),
        );
      }
      if (next is AuthSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request completed successfully.')),
        );
      }
    });
    final authState = ref.watch(authControllerProvider);
    final isSubmitting = authState is AuthLoading;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              spacing: 16,
              children: [
                AuthTextField(
                  prefixIcon: MingCuteIcons.mgc_user_3_fill,
                  obscureText: false,
                  placeholder: 'Enter Email',
                  label: 'Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                AuthTextField(
                  prefixIcon: MingCuteIcons.mgc_lock_fill,
                  obscureText: true,
                  enableObscureToggle: true,
                  placeholder: 'Enter password',
                  label: 'Password',
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    final strongPassword = RegExp(
                      r'^(?=.*[A-Za-z])(?=.*\d).{8,}$',
                    );
                    if (!strongPassword.hasMatch(value)) {
                      return 'Password must contain letters and numbers';
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: isSubmitting ? null : _forgotPassword,
                  child: const Text('Forgot password?'),
                ),
                AppButton(
                  onPressed: isSignIn ? _logIn : _signUp,
                  buttonText: isSignIn ? 'Log in' : 'Sign up',
                  isLoading: isSubmitting,
                ),
                // ElevatedButton(
                //   onPressed: isSubmitting ? null : (isSignIn ? _logIn : _signUp),
                //   child: isSubmitting
                //       ? const SizedBox(
                //           width: 18,
                //           height: 18,
                //           child: CircularProgressIndicator(strokeWidth: 2),
                //         )
                //       : Text(isSignIn ? 'Log in' : 'Sign up'),
                // ),
                TextButton(
                  onPressed: isSubmitting
                      ? null
                      : () {
                          setState(() {
                            isSignIn = !isSignIn;
                          });
                        },
                  child: Text(
                    isSignIn
                        ? "Don't have an account? Sign up"
                        : "Already have an account? Log in",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
