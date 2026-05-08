import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.type,
    required this.title,
    required this.date,
    required this.billNo,
    required this.amount,
    required this.trucks,
    required this.time,
  });

  final String type;
  final String title;
  final String date;
  final String billNo;
  final String amount;
  final String trucks;
  final String time;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
        boxShadow: [AppShadows.horizontalProductShadow],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        type,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSizes.xs),

                    /// Title
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// Date + Bill
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: AppSizes.sm,
                      runSpacing: 4,
                      children: [
                        /// Date
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Iconsax.calendar, size: AppSizes.iconSm),

                            const SizedBox(width: 5),

                            Text(
                              date,
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                        /// Divider
                        Text(
                          '|',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),

                        /// Bill No
                        Text(
                          '${AppTextStrings.billNo}$billNo',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// Right side
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(time, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(width: AppSizes.sm),
                  const Icon(Icons.more_vert, color: Colors.grey),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppSizes.sm),

          /// Divider
          const Divider(),

          const SizedBox(height: AppSizes.sm),

          /// 🔹 Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Amount
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.sm),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Iconsax.money, color: Colors.green),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '৳$amount',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppTextStrings.totalAmount,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),

              /// Trucks
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.sm),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Iconsax.truck,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trucks,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppTextStrings.totalTrucks,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// 🔹 Actions
          Row(
            children: [
              _ActionButton(icon: Iconsax.eye, label: "View"),
              const SizedBox(width: 8),
              _ActionButton(icon: Iconsax.document_download, label: "Download"),
              const SizedBox(width: 8),
              _ActionButton(icon: Iconsax.share, label: "Share"),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔥 Reusable Action Button
class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: dark
              ? AppColors.grey.withValues(alpha: 0.1)
              : AppColors.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppSizes.iconSm,
              color: dark ? Colors.grey : AppColors.primaryDark,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: dark ? Colors.grey : AppColors.primaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
