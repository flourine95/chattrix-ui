import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';

part 'media_providers.g.dart';

/// Provider to fetch media from a conversation
///
/// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, VOICE, LINK
/// Supports date filtering: startDate, endDate
@riverpod
Future<List<MediaItem>> conversationMedia(
  Ref ref,
  int conversationId, {
  int limit = 100,
  List<String>? types, // IMAGE, VIDEO, FILE, AUDIO, VOICE, LINK
  DateTime? startDate,
  DateTime? endDate,
}) async {
  final dio = ref.watch(dioProvider);

  try {
    debugPrint('🔄 Fetching media for conversation $conversationId');
    debugPrint('   - limit: $limit');
    debugPrint('   - types: $types');
    debugPrint('   - startDate: $startDate');
    debugPrint('   - endDate: $endDate');

    // Build query parameters
    final queryParams = <String, dynamic>{'limit': limit, 'cursor': 0};

    // Add types if specified (comma-separated)
    if (types != null && types.isNotEmpty) {
      queryParams['type'] = types.join(',');
    }

    // Add date filters if specified (ISO 8601 format)
    if (startDate != null) {
      queryParams['startDate'] = startDate.toUtc().toIso8601String();
    }
    if (endDate != null) {
      queryParams['endDate'] = endDate.toUtc().toIso8601String();
    }

    // Call API
    final response = await dio.get('/v1/conversations/$conversationId/search/media', queryParameters: queryParams);

    debugPrint('📦 Media API response: ${response.data}');

    if (response.data['success'] == true && response.data['data'] != null) {
      final items = response.data['data']['items'] as List;
      debugPrint('✅ API returned ${items.length} media items');

      if (items.isNotEmpty) {
        debugPrint('📸 First item: ${items.first}');
        final mediaItems = items.map((item) => MediaItem.fromJson(item)).toList();
        debugPrint('✅ Parsed ${mediaItems.length} media items from API');
        return mediaItems;
      }
    }

    debugPrint('⚠️ API returned empty items');
    return [];
  } catch (e, stackTrace) {
    debugPrint('❌ Error fetching media: $e');
    debugPrint('Stack trace: $stackTrace');
    return [];
  }
}

/// Simple media item model
class MediaItem {
  final int id;
  final String type; // IMAGE, VIDEO, FILE, AUDIO, VOICE, LINK
  final String? url;
  final String? thumbnailUrl;
  final String? fileName;
  final int? fileSize;
  final DateTime createdAt;
  final int senderId;
  final String? senderName;

  MediaItem({
    required this.id,
    required this.type,
    this.url,
    this.thumbnailUrl,
    this.fileName,
    this.fileSize,
    required this.createdAt,
    required this.senderId,
    this.senderName,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    debugPrint('🔍 Parsing MediaItem from JSON: $json');

    return MediaItem(
      id: json['id'] ?? json['messageId'] ?? 0,
      type: (json['type'] ?? 'FILE').toString().toUpperCase(),
      url: json['url'] ?? json['mediaUrl'] ?? json['fileUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      fileName: json['fileName'],
      fileSize: json['fileSize'],
      createdAt: DateTime.parse(json['createdAt'] ?? json['sentAt'] ?? DateTime.now().toIso8601String()),
      senderId: json['senderId'] ?? json['sender']?['id'] ?? 0,
      senderName: json['senderName'] ?? json['sender']?['fullName'] ?? json['senderUsername'],
    );
  }
}
