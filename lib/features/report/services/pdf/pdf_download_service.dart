import 'dart:io';
import 'dart:typed_data';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class PdfDownloadService {
  PdfDownloadService._();

  ///==========================================================
  /// Save PDF
  ///
  /// Returns saved file.
  ///==========================================================
  static Future<File> save({
    required Uint8List pdfBytes,
    required String fileName,
  }) async {
    final directory = await _getDownloadDirectory();

    /// Create Folder
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final file = File('${directory.path}/$fileName');

    await file.writeAsBytes(pdfBytes, flush: true);

    return file;
  }

  ///==========================================================
  /// Save & Open
  ///==========================================================
  static Future<File> saveAndOpen({
    required Uint8List pdfBytes,
    required String fileName,
  }) async {
    final file = await save(pdfBytes: pdfBytes, fileName: fileName);

    await OpenFilex.open(file.path);

    return file;
  }

  ///==========================================================
  /// App Download Folder
  ///==========================================================
  static Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      final dir = await getExternalStorageDirectory();

      return Directory('${dir!.path}/Lohaghara Carrier');
    }

    if (Platform.isWindows) {
      final dir = await getDownloadsDirectory();

      return Directory('${dir!.path}/Lohaghara Carrier');
    }

    final dir = await getApplicationDocumentsDirectory();

    return Directory('${dir.path}/Lohaghara Carrier');
  }
}
