import 'package:hooks_riverpod/hooks_riverpod.dart';

// Placeholder providers for future data wiring.
// TODO: migrate to riverpod_annotation (@riverpod) code-gen when data layer is ready.

final chatListProvider = Provider<List<String>>((ref) {
  return List.generate(10, (i) => 'User ${i + 1}');
});

final userProfileProvider = Provider<Map<String, String>>((ref) {
  return {'name': 'User Name', 'status': 'online', 'id': '@userid'};
});
