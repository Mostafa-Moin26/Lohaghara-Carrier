import 'package:flutter/material.dart';

import '../../../core/constants/text_strings.dart';
import '../controllers/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => OnBoardingController.instance.skipPage(),
      child: const Text(AppTextStrings.skip),
    );
  }
}
