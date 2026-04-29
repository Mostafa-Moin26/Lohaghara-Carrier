import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/amount_price_text.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class RecordTile extends StatelessWidget {
  const RecordTile({
    super.key,
    required this.truckNumber,
    required this.companyName,
    required this.amount,
    required this.date,
  });

  final String truckNumber;
  final String companyName;
  final String amount;
  final String date;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final screenWidth = AppHelperFunctions.screenWidth();

    final double companyFontSize = screenWidth < 360 ? 11.0 : 12.0;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
      ),
      child: Row(
        children: [
          /// Leading icon
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

          /// Middle section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Truck Number
                Text(
                  truckNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: AppSizes.xs),

                /// Company Name
                Text(
                  companyName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontSize: companyFontSize),
                ),
              ],
            ),
          ),

          const SizedBox(width: AppSizes.sm),

          /// Trailing section
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// Amount
              FittedBox(
                fit: BoxFit.scaleDown,
                child: AmountPriceText(
                  price: amount,
                  isCurrency: true,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: AppSizes.xs),

              Text(
                date,
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
