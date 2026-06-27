import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/widgets/loaders/factory_card_skeleton.dart';

class FactoryListSkeleton extends StatelessWidget {
  const FactoryListSkeleton({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, _) => const FactoryCardSkeleton(),
    );
  }
}
