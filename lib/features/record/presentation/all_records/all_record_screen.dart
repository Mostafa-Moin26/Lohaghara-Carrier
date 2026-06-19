import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/chips/app_filter_chip.dart';
import 'package:lohaghara_carrier/core/common/widgets/containers/search_container.dart';
import 'package:lohaghara_carrier/core/common/widgets/records/record_tile.dart';
import 'package:lohaghara_carrier/core/constants/colors.dart';
import 'package:lohaghara_carrier/core/constants/enums.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';
import 'package:lohaghara_carrier/core/extensions/filter_type_extension.dart';
import 'package:lohaghara_carrier/features/record/presentation/all_records/controllers/all_record_controller.dart';
import 'package:lohaghara_carrier/routes/app_routes.dart';

class AllRecord extends StatelessWidget {
  const AllRecord({super.key, required this.showBackArrow});

  final bool showBackArrow;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllRecordController());

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: showBackArrow,
        title: Text(AppTextStrings.allRecords),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.addRecord),

        backgroundColor: AppColors.primaryColor,

        elevation: 2,

        icon: const Icon(Iconsax.add, color: Colors.white),

        label: const Text(
          AppTextStrings.addRecord,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),

        child: Column(
          children: [
            const SizedBox(height: AppSizes.spaceBtwItems),

            /// Search Placeholder
            SearchContainer(
              text: 'Search records...',
              padding: const EdgeInsets.all(0),
              onTap: () {
                /// TODO:
                /// Search screen later
              },
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),

            /// Filters
            Obx(
              () => SizedBox(
                height: 40,

                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    children: controller.filters.map((filter) {
                      final selected =
                          controller.selectedFilter.value == filter;

                      return AppFilterChip(
                        title: filter == RecordFilterType.customDate
                            ? ''
                            : filter.title,

                        isSelected: selected,

                        onTap: () => controller.updateFilter(filter),

                        icon: filter == RecordFilterType.customDate
                            ? Iconsax.calendar
                            : null,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.lg),

            /// Records
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.filteredRecords.isEmpty) {
                  return const Center(child: Text('No records found'));
                }

                return RefreshIndicator(
                  onRefresh: controller.refreshRecords,

                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),

                    itemCount: controller.filteredRecords.length,

                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSizes.spaceBtwItems),

                    itemBuilder: (context, index) {
                      final record = controller.filteredRecords[index];

                      return RecordTile(
                        truckNumber: record.truckNumber,

                        companyName: record.companyName,

                        amount: record.totalAmount.toStringAsFixed(0),

                        date: DateFormat('dd MMM yyyy').format(record.date),

                        onTap: () {
                          Get.toNamed(
                            AppRoutes.recordDetail,
                            arguments: record,
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
