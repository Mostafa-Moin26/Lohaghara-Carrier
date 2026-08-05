class MonthlyBillRecordModel {
  final DateTime date;

  final String truckNumber;

  final double fare;

  final double loadDemurrage;

  final double unloadDemurrage;

  final double totalAmount;

  final String unloadPoint;

  final String item;

  final String remarks;

  const MonthlyBillRecordModel({
    required this.date,
    required this.truckNumber,
    required this.fare,
    required this.loadDemurrage,
    required this.unloadDemurrage,
    required this.totalAmount,
    required this.unloadPoint,
    required this.item,
    required this.remarks,
  });

  static MonthlyBillRecordModel empty() {
    return MonthlyBillRecordModel(
      date: DateTime.now(),
      truckNumber: '',
      fare: 0,
      loadDemurrage: 0,
      unloadDemurrage: 0,
      totalAmount: 0,
      unloadPoint: '',
      item: '',
      remarks: '',
    );
  }

  MonthlyBillRecordModel copyWith({
    DateTime? date,
    String? truckNumber,
    double? fare,
    double? loadDemurrage,
    double? unloadDemurrage,
    double? totalAmount,
    String? unloadPoint,
    String? item,
    String? remarks,
  }) {
    return MonthlyBillRecordModel(
      date: date ?? this.date,
      truckNumber: truckNumber ?? this.truckNumber,
      fare: fare ?? this.fare,
      loadDemurrage: loadDemurrage ?? this.loadDemurrage,
      unloadDemurrage: unloadDemurrage ?? this.unloadDemurrage,
      totalAmount: totalAmount ?? this.totalAmount,
      unloadPoint: unloadPoint ?? this.unloadPoint,
      item: item ?? this.item,
      remarks: remarks ?? this.remarks,
    );
  }
}
