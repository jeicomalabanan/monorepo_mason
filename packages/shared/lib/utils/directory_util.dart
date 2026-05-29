import 'dart:io';

import 'package:mason/mason.dart';

final class DirectoryUtil {
  DirectoryUtil._();

  static void deleteDirectories(HookContext context, List<String> dirPathList) {
    for (final dirPath in dirPathList) {
      final dir = Directory(dirPath);
      if (dir.existsSync()) {
        dir.deleteSync(recursive: true);
        context.logger.warn('🗑️ Deleted directory: $dirPath');
      } else {
        context.logger.info('Skipped: $dirPath');
      }
    }
  }
}
