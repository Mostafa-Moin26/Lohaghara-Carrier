import 'dart:typed_data';

import 'package:printing/printing.dart';

class PdfPreviewService {
  PdfPreviewService._();

  ///==========================================================
  /// Preview PDF
  ///==========================================================
  static Future<void> preview(Uint8List pdfBytes) async {
    await Printing.layoutPdf(onLayout: (_) async => pdfBytes);
  }
}
