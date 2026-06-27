import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/widgets/loaders/record_tile_skeleton.dart';

class RecordListSkeleton extends StatelessWidget {
  const RecordListSkeleton({super.key, this.itemCount = 8});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, _) => const RecordTileSkeleton(),
    );
  }
}
