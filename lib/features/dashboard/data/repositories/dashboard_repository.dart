import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lohaghara_carrier/core/exceptions/firebase_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/format_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/platform_exceptions.dart';

import '../models/dashboard_monthly_model.dart';
import '../../../record/data/models/record_model.dart';

class DashboardRepository extends GetxController {
  static DashboardRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //══════════════════════════════════════════════════════
  // Dashboard Monthly
  //══════════════════════════════════════════════════════

  Future<DashboardMonthlyModel> fetchDashboardMonthly(String monthKey) async {
    try {
      final snapshot = await _db
          .collection('DashboardMonthly')
          .doc(monthKey)
          .get();

      if (!snapshot.exists) {
        return DashboardMonthlyModel.empty();
      }

      return DashboardMonthlyModel.fromSnapshot(snapshot);
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }

  //══════════════════════════════════════════════════════
  // Recent Records
  //══════════════════════════════════════════════════════

  Future<List<RecordModel>> fetchRecentRecords({
    required String monthKey,
    int limit = 5,
  }) async {
    try {
      final snapshot = await _db
          .collection('Records')
          .where('MonthKey', isEqualTo: monthKey)
          .orderBy('Date', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) => RecordModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw LFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const LFormatException();
    } on PlatformException catch (e) {
      throw LPlatformException(e.code).message;
    } catch (_) {
      throw 'Something went wrong. Please try again';
    }
  }
}
