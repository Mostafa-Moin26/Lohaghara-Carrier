import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/widgets/action_card.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

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
              onPressed: () => Get.toNamed(AppRoutes.addRecord),
            ),
            const SizedBox(width: AppSizes.sm),

            QuickActionCard(
              title: AppTextStrings.allRecords,
              icon: Iconsax.document_text,
              color: Colors.blue,
              onPressed: () => Get.toNamed(AppRoutes.allRecords),
            ),
            const SizedBox(width: AppSizes.sm),
            QuickActionCard(
              title: AppTextStrings.monthlyBill,
              icon: Iconsax.receipt_text,
              color: Colors.red,
              onPressed: () {},
            ),
            const SizedBox(width: AppSizes.sm),
            QuickActionCard(
              title: AppTextStrings.summary,
              icon: Iconsax.chart_2,
              color: Colors.green,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
