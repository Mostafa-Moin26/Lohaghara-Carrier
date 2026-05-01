import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import '../controller/add_record_controller.dart';

class ItemBottomSheet extends StatelessWidget {
  final AddRecordController controller;

  const ItemBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? AppColors.darkerGrey : AppColors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: controller.itemOptions.map((item) {
          final isSelected = controller.itemController.text == item;

          return ListTile(
            leading: Icon(
              item == "Box"
                  ? Iconsax.box
                  : item == "Hanger"
                  ? Iconsax.shop
                  : Iconsax.box_add,
            ),
            title: Text(item),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: AppColors.primaryColor)
                : null,
            onTap: () {
              controller.itemController.text = item;
              Get.back();
            },
          );
        }).toList(),
      ),
    );
  }
}
