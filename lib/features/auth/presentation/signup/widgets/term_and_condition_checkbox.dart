import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/text_strings.dart';
import '../../../../core/helpers/helper_functions.dart';

class TermsAndConditionCheckbox extends StatelessWidget {
  const TermsAndConditionCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(child: Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(height: AppSizes.spaceBtwItems),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${AppTextStrings.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: '${AppTextStrings.privacyPolicy} ',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? AppColors.white : AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: dark
                        ? AppColors.white
                        : AppColors.primaryColor,
                  ),
                ),
                TextSpan(
                  text: '${AppTextStrings.and} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: AppTextStrings.termsOfUse,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? AppColors.white : AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: dark
                        ? AppColors.white
                        : AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
