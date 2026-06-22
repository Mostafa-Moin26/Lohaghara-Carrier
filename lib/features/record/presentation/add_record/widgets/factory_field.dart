import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lohaghara_carrier/core/validators/validators.dart';

class FactoryField extends StatelessWidget {
  const FactoryField({
    super.key,
    required this.controller,
    required this.factories,
    this.onSelected,
  });

  final TextEditingController controller;
  final List<String> factories;
  final Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => AppValidator.validateEmptyText('Factory', value),
      decoration: InputDecoration(
        hintText: 'Factory',

        prefixIcon: const Icon(Iconsax.building_3),

        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_drop_down),

          onSelected: (value) {
            controller.text = value;

            if (onSelected != null) {
              onSelected!(value);
            }
          },

          itemBuilder: (context) {
            return factories.map((company) {
              return PopupMenuItem(value: company, child: Text(company));
            }).toList();
          },
        ),
      ),
    );
  }
}
