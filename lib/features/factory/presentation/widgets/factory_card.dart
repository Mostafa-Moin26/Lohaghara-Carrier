import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/amount_price_text.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class FactoryCard extends StatelessWidget {
  final String name;
  final int trips;
  final int amount;
  final VoidCallback? onTap;

  const FactoryCard({
    super.key,
    required this.name,
    required this.trips,
    required this.amount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          child: Ink(
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: dark ? AppColors.darkerGrey : AppColors.white,
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
              boxShadow: [AppShadows.horizontalProductShadow],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Factory Name
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: AppSizes.spaceBtwItems),

                /// Stats Row
                Row(
                  children: [
                    /// Trips
                    Expanded(
                      child: _StatColumn(title: "Total Trips", value: "$trips"),
                    ),

                    /// Amount
                    Expanded(
                      child: _StatColumn(
                        title: "Total Amount",
                        valueWidget: AmountPriceText(
                          price: amount.toString(),
                          isCurrency: true,
                          isLarge: true,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;

  const _StatColumn({required this.title, this.value, this.valueWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: AppSizes.xs),
        valueWidget ??
            Text(value ?? '', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
