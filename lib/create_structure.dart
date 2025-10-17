import 'dart:io';

import 'package:flutter/cupertino.dart';

void main() {
  final dirs = [
    'lib/core/constants',
    'lib/core/errors',
    'lib/core/utils',
    'lib/core/theme',
    'lib/core/widgets',
    'lib/features/auth/data/models',
    'lib/features/auth/data/datasources',
    'lib/features/auth/data/repositories',
    'lib/features/auth/domain/entities',
    'lib/features/auth/domain/repositories',
    'lib/features/auth/domain/usecases',
    'lib/features/auth/presentation/pages',
    'lib/features/auth/presentation/widgets',
    'lib/features/auth/presentation/providers',
  ];

  for (final dir in dirs) {
    Directory(dir).createSync(recursive: true);
    debugPrint('Created: $dir');
  }
}
