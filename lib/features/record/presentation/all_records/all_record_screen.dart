import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
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
  const AllRecord({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllRecordController());
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(AppTextStrings.allRecords),
      ),

      /// Add Record Button
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.addRecord);
        },

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

            /// Search Bar
            SearchContainer(
              text: 'Search by truck number...',
              padding: const EdgeInsets.all(0),
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),

            /// Filter Section
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

            // /// Filter Section
            // Obx(
            //   () => SizedBox(
            //     height: 45,
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       children: [
            //         RecordFilterChip(
            //           title: AppTextStrings.all,
            //           isSelected:
            //               controller.selectedFilter.value ==
            //               RecordFilterType.all,
            //           onTap: () {
            //             controller.updateFilter(RecordFilterType.all);
            //           },
            //         ),

            //         RecordFilterChip(
            //           title: AppTextStrings.today,
            //           isSelected:
            //               controller.selectedFilter.value ==
            //               RecordFilterType.today,
            //           onTap: () {
            //             controller.updateFilter(RecordFilterType.today);
            //           },
            //         ),

            //         RecordFilterChip(
            //           title: AppTextStrings.thisWeek,
            //           isSelected:
            //               controller.selectedFilter.value ==
            //               RecordFilterType.thisWeek,
            //           onTap: () {
            //             controller.updateFilter(RecordFilterType.thisWeek);
            //           },
            //         ),

            //         RecordFilterChip(
            //           title: AppTextStrings.thisMonth,
            //           isSelected:
            //               controller.selectedFilter.value ==
            //               RecordFilterType.thisMonth,
            //           onTap: () {
            //             controller.updateFilter(RecordFilterType.thisMonth);
            //           },
            //         ),
            //         const SizedBox(width: AppSizes.sm),
            //         CalendarContainer(
            //           isSelected:
            //               controller.selectedFilter.value ==
            //               RecordFilterType.customDate,
            //           onTap: () {
            //             controller.updateFilter(RecordFilterType.customDate);
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: AppSizes.lg),

            /// Records List
            Expanded(
              child: ListView.separated(
                itemCount: 15,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSizes.spaceBtwItems),
                itemBuilder: (context, index) {
                  return RecordTile(
                    truckNumber: 'DM TA-18-4209',
                    companyName: 'Meghna Knit Composite Ltd.',
                    amount: '15,500',
                    date: 'Today',
                    onTap: () => Get.toNamed(AppRoutes.recordDetail),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
