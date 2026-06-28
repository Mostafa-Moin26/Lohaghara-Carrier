import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:lohaghara_carrier/core/exceptions/firebase_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/format_exceptions.dart';
import 'package:lohaghara_carrier/core/exceptions/platform_exceptions.dart';

import '../../../company/data/models/company_model.dart';
import '../../../factory/data/models/factory_monthly_model.dart';

class SummaryRepository extends GetxController {
  static SummaryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetch All Companies
  Future<List<CompanyModel>> fetchCompanies() async {
    try {
      final snapshot = await _db.collection('Companies').orderBy('Name').get();

      return snapshot.docs
          .map((doc) => CompanyModel.fromSnapshot(doc))
          .toList();
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

  /// Fetch Summary Data
  Future<List<FactoryMonthlyModel>> fetchFactorySummary({
    required String companyId,
    required String monthKey,
  }) async {
    try {
      final snapshot = await _db
          .collection('FactoryMonthly')
          .where('CompanyId', isEqualTo: companyId)
          .where('MonthKey', isEqualTo: monthKey)
          .orderBy('FactoryName')
          .get();

      return snapshot.docs
          .map((doc) => FactoryMonthlyModel.fromSnapshot(doc))
          .toList();
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
