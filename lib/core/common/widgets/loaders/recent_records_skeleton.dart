import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/popups/shimmer/shimmer.dart';

class RecentRecordsSkeleton extends StatelessWidget {
  const RecentRecordsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, _) =>
          const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (_, _) => const _RecordTileSkeleton(),
    );
  }
}

class _RecordTileSkeleton extends StatelessWidget {
  const _RecordTileSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
      ),
      child: Row(
        children: [
          /// Leading Circle
          const ShimmerEffect(width: 48, height: 48, radius: 24),

          const SizedBox(width: AppSizes.md),

          /// Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerEffect(width: 140, height: 16),

                SizedBox(height: 10),

                ShimmerEffect(width: 90, height: 14),
              ],
            ),
          ),

          const SizedBox(width: AppSizes.md),

          /// Amount
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ShimmerEffect(width: 70, height: 18),

              SizedBox(height: 10),

              ShimmerEffect(width: 55, height: 14),
            ],
          ),
        ],
      ),
    );
  }
}
