import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/controller/record_details_controller.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/widgets/action_buttons.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/widgets/row_item.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/widgets/section_card.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/widgets/total_card.dart';

class RecordDetailsScreen extends StatelessWidget {
  RecordDetailsScreen({super.key});

  final controller = Get.put(RecordDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: const Text(AppTextStrings.recordDetails),
        actions: [IconButton(icon: const Icon(Iconsax.edit), onPressed: () {})],
      ),

      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              /// TOTAL CARD
              TotalCard(controller.record["total"] as int),

              const SizedBox(height: AppSizes.spaceBtwSections),

              /// TRIP INFO
              SectionCard(
                title: "Trip Info",
                children: [
                  RowItem(
                    Iconsax.calendar,
                    "Date",
                    controller.record["date"] as String,
                  ),
                  RowItem(
                    Iconsax.building_3,
                    "Factory",
                    controller.record["factory"] as String,
                  ),
                  RowItem(
                    Iconsax.truck,
                    "Truck",
                    controller.record["truck"] as String,
                  ),
                ],
              ),

              /// CHARGES
              SectionCard(
                title: "Charges",
                children: [
                  RowItem(
                    Iconsax.money,
                    "Fare",
                    "৳ ${controller.record["fare"]}",
                  ),
                  RowItem(
                    Iconsax.add_circle,
                    "Load",
                    "৳ ${controller.record["load"]}",
                  ),
                  RowItem(
                    Iconsax.minus_cirlce,
                    "Unload",
                    "৳ ${controller.record["unload"]}",
                  ),
                ],
              ),

              /// DETAILS
              SectionCard(
                title: "Details",
                children: [
                  RowItem(
                    Iconsax.location,
                    "Unload Point",
                    controller.record["unloadPoint"] as String,
                  ),
                  RowItem(
                    Iconsax.box,
                    "Item",
                    controller.record["item"] as String,
                  ),
                  RowItem(
                    Iconsax.note,
                    "Remarks",
                    controller.record["remarks"] as String,
                  ),
                ],
              ),

              /// META
              SectionCard(
                title: "Metadata",
                children: [
                  RowItem(
                    Iconsax.clock,
                    "Created At",
                    controller.record["createdAt"] as String,
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              /// ACTION BUTTONS
              ActionButtons(onDelete: () {}, onEdit: () {}),
              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
