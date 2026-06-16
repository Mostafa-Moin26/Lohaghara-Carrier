import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusMd),
          ),
        ),
        onPressed: () {},
        icon: const Icon(Iconsax.trash, color: Colors.red),
        label: const Text(
          "Delete Account",
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
