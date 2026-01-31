import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_notifier.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'media_providers.g.dart';

/// Provider to fetch media from a conversation using the new Media Search API
///
/// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, LINK
/// Supports date filtering: startDate, endDate
/// Supports pagination with cursor
@riverpod
Future<MediaSearchResult> conversationMedia(
  Ref ref,
  int conversationId, {
  int limit = 100,
  List<String>? types, // IMAGE, VIDEO, FILE, AUDIO, LINK
  DateTime? startDate,
  DateTime? endDate,
  int? cursor,
}) async {
  final dio = ref.watch(dioProvider);

  try {
    // Build query parameters
    final queryParams = <String, dynamic>{'limit': limit};

    // Add cursor for pagination
    if (cursor != null) {
      queryParams['cursor'] = cursor;
    }

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

    // Call API: GET /v1/search/conversations/{conversationId}/media
    final response = await dio.get(
      ApiConstants.searchMedia(conversationId),
      queryParameters: queryParams,
    );

    if (response.data['success'] == true && response.data['data'] != null) {
      return MediaSearchResult.fromJson(response.data['data']);
    }

    return MediaSearchResult.empty();
  } catch (e, stackTrace) {
    // Silently handle 404 errors (conversation may not have media yet)
    if (e is DioException && e.response?.statusCode == 404) {
      return MediaSearchResult.empty();
    }
    debugPrint('❌ Error fetching media: $e');
    debugPrint('Stack trace: $stackTrace');
    return MediaSearchResult.empty();
  }
}

/// Provider to fetch media statistics only
@riverpod
Future<MediaStatistics> conversationMediaStatistics(
  Ref ref,
  int conversationId,
) async {
  final dio = ref.watch(dioProvider);

  try {
    // Call API: GET /v1/search/conversations/{conversationId}/media/statistics
    final response = await dio.get(ApiConstants.searchMedia(conversationId) + '/statistics');

    if (response.data['success'] == true && response.data['data'] != null) {
      return MediaStatistics.fromJson(response.data['data']);
    }

    return MediaStatistics.empty();
  } catch (e, stackTrace) {
    // Silently handle 404 errors (conversation may not have media statistics yet)
    if (e is DioException && e.response?.statusCode == 404) {
      return MediaStatistics.empty();
    }
    debugPrint('❌ Error fetching media statistics: $e');
    return MediaStatistics.empty();
  }
}

/// Media search result with messages, statistics, and pagination
class MediaSearchResult {
  final List<MediaMessage> messages;
  final MediaStatistics statistics;
  final MediaPagination pagination;

  MediaSearchResult({
    required this.messages,
    required this.statistics,
    required this.pagination,
  });

  factory MediaSearchResult.fromJson(Map<String, dynamic> json) {
    return MediaSearchResult(
      messages: (json['messages'] as List?)?.map((m) => MediaMessage.fromJson(m)).toList() ?? [],
      statistics: MediaStatistics.fromJson(json['statistics'] ?? {}),
      pagination: MediaPagination.fromJson(json['pagination'] ?? {}),
    );
  }

  factory MediaSearchResult.empty() {
    return MediaSearchResult(
      messages: [],
      statistics: MediaStatistics.empty(),
      pagination: MediaPagination.empty(),
    );
  }
}

/// Media message from API
class MediaMessage {
  final int id;
  final int conversationId;
  final int senderId;
  final String? senderUsername;
  final String? senderFullName;
  final String? senderAvatarUrl;
  final String content;
  final String type; // IMAGE, VIDEO, AUDIO, FILE, LINK
  final MediaMetadata? metadata;
  final DateTime sentAt;
  final DateTime createdAt;

  MediaMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    this.senderUsername,
    this.senderFullName,
    this.senderAvatarUrl,
    required this.content,
    required this.type,
    this.metadata,
    required this.sentAt,
    required this.createdAt,
  });

  factory MediaMessage.fromJson(Map<String, dynamic> json) {
    return MediaMessage(
      id: json['id'] ?? 0,
      conversationId: json['conversationId'] ?? 0,
      senderId: json['senderId'] ?? 0,
      senderUsername: json['senderUsername'],
      senderFullName: json['senderFullName'],
      senderAvatarUrl: json['senderAvatarUrl'],
      content: json['content'] ?? '',
      type: (json['type'] ?? 'FILE').toString().toUpperCase(),
      metadata: json['metadata'] != null ? MediaMetadata.fromJson(json['metadata']) : null,
      sentAt: DateTime.parse(json['sentAt'] ?? DateTime.now().toIso8601String()),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

/// Media metadata (URLs, file info, etc.)
class MediaMetadata {
  final String? mediaUrl;
  final String? thumbnailUrl;
  final String? fileName;
  final int? fileSize;
  final int? duration;
  final String? url; // For LINK type
  final String? title; // For LINK type
  final String? description; // For LINK type
  final String? imageUrl; // For LINK type

  MediaMetadata({
    this.mediaUrl,
    this.thumbnailUrl,
    this.fileName,
    this.fileSize,
    this.duration,
    this.url,
    this.title,
    this.description,
    this.imageUrl,
  });

  factory MediaMetadata.fromJson(Map<String, dynamic> json) {
    return MediaMetadata(
      mediaUrl: json['mediaUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      fileName: json['fileName'],
      fileSize: json['fileSize'],
      duration: json['duration'],
      url: json['url'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}

/// Media statistics
class MediaStatistics {
  final int totalImages;
  final int totalVideos;
  final int totalAudios;
  final int totalFiles;
  final int totalLinks;
  final int totalMedia;
  final int totalSize;

  MediaStatistics({
    required this.totalImages,
    required this.totalVideos,
    required this.totalAudios,
    required this.totalFiles,
    required this.totalLinks,
    required this.totalMedia,
    required this.totalSize,
  });

  factory MediaStatistics.fromJson(Map<String, dynamic> json) {
    return MediaStatistics(
      totalImages: json['totalImages'] ?? 0,
      totalVideos: json['totalVideos'] ?? 0,
      totalAudios: json['totalAudios'] ?? 0,
      totalFiles: json['totalFiles'] ?? 0,
      totalLinks: json['totalLinks'] ?? 0,
      totalMedia: json['totalMedia'] ?? 0,
      totalSize: json['totalSize'] ?? 0,
    );
  }

  factory MediaStatistics.empty() {
    return MediaStatistics(
      totalImages: 0,
      totalVideos: 0,
      totalAudios: 0,
      totalFiles: 0,
      totalLinks: 0,
      totalMedia: 0,
      totalSize: 0,
    );
  }
}

/// Pagination info
class MediaPagination {
  final int? nextCursor;
  final bool hasNextPage;
  final int pageSize;

  MediaPagination({
    this.nextCursor,
    required this.hasNextPage,
    required this.pageSize,
  });

  factory MediaPagination.fromJson(Map<String, dynamic> json) {
    return MediaPagination(
      nextCursor: json['nextCursor'],
      hasNextPage: json['hasNextPage'] ?? false,
      pageSize: json['pageSize'] ?? 20,
    );
  }

  factory MediaPagination.empty() {
    return MediaPagination(
      nextCursor: null,
      hasNextPage: false,
      pageSize: 0,
    );
  }
}
