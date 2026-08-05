import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/features/report/presentation/history/widgets/confirmation_dialog.dart';

import '../../../data/models/report_model.dart';
import '../../../services/report_history_pdf_service.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.report, required this.onDelete});

  final ReportModel report;

  final VoidCallback onDelete;

  String _timeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) return 'Yesterday';

      return '${difference.inDays} days ago';
    }

    if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    }

    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    }

    return 'Today';
  }

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
                        report.reportType == 'monthly'
                            ? 'Monthly Report'
                            : 'Summary Report',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSizes.xs),

                    /// Title
                    Text(
                      report.factoryName ?? report.companyName,
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
                              DateFormat('MMM yyyy').format(report.month),
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
                          '${AppTextStrings.billNo}${report.billNo}',
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
                  Text(
                    _timeAgo(report.updatedAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

                  const SizedBox(width: AppSizes.sm),

                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      ConfirmationDialog.show(
                        title: 'Delete Report',
                        message:
                            'Are you sure you want to delete this report?\n\n'
                            'This action cannot be undone.',
                        confirmText: 'Delete',
                        cancelText: 'Cancel',
                        confirmColor: Colors.red,
                        onConfirm: onDelete,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: AppSizes.iconMd,
                      ),
                    ),
                  ),
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
                        '৳${report.totalAmount.toStringAsFixed(0)}',
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
                        report.totalTrips.toString(),
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
              _ActionButton(
                icon: Iconsax.eye,
                label: 'View',
                onTap: () async {
                  await ReportHistoryPdfService.preview(report);
                },
              ),
              const SizedBox(width: 8),
              _ActionButton(
                icon: Iconsax.document_download,
                label: 'Download',
                onTap: () async {
                  await ReportHistoryPdfService.download(report);
                },
              ),
              const SizedBox(width: 8),
              _ActionButton(
                icon: Iconsax.share,
                label: 'Share',
                onTap: () async {
                  await ReportHistoryPdfService.share(report);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔥 Reusable Action Button
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Ink(
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
