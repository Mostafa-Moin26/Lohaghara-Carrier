class ReportIdHelper {
  ReportIdHelper._();

  //==========================================================
  // Summary Report ID
  // Example:
  // summary_CL3t6wa_2026-06
  //==========================================================

  static String summary({required String companyId, required String monthKey}) {
    return 'summary_${companyId}_$monthKey';
  }

  //==========================================================
  // Monthly Report ID
  // Example:
  // monthly_S4Sk5GAC_2026-06
  //==========================================================

  static String monthly({required String factoryId, required String monthKey}) {
    return 'monthly_${factoryId}_$monthKey';
  }
}
