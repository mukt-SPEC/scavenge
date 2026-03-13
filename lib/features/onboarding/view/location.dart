import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/common/app_button.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/features/onboarding/provider/onboarding_provider.dart';
import 'package:scavenge/features/onboarding/view/preferred_waste.dart';

class LocationSelectPage extends ConsumerStatefulWidget {
  const LocationSelectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LocationSelectPageState();
}

class _LocationSelectPageState extends ConsumerState<LocationSelectPage> {
  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.read(onboardingProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              if (onboardingState.userType == UserType.agent) {
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PreferredWaste()),
                );
              }
            },
            child: Text(
              'Skip',
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: Color(0xffb9b9b9)),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
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
                      'Location',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              Spacer(),
              AppButton(onPressed: () {}, buttonText: 'Choose location'),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
