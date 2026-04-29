import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/widgets/records/record_tile.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';

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
            return const RecordTile(
              truckNumber: "DM TA-18-4209",
              companyName: "Meghna Knit Composite Ltd.",
              amount: '15,500',
              date: "Today",
            );
          },
        ),

        const SizedBox(height: AppSizes.spaceBtwItems),
      ],
    );
  }
}
