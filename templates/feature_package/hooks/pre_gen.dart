import 'dart:io';

import 'package:mason/mason.dart';
import 'package:shared/utils/directory_util.dart';
import 'package:shared/utils/file_util.dart';

void run(HookContext context) async {
  final featureName = context.vars['feature_name'] as String;

  final currentDirPath = Directory.current.path;
  final featureDirPath = '$currentDirPath/$featureName';

  if (Directory(featureDirPath).existsSync()) {
    context.logger.err('❌ Feature already exists at $featureDirPath');
    exit(1);
  }

  context.logger.info('');
  context.logger.info('🚀 Feature Name : $featureName');
  context.logger.info('');

  final result = await Process.run('flutter', [
    'create',
    '--template=package',
    featureName,
  ], runInShell: true);

  stdout.write(result.stdout);

  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(result.exitCode);
  }

  final directoriesToDelete = ['$featureDirPath/lib', '$featureDirPath/test'];
  DirectoryUtil.deleteDirectories(context, directoriesToDelete);

  final filesToDelete = [
    '$featureDirPath/analysis_options.yaml',
    '$featureDirPath/CHANGELOG.md',
    '$featureDirPath/LICENSE',
    '$featureDirPath/pubspec.yaml',
    '$featureDirPath/README.md',
  ];
  FileUtil.deleteFiles(context, filesToDelete);
}
