import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/device/device_utility.dart';
import 'package:lohaghara_carrier/core/helpers/helper_functions.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.controller,
    this.hintText = 'Search...',
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return Container(
      width: DeviceUtils.getScreenWidth(context),
      decoration: BoxDecoration(
        color: dark ? AppColors.dark : AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
        border: Border.all(color: AppColors.grey.withValues(alpha: .3)),
      ),
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (_, _, _) {
          return TextField(
            controller: controller,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,

            decoration: InputDecoration(
              border: InputBorder.none,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.md,
              ),

              prefixIcon: const Icon(Iconsax.search_normal),

              hintText: hintText,

              suffixIcon: controller.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        controller.clear();

                        onChanged?.call('');
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
            ),
          );
        },
      ),
    );
  }
}
