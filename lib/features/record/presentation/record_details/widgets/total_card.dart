import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/texts/amount_price_text.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';

class TotalCard extends StatelessWidget {
  final String total;

  const TotalCard(this.total, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        color: AppColors.primaryColor.withValues(alpha: 0.15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTextStrings.totalAmount,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSizes.sm),
              AmountPriceText(price: total, isCurrency: true, isLarge: true),
            ],
          ),
          const Icon(Iconsax.receipt_item),
        ],
      ),
    );
  }
}
