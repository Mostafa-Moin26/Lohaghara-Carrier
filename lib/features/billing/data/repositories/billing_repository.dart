import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lohaghara_carrier/core/exceptions/firebase_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/format_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/platform_exceptions.dart';

import '../models/billing_month_model.dart';

class BillingRepository extends GetxController {
  static BillingRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get Billing Month
  Future<BillingMonthModel?> getBillingMonth(String monthKey) async {
    try {
      final document = await _db
          .collection('BillingMonths')
          .doc(monthKey)
          .get();

      if (!document.exists) {
        return null;
      }

      return BillingMonthModel.fromSnapshot(document);
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

  /// Create Billing Month
  Future<BillingMonthModel> createBillingMonth(String monthKey) async {
    try {
      final existing = await getBillingMonth(monthKey);

      if (existing != null) {
        return existing;
      }

      final latestSnapshot = await _db
          .collection('BillingMonths')
          .orderBy('BillNo', descending: true)
          .limit(1)
          .get();

      int nextBillNo = 1;

      if (latestSnapshot.docs.isNotEmpty) {
        nextBillNo = (latestSnapshot.docs.first.data()['BillNo'] ?? 0) + 1;
      }

      final billingMonth = BillingMonthModel(
        monthKey: monthKey,
        billNo: nextBillNo,
        billCode: 'Lohagara-$nextBillNo',
        createdAt: DateTime.now(),
      );

      await _db
          .collection('BillingMonths')
          .doc(monthKey)
          .set(billingMonth.toJson());

      return billingMonth;
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

  /// Get Or Create
  Future<BillingMonthModel> getOrCreateBillingMonth(String monthKey) async {
    final existing = await getBillingMonth(monthKey);

    if (existing != null) {
      return existing;
    }

    return await createBillingMonth(monthKey);
  }
}
