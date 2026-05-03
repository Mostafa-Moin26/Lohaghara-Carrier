import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/core/constants/text_strings.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ActionButtons({
    super.key,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onDelete,
            icon: const Icon(Iconsax.trash, color: Colors.red),
            label: const Text(AppTextStrings.delete),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.red),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.md),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Iconsax.edit),
            label: const Text(AppTextStrings.edit),
          ),
        ),
      ],
    );
  }
}
