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

    /// Optional Trailing Widget
    this.trailingIcon,
    this.onTrailingTap,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  /// Optional Action Button
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;

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
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (_, _, _) {
          return TextField(
            controller: controller,
            onChanged: onChanged,

            onSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
            textInputAction: TextInputAction.search,

            decoration: InputDecoration(
              border: InputBorder.none,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.md,
              ),

              prefixIcon: const Icon(Iconsax.search_normal),

              hintText: hintText,

              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Calendar / Filter / Any Action Icon
                  if (trailingIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: onTrailingTap,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(
                                alpha: .08,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              trailingIcon,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),

                  /// Clear Button
                  if (controller.text.isNotEmpty)
                    IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        controller.clear();
                        onChanged?.call('');
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
