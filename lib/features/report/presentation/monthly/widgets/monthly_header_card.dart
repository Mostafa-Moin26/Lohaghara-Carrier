import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class MonthlyHeaderCard extends StatelessWidget {
  const MonthlyHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        boxShadow: [AppShadows.horizontalProductShadow],
      ),

      child: Row(
        children: [
          /// 🔹 Left Image
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Image.asset(
              AppImageStrings.factoryIcon,
              height: 50,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: AppSizes.md),

          /// 🔹 RIGHT SIDE
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TEXT CONTENT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Factory Name
                      Text(
                        "Meghna Knit Composite Ltd.",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: AppSizes.xs),

                      Text(
                        'March 2026',
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(height: AppSizes.xs),

                      /// BILL NO
                      RichText(
                        text: TextSpan(
                          text: "Bill No: ",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: "Lohagara-16",
                              style: TextStyle(
                                color: dark
                                    ? AppColors.primaryLight
                                    : AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
