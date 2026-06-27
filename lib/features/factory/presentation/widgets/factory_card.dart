import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/styles/shadows.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/amount_price_text.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class FactoryCard extends StatelessWidget {
  const FactoryCard({
    super.key,
    required this.name,
    required this.companyName,
    required this.trips,
    required this.amount,
    this.onTap,
  });

  final String name;
  final String companyName;
  final int trips;
  final int amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          onTap: onTap,
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
                /// ---------- Header ----------
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: .08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Iconsax.buildings,
                        size: 18,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    const SizedBox(width: AppSizes.md),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            companyName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSizes.md),

                Divider(
                  height: 1,
                  color: AppColors.grey.withValues(alpha: .25),
                ),

                const SizedBox(height: AppSizes.md),

                /// ---------- Statistics ----------
                Row(
                  children: [
                    /// Trips
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Iconsax.truck_fast,
                            size: 18,
                            color: AppColors.primaryColor,
                          ),

                          const SizedBox(width: AppSizes.sm),

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '$trips ',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: dark
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                ),

                                TextSpan(
                                  text: 'Trips',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: AppColors.darkGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Amount
                    Row(
                      children: [
                        const Icon(
                          Iconsax.wallet_money,
                          size: 18,
                          color: Colors.green,
                        ),

                        const SizedBox(width: AppSizes.sm),

                        AmountPriceText(
                          price: amount.toString(),
                          isCurrency: true,
                          isLarge: true,
                          color: Colors.green,
                        ),
                      ],
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
