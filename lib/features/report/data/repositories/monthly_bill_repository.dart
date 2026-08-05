import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_monthly_model.dart';
import 'package:lohaghara_carrier/features/report/data/models/monthy_bill_record_model.dart';

class MonthlyBillRepository {
  static MonthlyBillRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<FactoryMonthlyModel> fetchFactoryMonthly({
    required String factoryId,
    required String monthKey,
  }) async {
    try {
      final snapshot = await _db
          .collection('FactoryMonthly')
          .where('FactoryId', isEqualTo: factoryId)
          .where('MonthKey', isEqualTo: monthKey)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return FactoryMonthlyModel.empty();
      }

      return FactoryMonthlyModel.fromSnapshot(snapshot.docs.first);
    } on FirebaseException catch (e) {
      throw e.message ?? 'Something went wrong.';
    } catch (_) {
      throw 'Unable to load monthly summary.';
    }
  }

  Future<List<MonthlyBillRecordModel>> fetchMonthlyRecords({
    required String factoryId,
    required String monthKey,
  }) async {
    try {
      final snapshot = await _db
          .collection('Records')
          .where('FactoryId', isEqualTo: factoryId)
          .where('MonthKey', isEqualTo: monthKey)
          .orderBy('Date')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();

        final fare = (data['Fare'] ?? 0).toDouble();
        final load = (data['LoadDemurrage'] ?? 0).toDouble();
        final unload = (data['UnloadDemurrage'] ?? 0).toDouble();

        return MonthlyBillRecordModel(
          date: (data['Date'] as Timestamp).toDate(),
          truckNumber: data['TruckNumber'] ?? '',
          fare: fare,
          loadDemurrage: load,
          unloadDemurrage: unload,
          totalAmount: fare + load + unload,
          unloadPoint: data['UnloadPoint'] ?? '',
          item: data['Item'] ?? '',
          remarks: data['Remarks'] ?? '',
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw e.message ?? 'Something went wrong.';
    } catch (_) {
      throw 'Unable to load monthly records.';
    }
  }
}
