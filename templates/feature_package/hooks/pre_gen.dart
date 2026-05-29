import 'dart:io';

import 'package:mason/mason.dart';
import 'package:shared/utils/directory_util.dart';
import 'package:shared/utils/file_util.dart';

void run(HookContext context) async {
  final outputDir = context.vars['output_dir'];
  print(outputDir);

  final featureName = context.vars['feature_name'] as String;

  final currentDir = Directory.current.path;
  final packageDir = Directory('$currentDir/$featureName');

  if (packageDir.existsSync()) {
    context.logger.err('❌ App already exists at ${packageDir.path}');
    context.logger.err('🛑 Generation aborted.');
    exit(1);
  }

  final result = await Process.run(
    'flutter',
    ['create', '-t', 'package', featureName],
    workingDirectory: currentDir,
    runInShell: true,
  );

  stdout.write(result.stdout);

  if (result.exitCode != 0) {
    stderr.write(result.stderr);
    exit(result.exitCode);
  }

  context.logger.success('✅ Flutter package created');

  final dirToDelete = [
    Directory('${packageDir.path}/lib'),
    Directory('${packageDir.path}/test'),
  ];
  DirectoryUtil.deleteDirectories(context, dirToDelete);

  final filesToDelete = [
    '${packageDir.path}/analysis_options.yaml',
    '${packageDir.path}/CHANGELOG.md',
    '${packageDir.path}/LICENSE',
    '${packageDir.path}/pubspec.yaml',
    '${packageDir.path}/README.md',
  ];
  FileUtil.deleteFiles(context, filesToDelete);
}
