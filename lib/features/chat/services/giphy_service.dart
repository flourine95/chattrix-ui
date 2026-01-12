import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Giphy Sticker Model
class GiphySticker {
  final String id;
  final String title;
  final String url;
  final String previewUrl;
  final int width;
  final int height;

  GiphySticker({
    required this.id,
    required this.title,
    required this.url,
    required this.previewUrl,
    required this.width,
    required this.height,
  });

  factory GiphySticker.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as Map<String, dynamic>;
    final fixedHeight = images['fixed_height'] as Map<String, dynamic>;
    final original = images['original'] as Map<String, dynamic>;

    return GiphySticker(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      url: original['url'] as String,
      previewUrl: fixedHeight['url'] as String,
      width: int.tryParse(original['width']?.toString() ?? '0') ?? 0,
      height: int.tryParse(original['height']?.toString() ?? '0') ?? 0,
    );
  }
}

/// Giphy Service for fetching stickers
class GiphyService {
  final Dio _dio;
  final String _apiKey;
  static const String _baseUrl = 'https://api.giphy.com/v1/stickers';

  GiphyService(this._dio) : _apiKey = dotenv.env['GIPHY_API_KEY'] ?? '' {
    if (_apiKey.isEmpty) {
      debugPrint('⚠️ GIPHY_API_KEY not found in .env file');
    }
  }

  /// Get trending stickers
  Future<List<GiphySticker>> getTrendingStickers({int limit = 20, int offset = 0}) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/trending',
        queryParameters: {
          'api_key': _apiKey,
          'limit': limit,
          'offset': offset,
          'rating': 'g', // G-rated content only
        },
      );

      final data = response.data['data'] as List;
      return data.map((json) => GiphySticker.fromJson(json)).toList();
    } catch (e) {
      debugPrint('❌ Error fetching trending stickers: $e');
      return [];
    }
  }

  /// Search stickers by query
  Future<List<GiphySticker>> searchStickers(String query, {int limit = 20, int offset = 0}) async {
    if (query.isEmpty) return getTrendingStickers(limit: limit, offset: offset);

    try {
      final response = await _dio.get(
        '$_baseUrl/search',
        queryParameters: {
          'api_key': _apiKey,
          'q': query,
          'limit': limit,
          'offset': offset,
          'rating': 'g',
          'lang': 'en',
        },
      );

      final data = response.data['data'] as List;
      return data.map((json) => GiphySticker.fromJson(json)).toList();
    } catch (e) {
      debugPrint('❌ Error searching stickers: $e');
      return [];
    }
  }

  /// Get stickers by category/tag
  Future<List<GiphySticker>> getStickersByCategory(String category, {int limit = 20, int offset = 0}) async {
    return searchStickers(category, limit: limit, offset: offset);
  }
}
