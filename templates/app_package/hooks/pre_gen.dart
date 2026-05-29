import 'dart:io';

import 'package:mason/mason.dart';
import 'package:shared/utils/directory_util.dart';
import 'package:shared/utils/file_util.dart';

void run(HookContext context) async {
  final appName = context.vars['app_name'] as String;
  final org = context.vars['org'] as String;
  final platforms = context.vars['platforms'] as String;

  final currentDirPath = Directory.current.path;
  final appDirPath = '$currentDirPath/$appName';
  if (Directory(appDirPath).existsSync()) {
    context.logger.err('❌ App already exists at $appDirPath');
    exit(1);
  }

  context.logger.info('');
  context.logger.info('🚀 App Name     : $appName');
  context.logger.info('🏢 Organization : $org');
  context.logger.info('🧩 Platforms    : $platforms');
  context.logger.info('');

  final result = await Process.run('flutter', [
    'create',
    '--template=app',
    appName,
    '--org=$org',
    '--platforms=$platforms',
    '--empty',
  ], runInShell: true);

  stdout.write(result.stdout);

  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(result.exitCode);
  }

  final directoriesToDelete = ['$appDirPath/lib', '$appDirPath/test'];
  DirectoryUtil.deleteDirectories(context, directoriesToDelete);

  final filesToDelete = [
    '$appDirPath/pubspec.yaml',
    '$appDirPath/analysis_options.yaml',
    '$appDirPath/README.md',
  ];
  FileUtil.deleteFiles(context, filesToDelete);
}
