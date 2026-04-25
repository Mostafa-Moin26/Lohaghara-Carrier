import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => OnBoardingController.instance.nextPage(),
      style: ElevatedButton.styleFrom(shape: CircleBorder()),
      child: const Icon(Iconsax.arrow_right_3),
    );
  }
}
