import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lohaghara_carrier/core/exceptions/firebase_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/format_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/platform_exceptions.dart';

import 'package:lohaghara_carrier/features/auth/data/repositories/authentication_repository.dart';
import 'package:lohaghara_carrier/features/dashboard/data/models/dashboard_monthly_model.dart';
import 'package:lohaghara_carrier/features/factory/data/models/factory_monthly_model.dart';
import 'package:lohaghara_carrier/features/record/data/models/record_model.dart';

class RecordRepository extends GetxController {
  static RecordRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// ------------ Private Methods ------------- ///
  DocumentReference<Map<String, dynamic>> _getDashboardRef(String monthKey) {
    return _db.collection('DashboardMonthly').doc(monthKey);
  }

  DocumentReference<Map<String, dynamic>> _getFactoryMonthlyRef(
    String monthKey,
    String factoryId,
  ) {
    return _db.collection('FactoryMonthly').doc('${monthKey}_$factoryId');
  }

  bool _sameAggregateBucket(RecordModel oldRecord, RecordModel newRecord) {
    return oldRecord.monthKey == newRecord.monthKey &&
        oldRecord.factoryId == newRecord.factoryId;
  }

  double _getDemurrage(RecordModel record) {
    return record.loadDemurrage + record.unloadDemurrage;
  }

  /// Create Record
  Future<RecordModel> addRecord(RecordModel record) async {
    try {
      final recordDoc = _db.collection('Records').doc();

      final recordWithMetadata = record.copyWith(
        id: recordDoc.id,
        createdBy: AuthenticationRepository.instance.authUser!.uid,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _db.runTransaction((transaction) async {
        /// References
        final dashboardRef = _getDashboardRef(record.monthKey);

        final factoryMonthlyRef = _getFactoryMonthlyRef(
          record.monthKey,
          record.factoryId,
        );

        /// Existing Docs
        final dashboardSnapshot = await transaction.get(dashboardRef);

        final factorySnapshot = await transaction.get(factoryMonthlyRef);

        /// Save Record
        transaction.set(recordDoc, recordWithMetadata.toJson());

        /// Dashboard Monthly
        if (!dashboardSnapshot.exists) {
          final dashboard = DashboardMonthlyModel(
            monthKey: record.monthKey,
            totalBilling: record.totalAmount,
            totalTrips: 1,
            totalDemurrage: record.loadDemurrage + record.unloadDemurrage,
            activeFactoryCount: 1,
            updatedAt: DateTime.now(),
          );

          transaction.set(dashboardRef, dashboard.toJson());
        } else {
          transaction.update(dashboardRef, {
            'TotalBilling': FieldValue.increment(record.totalAmount),
            'TotalTrips': FieldValue.increment(1),
            'TotalDemurrage': FieldValue.increment(
              record.loadDemurrage + record.unloadDemurrage,
            ),
            'UpdatedAt': Timestamp.now(),
          });
        }

        /// Factory Monthly
        if (!factorySnapshot.exists) {
          final factoryMonthly = FactoryMonthlyModel(
            factoryId: record.factoryId,
            factoryName: record.factoryName,
            companyId: record.companyId,
            companyName: record.companyName,
            monthKey: record.monthKey,
            totalTrips: 1,
            totalAmount: record.totalAmount,
            updatedAt: DateTime.now(),
          );

          transaction.set(factoryMonthlyRef, factoryMonthly.toJson());

          /// Increase Active Factory Count
          if (dashboardSnapshot.exists) {
            transaction.update(dashboardRef, {
              'ActiveFactoryCount': FieldValue.increment(1),
            });
          }
        } else {
          transaction.update(factoryMonthlyRef, {
            'TotalTrips': FieldValue.increment(1),
            'TotalAmount': FieldValue.increment(record.totalAmount),
            'UpdatedAt': Timestamp.now(),
          });
        }
      });

      return recordWithMetadata;
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get All Records
  Future<List<RecordModel>> fetchAllRecords() async {
    try {
      final snapshot = await _db
          .collection('Records')
          .orderBy('Date', descending: true)
          .get();

      return snapshot.docs
          .map((document) => RecordModel.fromSnapshot(document))
          .toList();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update Record
  Future<void> updateRecord(RecordModel updatedRecord) async {
    try {
      final recordRef = _db.collection('Records').doc(updatedRecord.id);

      await _db.runTransaction((transaction) async {
        final recordSnapshot = await transaction.get(recordRef);

        if (!recordSnapshot.exists) {
          throw 'Record not found';
        }

        final oldRecord = RecordModel.fromSnapshot(recordSnapshot);

        /// Same Bucket
        if (_sameAggregateBucket(oldRecord, updatedRecord)) {
          final dashboardRef = _getDashboardRef(oldRecord.monthKey);

          final factoryRef = _getFactoryMonthlyRef(
            oldRecord.monthKey,
            oldRecord.factoryId,
          );

          final amountDelta = updatedRecord.totalAmount - oldRecord.totalAmount;

          final demurrageDelta =
              _getDemurrage(updatedRecord) - _getDemurrage(oldRecord);

          /// Update Record
          transaction.update(
            recordRef,
            updatedRecord.copyWith(updatedAt: DateTime.now()).toJson(),
          );

          /// Dashboard
          transaction.update(dashboardRef, {
            'TotalBilling': FieldValue.increment(amountDelta),
            'TotalDemurrage': FieldValue.increment(demurrageDelta),
            'UpdatedAt': Timestamp.now(),
          });

          /// Factory Monthly
          transaction.update(factoryRef, {
            'TotalAmount': FieldValue.increment(amountDelta),
            'UpdatedAt': Timestamp.now(),
          });

          return;
        }

        /// --------- Complex Update Section ---------- ///
        final newDashboardRef = _getDashboardRef(updatedRecord.monthKey);

        final newDashboardSnapshot = await transaction.get(newDashboardRef);

        final newFactoryRef = _getFactoryMonthlyRef(
          updatedRecord.monthKey,
          updatedRecord.factoryId,
        );

        final newFactorySnapshot = await transaction.get(newFactoryRef);
        final oldFactoryRef = _getFactoryMonthlyRef(
          oldRecord.monthKey,
          oldRecord.factoryId,
        );

        final oldFactorySnapshot = await transaction.get(oldFactoryRef);

        /// Remove Old Dashboard
        transaction.update(_getDashboardRef(oldRecord.monthKey), {
          'TotalBilling': FieldValue.increment(-oldRecord.totalAmount),
          'TotalTrips': FieldValue.increment(-1),
          'TotalDemurrage': FieldValue.increment(-_getDemurrage(oldRecord)),
          'UpdatedAt': Timestamp.now(),
        });

        /// Remove Old Factory
        final oldTrips = oldFactorySnapshot.get('TotalTrips');

        if (oldTrips <= 1) {
          transaction.delete(oldFactoryRef);

          transaction.update(_getDashboardRef(oldRecord.monthKey), {
            'ActiveFactoryCount': FieldValue.increment(-1),
          });
        } else {
          transaction.update(oldFactoryRef, {
            'TotalTrips': FieldValue.increment(-1),

            'TotalAmount': FieldValue.increment(-oldRecord.totalAmount),

            'UpdatedAt': Timestamp.now(),
          });
        }

        /// Add New Dashboard
        transaction.set(newDashboardRef, {
          'MonthKey': updatedRecord.monthKey,

          'TotalBilling': FieldValue.increment(updatedRecord.totalAmount),

          'TotalTrips': FieldValue.increment(1),

          'TotalDemurrage': FieldValue.increment(_getDemurrage(updatedRecord)),

          'UpdatedAt': Timestamp.now(),
        }, SetOptions(merge: true));

        /// Add New Factory
        if (!newFactorySnapshot.exists) {
          transaction.set(
            newFactoryRef,
            FactoryMonthlyModel(
              factoryId: updatedRecord.factoryId,
              factoryName: updatedRecord.factoryName,
              companyId: updatedRecord.companyId,
              companyName: updatedRecord.companyName,
              monthKey: updatedRecord.monthKey,
              totalTrips: 1,
              totalAmount: updatedRecord.totalAmount,
              updatedAt: DateTime.now(),
            ).toJson(),
          );
          if (!newDashboardSnapshot.exists) {
            transaction.set(newDashboardRef, {
              'MonthKey': updatedRecord.monthKey,

              'ActiveFactoryCount': 1,

              'TotalBilling': 0,
              'TotalTrips': 0,
              'TotalDemurrage': 0,

              'UpdatedAt': Timestamp.now(),
            }, SetOptions(merge: true));
          } else {
            transaction.update(newDashboardRef, {
              'ActiveFactoryCount': FieldValue.increment(1),
            });
          }
        } else {
          transaction.update(newFactoryRef, {
            'TotalTrips': FieldValue.increment(1),

            'TotalAmount': FieldValue.increment(updatedRecord.totalAmount),

            'UpdatedAt': Timestamp.now(),
          });
        }

        /// Update Record
        transaction.update(
          recordRef,
          updatedRecord.copyWith(updatedAt: DateTime.now()).toJson(),
        );

        return;
      });
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  /// Delete Record
  Future<void> deleteRecord(String recordId) async {
    try {
      await _db.collection('Records').doc(recordId).delete();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get Single Record
  Future<RecordModel> fetchRecordById(String recordId) async {
    try {
      final document = await _db.collection('Records').doc(recordId).get();

      if (document.exists) {
        return RecordModel.fromSnapshot(document);
      }

      return RecordModel.empty();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
