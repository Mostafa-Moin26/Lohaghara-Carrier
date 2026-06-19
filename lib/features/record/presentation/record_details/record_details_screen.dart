import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/widgets/action_buttons.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/widgets/row_item.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/widgets/section_card.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/widgets/total_card.dart';

class RecordDetailsScreen extends StatelessWidget {
  RecordDetailsScreen({super.key});

  // final controller = Get.put(RecordDetailController());
  final record = Get.arguments as RecordModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: const Text(AppTextStrings.recordDetails),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            /// TOTAL CARD
            TotalCard(record.totalAmount.toStringAsFixed(0)),

            const SizedBox(height: AppSizes.spaceBtwSections),

            /// TRIP INFO
            SectionCard(
              title: "Trip Info",
              children: [
                RowItem(
                  Iconsax.calendar,
                  "Date",
                  DateFormat('dd MMM yyyy').format(record.date),
                ),
                RowItem(Iconsax.building, "Company", record.companyName),
                RowItem(Iconsax.building_3, "Factory", record.factoryName),
                RowItem(Iconsax.truck, "Truck", record.truckNumber),
              ],
            ),

            /// CHARGES
            SectionCard(
              title: "Charges",
              children: [
                RowItem(Iconsax.money, "Fare", "৳ ${record.fare}"),
                RowItem(
                  Iconsax.add_circle,
                  "Load",
                  "৳ ${record.loadDemurrage}",
                ),
                RowItem(
                  Iconsax.minus_cirlce,
                  "Unload",
                  "৳ ${record.unloadDemurrage}",
                ),
              ],
            ),

            /// DETAILS
            SectionCard(
              title: "Details",
              children: [
                RowItem(Iconsax.location, "Unload Point", record.unloadPoint),
                RowItem(Iconsax.box, "Item", record.item),
                RowItem(Iconsax.note, "Remarks", record.remarks),
              ],
            ),

            /// META
            SectionCard(
              title: "Metadata",
              children: [
                RowItem(
                  Iconsax.clock,
                  "Created At",
                  DateFormat('dd MMM yyyy').format(record.createdAt),
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
    );
  }
}
