import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/common/app_button.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/features/authentication/widget/auth_text_field.dart';
import 'package:scavenge/features/onboarding/provider/onboarding_provider.dart';
import 'package:scavenge/features/onboarding/view/location.dart';

class BasicInfoPage extends ConsumerStatefulWidget {
  const BasicInfoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends ConsumerState<BasicInfoPage> {
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose;
    phoneNumberController.dispose;
    super.dispose();
  }

  void setNameAndPassword() {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text;
      final phoneNumber = phoneNumberController.text;

      ref.read(onboardingProvider.notifier).setName(name);
      ref.read(onboardingProvider.notifier).setPhoneNumber(phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    final onboardingstate = ref.read(onboardingProvider);

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            spacing: 24,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                spacing: 24,

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
                    key: _formKey,
                    child: Column(
                      spacing: 16,
                      children: [
                        AuthTextField(
                          obscureText: false,
                          placeholder: 'Enter name',
                          label: 'What should we call you',
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter a name';
                            }
                            return null;
                          },
                        ),
                        AuthTextField(
                          obscureText: false,
                          placeholder: 'Phone Number',
                          label: 'Enter Phone number',
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: phoneNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter a phone number';
                            }
                            if (value.length != 11) {
                              return 'please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              AppButton(
                onPressed: () {
                  setNameAndPassword();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LocationSelectPage(),
                    ),
                  );
                },
                buttonText: 'Proceed',
              ),
              SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}
