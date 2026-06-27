import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/containers/search_container.dart';
import 'package:lohaghara_carrier/core/common/widgets/loaders/factory_list_skeleton.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/factory/presentation/controller/factory_controller.dart';
import 'package:lohaghara_carrier/features/factory/presentation/widgets/factory_card.dart';
import 'package:lohaghara_carrier/features/factory/presentation/widgets/factory_header_info.dart';

class FactoryView extends StatelessWidget {
  FactoryView({super.key, required this.showBackArrow});

  final controller = Get.put(FactoryController());
  final bool showBackArrow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Factories'),
        showBackArrow: showBackArrow,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.sm),

            /// Search
            SearchContainer(
              controller: controller.searchController,
              hintText: 'Search factory...',
              onChanged: controller.onSearchChanged,

              trailingIcon: Iconsax.calendar_1,

              onTrailingTap: () {
                controller.pickMonth(context);
              },
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            FactoryHeaderInfo(),
            const SizedBox(height: AppSizes.spaceBtwItems),

            /// List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const FactoryListSkeleton();
                }

                if (controller.filteredFactories.isEmpty) {
                  return const Center(child: Text('No factories found'));
                }

                return RefreshIndicator(
                  onRefresh: controller.refreshFactories,

                  child: ListView.builder(
                    itemCount: controller.filteredFactories.length,
                    itemBuilder: (_, index) {
                      final factory = controller.filteredFactories[index];

                      return FactoryCard(
                        name: factory.factoryName,
                        companyName: factory.companyName,
                        trips: factory.totalTrips,
                        amount: factory.totalAmount.toInt(),
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
