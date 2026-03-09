import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/features/authentication/widget/auth_text_field.dart';
import 'package:scavenge/features/onboarding/provider/onboarding_provider.dart';

class BasicInfoPage extends ConsumerStatefulWidget {
  const BasicInfoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends ConsumerState<BasicInfoPage> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose;
    phoneNumberController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingstate = ref.read(onboardingProvider);
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.cardDark,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    onboardingstate.userType == UserType.customer
                        ? 'Customer'
                        : 'Agent',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Form(
              child: Column(
                children: [
                  AuthTextField(
                    obscureText: false,
                    placeholder: 'Enter name',
                    label: 'What should we call you',
                    controller: nameController,
                  ),
                  AuthTextField(
                obscureText: false,
                placeholder: 'Phone Number',
                label: 'What should we call you',
                controller: nameController,
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
