import 'package:get/get.dart';

class FactoryController extends GetxController {
  final factories = [
    {"name": "Meghna Knit Composite Ltd.", "trips": 47, "amount": 716500},
    {"name": "Sublime Greentex Ltd.", "trips": 25, "amount": 418500},
    {"name": "Executive Greentex Ltd.", "trips": 18, "amount": 260500},
  ].obs;

  /// (Optional) search later
  final searchText = ''.obs;
}
