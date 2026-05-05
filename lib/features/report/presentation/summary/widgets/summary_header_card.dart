import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/image_strings.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class SummaryHeaderCard extends StatelessWidget {
  const SummaryHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: dark
            ? AppColors.primaryLight.withValues(alpha: 0.2)
            : AppColors.primaryLight.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        // boxShadow: [AppShadows.horizontalProductShadow],
      ),

      child: Row(
        children: [
          /// 🔹 LEFT SIDE
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TEXT CONTENT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// SUMMARY TEXT
                      Text(
                        "Summary: Jan 2026 - Mar 2026",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: dark
                              ? AppColors.primaryLight
                              : AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: AppSizes.xs),

                      /// COMPANY NAME
                      Text(
                        "Meghna Executive Holding",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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

          /// 🔹 RIGHT IMAGE
          Image.asset(AppImageStrings.reportIcon, height: 70),
        ],
      ),
    );
  }
}
