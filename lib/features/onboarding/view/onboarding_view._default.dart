import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/common/app_button.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/features/authentication/view/login_page.dart';
import 'package:scavenge/features/home/widget/header.dart';
import 'package:scavenge/features/home/widget/quick_actions.dart';
import 'package:scavenge/features/onboarding/provider/onboarding_provider.dart';
import 'package:scavenge/features/onboarding/view/basic_info_page.dart';

class OnboardingView extends ConsumerStatefulWidget {
  //final UserModel userModel;
  const OnboardingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 24,
          children: [
            HomePageHeader(header: 'Welcome to', subtitle: 'SCAVENGE'),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/agent.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.2),
                      BlendMode.darken,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recycle',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: AppColors.white,
                        fontSize: 56,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How will you be using Scavenge?'),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => ref
                            .read(onboardingProvider.notifier)
                            .setUserType(UserType.agent),
                        child: QuickAction(
                          backgroundColor:
                              ref.watch(onboardingProvider).userType ==
                                  UserType.agent
                              ? Color(0xff0234b3)
                              : AppColors.cardDark,
                          icon: MingCuteIcons.mgc_IDcard_fill,
                          text: 'AGENT',
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => ref
                            .read(onboardingProvider.notifier)
                            .setUserType(UserType.customer),
                        child: QuickAction(
                          backgroundColor:
                              ref.watch(onboardingProvider).userType ==
                                  UserType.customer
                              ? Color(0xff008000)
                              : AppColors.cardDark,
                          icon: MingCuteIcons.mgc_group_3_fill,
                          text: 'CUSTOMER',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                AppButton(
                  onPressed: ref.watch(onboardingProvider).userType != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BasicInfoPage(),
                            ),
                          );
                        }
                      : null,
                  buttonText: 'Get Started',
                ),
                SizedBox(height: 64),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
