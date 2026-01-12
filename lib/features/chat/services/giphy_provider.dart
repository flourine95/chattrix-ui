import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'giphy_service.dart';

part 'giphy_provider.g.dart';

/// Giphy Service Provider
@riverpod
GiphyService giphyService(Ref ref) {
  final dio = Dio(
    BaseOptions(connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 10)),
  );
  return GiphyService(dio);
}

/// Trending Stickers Provider
@riverpod
Future<List<GiphySticker>> trendingStickers(Ref ref) async {
  final service = ref.watch(giphyServiceProvider);
  return service.getTrendingStickers(limit: 50);
}

/// Search Stickers Provider
@riverpod
Future<List<GiphySticker>> searchStickers(Ref ref, String query) async {
  if (query.isEmpty) {
    return ref.watch(trendingStickersProvider.future);
  }

  final service = ref.watch(giphyServiceProvider);
  return service.searchStickers(query, limit: 50);
}

/// Category Stickers Provider
@riverpod
Future<List<GiphySticker>> categoryStickers(Ref ref, String category) async {
  final service = ref.watch(giphyServiceProvider);
  return service.getStickersByCategory(category, limit: 50);
}
