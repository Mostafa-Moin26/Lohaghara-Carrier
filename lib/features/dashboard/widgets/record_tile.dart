import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/amount_price_text.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class RecordTile extends StatelessWidget {
  const RecordTile({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        boxShadow: [AppShadows.horizontalProductShadow],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.truck_fast,
              color: Colors.blue,
              size: AppSizes.iconMd,
            ),
          ),

          const SizedBox(width: AppSizes.spaceBtwItems),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Truck No.
                Text(
                  "DM TA-18-4209",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSizes.xs),

                /// Company Name
                Text(
                  "Meghna Knit Composite Ltd.",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// Amount
              AmountPriceText(
                price: '15,500',
                isCurrency: true,
                color: Colors.green,
              ),

              SizedBox(height: AppSizes.xs),
              Text(
                "Today",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
