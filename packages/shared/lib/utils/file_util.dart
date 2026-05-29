import 'dart:io';

import 'package:mason/mason.dart';

final class FileUtil {
  FileUtil._();

  static void deleteFiles(HookContext context, List<String> filePathList) {
    for (final filePath in filePathList) {
      final file = File(filePath);
      if (file.existsSync()) {
        file.deleteSync();
        context.logger.warn('🗑️ Deleted file: $filePath');
      } else {
        context.logger.info('Skipped: $filePath');
      }
    }
  }
}
