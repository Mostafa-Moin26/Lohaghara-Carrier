import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/dashboard/widgets/action_card.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            QuickActionCard(
              title: AppTextStrings.addRecord,
              icon: Iconsax.add,
              color: Colors.purpleAccent,
            ),
            const SizedBox(width: AppSizes.sm),
            QuickActionCard(
              title: AppTextStrings.allRecords,
              icon: Iconsax.document_text,
              color: Colors.blue,
            ),
            const SizedBox(width: AppSizes.sm),
            QuickActionCard(
              title: AppTextStrings.monthlyBill,
              icon: Iconsax.receipt_text,
              color: Colors.red,
            ),
            const SizedBox(width: AppSizes.sm),
            QuickActionCard(
              title: AppTextStrings.summary,
              icon: Iconsax.chart_2,
              color: Colors.green,
            ),
          ],
        ),
      ],
    );
  }
}
