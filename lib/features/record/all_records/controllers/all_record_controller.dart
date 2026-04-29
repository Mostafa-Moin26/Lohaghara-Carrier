import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/constants/enums.dart';

class AllRecordController extends GetxController {
  Rx<RecordFilterType> selectedFilter = RecordFilterType.all.obs;

  void updateFilter(RecordFilterType filter) {
    selectedFilter.value = filter;
  }
}
