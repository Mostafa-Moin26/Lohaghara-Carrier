import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/containers/temporary_search.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/factory/presentation/controller/factory_controller.dart';
import 'package:lohaghara_carrier/features/factory/presentation/widgets/factory_card.dart';

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
            TSearchContainer(
              text: 'Search factory name...',
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            /// List
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.factories.length,
                  itemBuilder: (_, index) {
                    final factory = controller.factories[index];

                    return FactoryCard(
                      name: factory["name"] as String,
                      trips: factory["trips"] as int,
                      amount: factory["amount"] as int,
                      onTap: () {
                        // TODO: navigate later
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
