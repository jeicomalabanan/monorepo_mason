import 'package:mason/mason.dart';

import 'directory_util.dart';
import 'file_util.dart';

final class PackageUtil {
  PackageUtil._();

  static void cleanFlutterPackage(HookContext context, String dirPath) {
    final directoriesToDelete = [
      '$dirPath/.dart_tool',
      '$dirPath/lib',
      '$dirPath/test',
    ];
    DirectoryUtil.deleteDirectories(context, directoriesToDelete);

    final filesToDelete = [
      '$dirPath/analysis_options.yaml',
      '$dirPath/CHANGELOG.md',
      '$dirPath/LICENSE',
      '$dirPath/pubspec.lock',
      '$dirPath/pubspec.yaml',
      '$dirPath/README.md',
    ];
    FileUtil.deleteFiles(context, filesToDelete);
  }

  static void cleanDartPackage(HookContext context, String dirPath) {
    final directoriesToDelete = [
      '$dirPath/.dart_tool',
      '$dirPath/example',
      '$dirPath/lib',
      '$dirPath/test',
    ];
    DirectoryUtil.deleteDirectories(context, directoriesToDelete);

    final filesToDelete = [
      '$dirPath/analysis_options.yaml',
      '$dirPath/CHANGELOG.md',
      '$dirPath/pubspec.lock',
      '$dirPath/pubspec.yaml',
      '$dirPath/README.md',
    ];
    FileUtil.deleteFiles(context, filesToDelete);
  }
}
