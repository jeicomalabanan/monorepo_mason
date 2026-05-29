import 'dart:io';

import 'package:mason/mason.dart';

final class DirectoryUtil {
  DirectoryUtil._();

  static void deleteDirectories(
    HookContext context,
    List<Directory> directories,
  ) {
    for (final dir in directories) {
      if (dir.existsSync()) {
        dir.deleteSync(recursive: true);
        context.logger.warn('🗑️ Deleted directory: $dir');
      } else {
        context.logger.info('Skipped test directory');
      }
    }
  }
}
