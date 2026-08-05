import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PdfShareService {
  PdfShareService._();

  ///==========================================================
  /// Share PDF
  ///==========================================================
  static Future<void> share({
    required Uint8List pdfBytes,
    required String fileName,
  }) async {
    final tempDir = await getTemporaryDirectory();

    final file = File('${tempDir.path}/$fileName');

    await file.writeAsBytes(pdfBytes, flush: true);

    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], text: fileName),
    );
  }
}
