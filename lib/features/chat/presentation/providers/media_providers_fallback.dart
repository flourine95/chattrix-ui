import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/media_providers.dart';

part 'media_providers_fallback.g.dart';

/// Fallback provider that extracts media from messages if API doesn't work
@riverpod
Future<List<MediaItem>> conversationMediaFallback(Ref ref, int conversationId, {int limit = 6}) async {
  try {
    debugPrint('🔄 Fallback: Extracting media from messages for conversation $conversationId');

    // Get messages from conversation
    final messagesAsync = await ref.watch(messagesProvider(conversationId.toString()).future);

    // Extract messages with media
    final mediaMessages = messagesAsync.where((msg) => msg.mediaUrl != null && msg.mediaUrl!.isNotEmpty).toList();

    debugPrint('✅ Fallback: Found ${mediaMessages.length} messages with media');

    // Convert to MediaItem
    final mediaItems = mediaMessages.take(limit).map((msg) {
      // Determine type from message type or file extension
      String mediaType = 'IMAGE';
      if (msg.type == 'VIDEO') {
        mediaType = 'VIDEO';
      } else if (msg.type == 'FILE') {
        mediaType = 'FILE';
      }

      return MediaItem(
        id: msg.id,
        type: mediaType,
        url: msg.mediaUrl,
        thumbnailUrl: msg.thumbnailUrl,
        fileName: msg.fileName,
        fileSize: msg.fileSize,
        createdAt: msg.createdAt,
        senderId: msg.senderId,
        senderName: null, // Not available in message
      );
    }).toList();

    debugPrint('✅ Fallback: Returning ${mediaItems.length} media items');
    return mediaItems;
  } catch (e, stackTrace) {
    debugPrint('❌ Fallback error: $e');
    debugPrint('Stack trace: $stackTrace');
    return [];
  }
}
