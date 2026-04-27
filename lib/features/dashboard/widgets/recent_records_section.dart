import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/dashboard/widgets/record_tile.dart';

class RecentRecordsSection extends StatelessWidget {
  const RecentRecordsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Show only 3 recent records
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, _) =>
              const SizedBox(height: AppSizes.spaceBtwItems),
          itemBuilder: (_, index) {
            return const RecordTile();
          },
        ),

        const SizedBox(height: AppSizes.spaceBtwItems),
      ],
    );
  }
}
