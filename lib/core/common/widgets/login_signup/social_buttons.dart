import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final bool dark = AppHelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google icon
        Container(
          width: 100,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: dark ? AppColors.darkerGrey : AppColors.white,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              height: AppSizes.iconLg,
              width: AppSizes.iconLg,
              image: AssetImage(AppImageStrings.google),
            ),
          ),
        ),

        const SizedBox(width: AppSizes.spaceBtwItems),

        // facebook icon
        Container(
          width: 100,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: dark ? AppColors.darkerGrey : AppColors.white,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              height: AppSizes.iconLg,
              width: AppSizes.iconLg,
              image: AssetImage(AppImageStrings.facebook),
            ),
          ),
        ),
      ],
    );
  }
}
