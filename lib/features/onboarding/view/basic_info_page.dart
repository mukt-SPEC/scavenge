import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/common/app_button.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/features/authentication/widget/auth_text_field.dart';
import 'package:scavenge/features/onboarding/provider/onboarding_provider.dart';
import 'package:scavenge/features/onboarding/view/agent_type.dart';
import 'package:scavenge/features/onboarding/view/location_view.dart';
import 'package:scavenge/utils/formatter.dart';
import 'package:scavenge/utils/validator.dart';

class BasicInfoPage extends ConsumerStatefulWidget {
  const BasicInfoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends ConsumerState<BasicInfoPage> {
  final nameController = TextEditingController(text: 'Test User');
  final phoneNumberController = TextEditingController(text: '08123456789');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.addListener(_updateState);
    phoneNumberController.addListener(_updateState);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  void dispose() {
    nameController.removeListener(_updateState);
    phoneNumberController.removeListener(_updateState);
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void setNameAndPassword() {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text;
      final phoneNumber = phoneNumberController.text;

      ref.read(onboardingProvider.notifier).setName(name);
      ref.read(onboardingProvider.notifier).setPhoneNumber(phoneNumber);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LocationSelectPage()),
      );
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

            children: [
              Column(
                spacing: 24,

                children: [
                  Column(
                    children: [
                      Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: Text(
                          // onboardingstate.userType == UserType.customer
                          //     ? 'Customer'
                          //     : 'Agent',
                          'Setup your profile',
                          textAlign: TextAlign.left,

                          style: Theme.of(context).textTheme.displayLarge!
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ],
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
                          validator: (value) =>
                              Validators.validateFullName(value),
                          onSaved: (value) {
                            setState(() {
                              nameController.text = value!;
                            });
                          },
                        ),
                        AuthTextField(
                          obscureText: false,
                          placeholder: 'Phone Number',
                          label: 'Enter Phone number',
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: phoneNumberController,
                          validator: (value) =>
                              Validators.validateNigerianPhoneNumber(value),

                          onSaved: (value) {
                            setState(() {
                              phoneNumberController.text = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              AppButton(
                onPressed:
                    nameController.text.trim().isNotEmpty &&
                        phoneNumberController.text.trim().isNotEmpty
                    ? () {
                        setNameAndPassword();
                      }
                    : null,
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
