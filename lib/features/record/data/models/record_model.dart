import 'package:cloud_firestore/cloud_firestore.dart';

class RecordModel {
  final String id;

  final DateTime date;

  final String companyId;
  final String companyName;

  final String factoryId;
  final String factoryName;

  final String truckNumber;

  final double fare;
  final double loadDemurrage;
  final double unloadDemurrage;
  final double totalAmount;

  final String unloadPoint;
  final String item;
  final String remarks;

  final String createdBy;

  final DateTime createdAt;
  final DateTime updatedAt;

  const RecordModel({
    required this.id,
    required this.date,
    required this.companyId,
    required this.companyName,
    required this.factoryId,
    required this.factoryName,
    required this.truckNumber,
    required this.fare,
    required this.loadDemurrage,
    required this.unloadDemurrage,
    required this.totalAmount,
    required this.unloadPoint,
    required this.item,
    required this.remarks,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Empty Record
  static RecordModel empty() => RecordModel(
    id: '',
    date: DateTime.now(),
    companyId: '',
    companyName: '',
    factoryId: '',
    factoryName: '',
    truckNumber: '',
    fare: 0,
    loadDemurrage: 0,
    unloadDemurrage: 0,
    totalAmount: 0,
    unloadPoint: '',
    item: '',
    remarks: '',
    createdBy: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  /// Convert model to Firestore JSON
  Map<String, dynamic> toJson() {
    return {
      'Date': Timestamp.fromDate(date),

      'CompanyId': companyId,
      'CompanyName': companyName,

      'FactoryId': factoryId,
      'FactoryName': factoryName,

      'TruckNumber': truckNumber,

      'Fare': fare,
      'LoadDemurrage': loadDemurrage,
      'UnloadDemurrage': unloadDemurrage,
      'TotalAmount': totalAmount,

      'UnloadPoint': unloadPoint,
      'Item': item,
      'Remarks': remarks,

      'CreatedBy': createdBy,
      'CreatedAt': Timestamp.fromDate(createdAt),
      'UpdatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  /// Create Record from Firestore Snapshot
  factory RecordModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return RecordModel(
        id: document.id,

        date: (data['Date'] as Timestamp).toDate(),

        companyId: data['CompanyId'] ?? '',
        companyName: data['CompanyName'] ?? '',

        factoryId: data['FactoryId'] ?? '',
        factoryName: data['FactoryName'] ?? '',

        truckNumber: data['TruckNumber'] ?? '',

        fare: (data['Fare'] ?? 0).toDouble(),
        loadDemurrage: (data['LoadDemurrage'] ?? 0).toDouble(),
        unloadDemurrage: (data['UnloadDemurrage'] ?? 0).toDouble(),
        totalAmount: (data['TotalAmount'] ?? 0).toDouble(),

        unloadPoint: data['UnloadPoint'] ?? '',
        item: data['Item'] ?? '',
        remarks: data['Remarks'] ?? '',

        createdBy: data['CreatedBy'] ?? '',

        createdAt: (data['CreatedAt'] as Timestamp).toDate(),
        updatedAt: (data['UpdatedAt'] as Timestamp).toDate(),
      );
    }

    return RecordModel.empty();
  }
}
