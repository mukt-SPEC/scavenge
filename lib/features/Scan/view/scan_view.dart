import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:scavenge/Theme/app_colors.dart';
import 'package:scavenge/features/Scan/widget/control_button.dart';


class ScanView extends ConsumerStatefulWidget {
  const ScanView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScanViewState();
}

class _ScanViewState extends ConsumerState<ScanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,

      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 72, 0, 16),
        child: Column(
          spacing: 16,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff7a7a7a),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffb9b9b9),
                    ),
                  ),
                  ControlButton(width: 72, child: MingCute.camera_2_fill),

                  ControlButton(child: MingCute.settings_4_fill),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
