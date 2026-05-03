import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/common/widgets/containers/search_container.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/factory/presentation/controller/factory_controller.dart';
import 'package:lohaghara_carrier/features/factory/presentation/widgets/factory_card.dart';

class FactoryView extends StatelessWidget {
  FactoryView({super.key});

  final controller = Get.put(FactoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text('Factories'), showBackArrow: true),

      body: Column(
        children: [
          /// Search
          Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: SearchContainer(
              text: 'Search factory name...',
              padding: EdgeInsets.zero,
            ),
          ),

          /// List
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                ),
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
    );
  }
}
