import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/common/app_button.dart';

class PreferredWaste extends ConsumerStatefulWidget {
  const PreferredWaste({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PreferredWasteState();
}

class _PreferredWasteState extends ConsumerState<PreferredWaste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            children: [
              Text(
                'What do you mostly prefer to Recycle',

                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(color: AppColors.white),
              ),
              Spacer(),
              AppButton(onPressed: () {}, buttonText: 'Stat recycling'),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
