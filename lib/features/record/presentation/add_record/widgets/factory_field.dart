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
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return factories;
        }

        return factories.where(
          (factory) => factory.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ),
        );
      },

      onSelected: (value) {
        controller.text = value;

        if (onSelected != null) {
          onSelected!(value);
        }
      },

      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
            textEditingController.text = controller.text;

            textEditingController.selection = TextSelection.fromPosition(
              TextPosition(offset: textEditingController.text.length),
            );

            textEditingController.addListener(() {
              controller.text = textEditingController.text;
            });

            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              validator: (value) =>
                  AppValidator.validateEmptyText('Factory', value),
              decoration: const InputDecoration(
                hintText: 'Factory',
                prefixIcon: Icon(Iconsax.building_3),
              ),
            );
          },
    );
  }
}
