import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class AmountPriceText extends StatelessWidget {
  const AmountPriceText({
    super.key,
    this.currencySign = '৳',
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
    this.isCurrency = false,
    this.color,
  });

  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;
  final bool isCurrency;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Text(
      isCurrency ? currencySign + price : price,
      style: isLarge
          ? Theme.of(context).textTheme.headlineSmall!.copyWith(
              color:
                  color ??
                  (dark ? AppColors.primaryLight : AppColors.primaryDark),
              decoration: lineThrough ? TextDecoration.lineThrough : null,
            )
          : Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: AppSizes.fontMd,
              color:
                  color ??
                  (dark ? AppColors.primaryLight : AppColors.primaryDark),
              decoration: lineThrough ? TextDecoration.lineThrough : null,
            ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
