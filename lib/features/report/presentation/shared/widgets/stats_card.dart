import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';
import 'package:lohaghara_carrier/features/report/presentation/shared/widgets/stat_item.dart';

class ReportStatsCard extends StatelessWidget {
  const ReportStatsCard({
    super.key,
    required this.numOfTrucks,
    required this.totalAmount,
  });

  final String numOfTrucks, totalAmount;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        boxShadow: [AppShadows.horizontalProductShadow],
      ),

      child: Row(
        children: [
          /// LEFT - TOTAL TRUCKS
          Expanded(
            child: StatItem(
              icon: Iconsax.truck_fast,
              iconColor: AppColors.primaryColor,
              title: numOfTrucks,
              subtitle: "Trucks",
            ),
          ),

          /// DIVIDER
          Container(height: 40, width: 1, color: Colors.grey.shade300),

          const SizedBox(width: AppSizes.md),

          /// RIGHT - TOTAL AMOUNT
          Expanded(
            child: StatItem(
              icon: Iconsax.wallet_money,
              iconColor: Colors.green,
              title: totalAmount,
              subtitle: "Taka",
              isAmount: true,
            ),
          ),
        ],
      ),
    );
  }
}
