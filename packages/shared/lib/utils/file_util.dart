import 'dart:io';

import 'package:mason/mason.dart';

final class FileUtil {
  FileUtil._();

  static void deleteFiles(HookContext context, List<String> filesToDelete) {
    for (final path in filesToDelete) {
      final file = File(path);

      if (file.existsSync()) {
        file.deleteSync();
        context.logger.warn('🗑️ Deleted file: $path');
      } else {
        context.logger.info('Skipped (not found): $path');
      }
    }
  }
}
