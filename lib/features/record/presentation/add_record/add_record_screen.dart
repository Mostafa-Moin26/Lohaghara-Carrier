import 'package:flutter/material.dart';
import 'package:lohaghara_carrier/core/common/styles/spacing_styles.dart';
import 'package:lohaghara_carrier/core/common/widgets/appbar/appbar.dart';
import 'package:lohaghara_carrier/core/constants/sizes.dart';
import 'package:lohaghara_carrier/features/record/presentation/add_record/widgets/add_record_form.dart';

class AddRecordScreen extends StatelessWidget {
  const AddRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackArrow: true, title: Text('Add Record')),

      body: SafeArea(
        child: Padding(
          padding: AppSpacingStyles.paddingWithAppBarHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: AppSizes.md),

                /// Add Record Form
                AddRecordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
