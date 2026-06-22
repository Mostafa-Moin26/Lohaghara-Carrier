import 'package:cloud_firestore/cloud_firestore.dart';

class BillingMonthModel {
  final String monthKey;

  final int billNo;

  final String billCode;

  final DateTime createdAt;

  const BillingMonthModel({
    required this.monthKey,
    required this.billNo,
    required this.billCode,
    required this.createdAt,
  });

  static BillingMonthModel empty() => BillingMonthModel(
    monthKey: '',
    billNo: 0,
    billCode: '',
    createdAt: DateTime.now(),
  );

  BillingMonthModel copyWith({
    String? monthKey,
    int? billNo,
    String? billCode,
    DateTime? createdAt,
  }) {
    return BillingMonthModel(
      monthKey: monthKey ?? this.monthKey,
      billNo: billNo ?? this.billNo,
      billCode: billCode ?? this.billCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MonthKey': monthKey,
      'BillNo': billNo,
      'BillCode': billCode,
      'CreatedAt': Timestamp.fromDate(createdAt),
    };
  }

  factory BillingMonthModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return BillingMonthModel(
        monthKey: data['MonthKey'] ?? '',
        billNo: data['BillNo'] ?? 0,
        billCode: data['BillCode'] ?? '',
        createdAt: (data['CreatedAt'] as Timestamp).toDate(),
      );
    }

    return BillingMonthModel.empty();
  }
}
