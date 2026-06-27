import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/core/popups/shimmer/shimmer.dart';

class FactoryCardSkeleton extends StatelessWidget {
  const FactoryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: dark ? AppColors.darkerGrey : AppColors.white,
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          boxShadow: [AppShadows.horizontalProductShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                const ShimmerEffect(width: 36, height: 36, radius: 10),

                const SizedBox(width: AppSizes.md),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerEffect(width: double.infinity, height: 16),

                      SizedBox(height: AppSizes.sm),

                      ShimmerEffect(width: 140, height: 12),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSizes.md),

            Divider(color: AppColors.grey.withValues(alpha: .25)),

            const SizedBox(height: AppSizes.md),

            /// Bottom Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    ShimmerEffect(width: 18, height: 18, radius: 20),
                    SizedBox(width: AppSizes.sm),
                    ShimmerEffect(width: 70, height: 16),
                  ],
                ),

                Row(
                  children: [
                    ShimmerEffect(width: 18, height: 18, radius: 20),
                    SizedBox(width: AppSizes.sm),
                    ShimmerEffect(width: 90, height: 16),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
