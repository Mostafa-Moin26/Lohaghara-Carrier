import 'package:lohaghara_carrier/core/constants/enums.dart';

/// ================= RECORD FILTER =================

extension RecordFilterTypeExtension on RecordFilterType {
  String get title {
    switch (this) {
      case RecordFilterType.all:
        return 'All';

      case RecordFilterType.today:
        return 'Today';

      case RecordFilterType.thisWeek:
        return 'This Week';

      case RecordFilterType.thisMonth:
        return 'This Month';

      case RecordFilterType.customDate:
        return 'Custom Date';
    }
  }
}

/// ================= REPORT FILTER =================

extension ReportFilterTypeExtension on ReportFilterType {
  String get title {
    switch (this) {
      case ReportFilterType.all:
        return 'All';

      case ReportFilterType.monthly:
        return 'Monthly';

      case ReportFilterType.summary:
        return 'Summary';

      case ReportFilterType.thisMonth:
        return 'This Month';

      case ReportFilterType.lastThreeMonths:
        return 'Last 3 Months';
    }
  }
}
