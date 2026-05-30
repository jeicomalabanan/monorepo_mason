import 'dart:io';

import 'package:mason/mason.dart';
import 'package:shared/utils/package_util.dart';

void run(HookContext context) async {
  final packageName = context.vars['package_name'] as String;

  final currentDirPath = Directory.current.path;
  final packageDirPath = '$currentDirPath/$packageName';

  if (Directory(packageDirPath).existsSync()) {
    context.logger.err('❌ Package already exists at $packageDirPath');
    exit(1);
  }

  context.logger.info('');
  context.logger.info('🚀 Package Name : $packageName');
  context.logger.info('');

  final result = await Process.run('dart', [
    'create',
    '--template=package',
    packageName,
  ], runInShell: true);

  stdout.write(result.stdout);

  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(result.exitCode);
  }

  // Delete directories and files
  PackageUtil.cleanDartPackage(context, packageDirPath);
}
