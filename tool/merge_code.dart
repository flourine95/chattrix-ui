import 'dart:io';

const List<String> DEFAULT_SOURCE_FOLDERS = ['lib/features/chat','lib/core'];
const int MAX_CHARS_PER_FILE = 2000000;
const List<String> EXTENSIONS = ['.dart', '.yaml', '.json', '.gradle', '.xml', '.sql', '.prisma'];
const List<String> IGNORE_PATTERNS = [
  '.g.dart',
  '.freezed.dart',
  '.gen.dart',
  'generated_plugin_registrant.dart'
];
const List<String> IGNORE_DIRS = ['.git', '.dart_tool', 'build', 'ios', 'android', 'web', 'tool', 'node_modules'];

void main(List<String> args) async {
  final scriptFile = File(Platform.script.toFilePath());
  final scriptDir = scriptFile.parent;
  final outputDir = Directory('${scriptDir.path}/merged_output');

  final List<String> targetPaths = args.isNotEmpty ? args : DEFAULT_SOURCE_FOLDERS;

  print('📂 Script location: ${scriptDir.path}');
  print('📂 Output location: ${outputDir.path}');
  print('🔍 Targets: $targetPaths');

  final stopwatch = Stopwatch()..start();

  if (!await outputDir.exists()) {
    await outputDir.create(recursive: true);
  }

  final List<File> allFiles = [];
  final Set<String> processedPaths = {};

  for (final path in targetPaths) {
    final dir = Directory(path);
    if (!await dir.exists()) {
      print('⚠️ Warning: Folder not found: "$path"');
      continue;
    }

    final files = await _scanFiles(dir);
    for (var file in files) {
      final absPath = file.absolute.path;
      if (!processedPaths.contains(absPath)) {
        processedPaths.add(absPath);
        allFiles.add(file);
      }
    }
  }

  allFiles.sort((a, b) => a.path.compareTo(b.path));

  if (allFiles.isEmpty) {
    print('❌ No valid files found.');
    return;
  }

  print('📦 Found total ${allFiles.length} unique files. Merging...');

  int partCount = 1;
  StringBuffer currentBuffer = StringBuffer();

  currentBuffer.writeln('# PROJECT STRUCTURE');
  final currentDirPath = Directory.current.path;

  for (var file in allFiles) {
    String relative = file.path;
    if (file.absolute.path.startsWith(currentDirPath)) {
      relative = file.absolute.path.replaceFirst(currentDirPath, '');
    }

    if (relative.startsWith(Platform.pathSeparator) || relative.startsWith('/') || relative.startsWith('\\')) {
      relative = relative.substring(1);
    }

    relative = relative.replaceAll('\\', '/');
    currentBuffer.writeln('- $relative');
  }
  currentBuffer.writeln('\n' + ('=' * 50) + '\n');

  for (var file in allFiles) {
    String content;
    try {
      content = await file.readAsString();
    } catch (_) {
      continue;
    }

    String normalizedPath = file.path.replaceAll('\\', '/');
    if (normalizedPath.startsWith('./')) {
      normalizedPath = normalizedPath.substring(2);
    }

    final cleanedContent = _cleanContent(content);

    final entry = StringBuffer();
    entry.writeln('================================================================');
    entry.writeln('FILE: $normalizedPath');
    entry.writeln('================================================================');
    entry.writeln(cleanedContent);
    entry.writeln('');

    if (currentBuffer.length + entry.length > MAX_CHARS_PER_FILE && currentBuffer.isNotEmpty) {
      await _saveFile(outputDir, partCount, currentBuffer.toString());
      partCount++;
      currentBuffer.clear();
    }

    currentBuffer.write(entry.toString());
  }

  if (currentBuffer.isNotEmpty) {
    await _saveFile(outputDir, partCount, currentBuffer.toString());
  }

  stopwatch.stop();
  print('✅ Done! Files saved in: ${outputDir.path}');
}

Future<List<File>> _scanFiles(Directory dir) async {
  final List<FileSystemEntity> entities = await dir.list(recursive: true).toList();

  final files = entities.whereType<File>().where((file) {
    final path = file.path.replaceAll('\\', '/');
    if (IGNORE_DIRS.any((d) => path.contains('/$d/'))) return false;
    final isValidExt = EXTENSIONS.any((ext) => path.endsWith(ext));
    final isIgnored = IGNORE_PATTERNS.any((pattern) => path.endsWith(pattern));
    return isValidExt && !isIgnored;
  }).toList();

  return files;
}

Future<void> _saveFile(Directory dir, int index, String content) async {
  final fileName = '${dir.path}/context_part_$index.txt';
  final file = File(fileName);
  await file.writeAsString(content);
  print('   -> Saved: ${file.path.split(Platform.pathSeparator).last} (${(content.length / 1024).toStringAsFixed(1)} KB)');
}

String _cleanContent(String content) {
  content = content.replaceAll(RegExp(r'^\s*//.*$', multiLine: true), '');
  content = content.replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '');

  final lines = content.split('\n');
  final buffer = StringBuffer();
  bool lastWasEmpty = false;

  for (var line in lines) {
    final trimmed = line.trim();
    if (trimmed.isEmpty) {
      if (!lastWasEmpty) {
        buffer.writeln();
        lastWasEmpty = true;
      }
    } else {
      buffer.writeln(line.trimRight());
      lastWasEmpty = false;
    }
  }
  return buffer.toString().trim();
}