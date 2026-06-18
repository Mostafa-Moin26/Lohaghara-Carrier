import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CompanyField extends StatelessWidget {
  const CompanyField({
    super.key,
    required this.controller,
    required this.companies,
  });

  final TextEditingController controller;
  final List<String> companies;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      decoration: InputDecoration(
        hintText: 'Company',

        prefixIcon: const Icon(Iconsax.building),

        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_drop_down),

          onSelected: (value) {
            controller.text = value;
          },

          itemBuilder: (context) {
            return companies.map((company) {
              return PopupMenuItem(value: company, child: Text(company));
            }).toList();
          },
        ),
      ),
    );
  }
}
