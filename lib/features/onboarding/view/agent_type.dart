import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/common/app_button.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/features/home/widget/quick_actions.dart';
import 'package:scavenge/features/onboarding/provider/onboarding_provider.dart';
import 'package:scavenge/features/onboarding/view/basic_info_page.dart';
import 'package:scavenge/features/onboarding/view/location_view.dart';

class AgentTypeView extends ConsumerStatefulWidget {
  const AgentTypeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AgentTypeViewState();
}

class _AgentTypeViewState extends ConsumerState<AgentTypeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 16,
          children: [
            Text(
              'What type of agent are you?',
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(color: AppColors.white),
            ),
            SizedBox(height: 24),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/agent.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.4),
                      BlendMode.darken,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ref.read(onboardingProvider).agentType == AgentType.mobile
                          ? 'Travel to customers to collect their waste. Best for individuals with a bike, car, or truck who want to be on the move'
                          : 'Best for businesses or individuals with a physical location (e.g., shop, office, or home) where customers can drop off their waste',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              spacing: 8,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => ref
                        .read(onboardingProvider.notifier)
                        .setAgentType(AgentType.mobile),
                    child: QuickAction(
                      backgroundColor:
                          ref.watch(onboardingProvider).agentType ==
                              AgentType.mobile
                          ? Color(0xff0234b3)
                          : AppColors.cardDark,
                      icon: MingCuteIcons.mgc_bike_fill,
                      text: ' Mobile Agent',
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => ref
                        .read(onboardingProvider.notifier)
                        .setAgentType(AgentType.dropZone),
                    child: QuickAction(
                      backgroundColor:
                          ref.watch(onboardingProvider).agentType ==
                              AgentType.dropZone
                          ? Color(0xff008000)
                          : AppColors.cardDark,
                      icon: MingCuteIcons.mgc_map_pin_fill,
                      text: 'Drop Zone',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            AppButton(
              onPressed: ref.watch(onboardingProvider).agentType != null
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
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
