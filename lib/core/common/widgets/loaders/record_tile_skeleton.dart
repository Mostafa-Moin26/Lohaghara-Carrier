import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/core/popups/shimmer/shimmer.dart';

class RecordTileSkeleton extends StatelessWidget {
  const RecordTileSkeleton({super.key});

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
        child: Row(
          children: [
            /// Truck Icon
            const ShimmerEffect(width: 56, height: 56, radius: 56),

            const SizedBox(width: AppSizes.md),

            /// Middle Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerEffect(width: 150, height: 18),

                  SizedBox(height: AppSizes.sm),

                  ShimmerEffect(width: 180, height: 14),
                ],
              ),
            ),

            const SizedBox(width: AppSizes.md),

            /// Amount & Date
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ShimmerEffect(width: 80, height: 18),

                SizedBox(height: AppSizes.sm),

                ShimmerEffect(width: 70, height: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
