import 'package:chattrix_ui/features/chat/data/models/mentioned_user_model.dart';
import 'package:chattrix_ui/features/chat/data/models/read_receipt_model.dart';
import 'package:chattrix_ui/features/chat/data/models/reply_to_message_model.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/poll/data/models/poll_dto.dart';
import 'package:chattrix_ui/features/poll/data/mappers/poll_mapper.dart';
import 'package:chattrix_ui/features/chat/data/models/event_dto.dart';
import 'package:chattrix_ui/features/chat/data/mappers/event_mapper.dart';
import 'package:chattrix_ui/features/poll/data/models/poll_option_dto.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const MessageModel._();

  const factory MessageModel({
    required int id,
    required int conversationId,
    required int senderId,
    String? senderUsername,
    String? senderFullName,
    required String content,
    required String type,
    required String createdAt,
    // Rich media fields
    String? mediaUrl,
    String? thumbnailUrl,
    String? fileName,
    int? fileSize,
    int? duration,
    // Location fields
    double? latitude,
    double? longitude,
    String? locationName,
    // Reply/Thread fields
    int? replyToMessageId,
    ReplyToMessageModel? replyToMessage,
    // Reactions: Map of emoji to array of user IDs
    Map<String, List<int>>? reactions,
    // Mentions: Array of user IDs
    List<int>? mentions,
    @Default([]) List<MentionedUserModel> mentionedUsers,
    // Timestamps
    String? sentAt,
    String? updatedAt,
    // Edit/Delete/Forward
    @Default(false) bool edited,
    String? editedAt,
    @Default(false) bool deleted,
    String? deletedAt,
    @Default(false) bool forwarded,
    int? originalMessageId,
    @Default(0) int forwardCount,
    // Read receipts
    @Default(0) int readCount,
    @Default([]) List<ReadReceiptModel> readBy,
    // Scheduled message fields
    @Default(false) bool scheduled,
    String? scheduledTime,
    String? scheduledStatus, // PENDING, SENT, CANCELLED, FAILED
    // Pinned message fields
    @Default(false) bool pinned,
    String? pinnedAt,
    int? pinnedBy,
    String? pinnedByUsername,
    String? pinnedByFullName,
    // Poll data (for POLL type messages)
    PollDto? pollData,
    // Event data (for EVENT type messages)
    EventDto? eventData,
    // Metadata for additional message data (e.g., link preview info)
    Map<String, dynamic>? metadata,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  /// Safe int parsing - handles null, string, and number
  static int? _parseIntSafe(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    if (value is num) return value.toInt();
    return null;
  }

  /// Safe double parsing - handles null, string, and number
  static double? _parseDoubleSafe(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    if (value is num) return value.toDouble();
    return null;
  }

  /// Parse poll from NEW API metadata format
  /// NEW API: metadata.poll = {question, options: [{id, text, votes}], allowMultiple, closesAt}
  static PollDto? _parsePollFromMetadata(
    Map<String, dynamic> pollJson,
    Map<String, dynamic> messageJson, {
    int? currentUserId,
  }) {
    try {
      // Parse options from NEW API format
      final optionsJson = pollJson['options'] as List?;
      if (optionsJson == null) return null;

      final options = <PollOptionDto>[];
      int totalVotes = 0;
      
      for (var i = 0; i < optionsJson.length; i++) {
        final optMap = optionsJson[i] as Map<String, dynamic>;
        final votesRaw = (optMap['votes'] as List?)?.cast<int>() ?? [];
        
        // ✅ Deduplicate votes (backend bug workaround)
        final votes = votesRaw.toSet().toList();
        final voteCount = votes.length;
        totalVotes += voteCount;
        
        // Convert user IDs to UserDto (minimal data)
        final voters = votes.map((userId) => UserDto(
          id: userId,
          username: '',
          email: '',
          emailVerified: false,
          fullName: '',
          createdAt: DateTime.now().toIso8601String(),
        )).toList();
        
        // Safe parsing for id and text (handle both int and string)
        final optionId = _parseIntSafe(optMap['id']) ?? i;
        final optionText = optMap['text']?.toString() ?? '';
        
        options.add(PollOptionDto(
          id: optionId,
          optionText: optionText,
          optionOrder: i,
          voteCount: voteCount,
          percentage: 0.0, // Will be calculated later
          voters: voters,
        ));
      }

      // Calculate percentages
      final optionsWithPercentage = options.map((opt) {
        final percentage = totalVotes > 0 ? (opt.voteCount / totalVotes) * 100 : 0.0;
        return PollOptionDto(
          id: opt.id,
          optionText: opt.optionText,
          optionOrder: opt.optionOrder,
          voteCount: opt.voteCount,
          percentage: percentage,
          voters: opt.voters,
        );
      }).toList();

      // Calculate total voters (unique user IDs)
      final allVoterIds = <int>{};
      for (var option in options) {
        allVoterIds.addAll(option.voters.map((v) => v.id));
      }

      // Detect current user voted options
      // Priority: 1. Passed currentUserId, 2. messageJson['currentUserId']
      final userId = currentUserId ?? _parseIntSafe(messageJson['currentUserId']);
      final currentUserVotedOptionIds = <int>[];
      if (userId != null) {
        for (var i = 0; i < optionsWithPercentage.length; i++) {
          final option = optionsWithPercentage[i];
          if (option.voters.any((v) => v.id == userId)) {
            currentUserVotedOptionIds.add(option.id);
          }
        }
      }

      // Parse closesAt
      DateTime? closesAt;
      if (pollJson['closesAt'] != null) {
        try {
          closesAt = DateTime.parse(pollJson['closesAt'] as String);
        } catch (e) {
          debugPrint('⚠️ Failed to parse closesAt: $e');
        }
      }

      final now = DateTime.now();
      final isExpired = closesAt != null && closesAt.isBefore(now);

      return PollDto(
        id: _parseIntSafe(messageJson['id']) ?? 0,
        question: pollJson['question']?.toString() ?? '',
        conversationId: _parseIntSafe(messageJson['conversationId']) ?? 0,
        creator: UserDto(
          id: _parseIntSafe(messageJson['senderId']) ?? 0,
          username: messageJson['senderUsername']?.toString() ?? '',
          email: '',
          emailVerified: false,
          fullName: messageJson['senderFullName']?.toString() ?? '',
          createdAt: DateTime.now().toIso8601String(),
        ),
        allowMultipleVotes: pollJson['allowMultiple'] as bool? ?? false,
        expiresAt: closesAt,
        isClosed: pollJson['closed'] as bool? ?? false,
        isExpired: isExpired,
        isActive: !(pollJson['closed'] as bool? ?? false) && !isExpired,
        createdAt: DateTime.parse(messageJson['createdAt'] as String),
        totalVoters: allVoterIds.length,
        options: optionsWithPercentage,
        currentUserVotedOptionIds: currentUserVotedOptionIds,
      );
    } catch (e) {
      debugPrint('⚠️ [MessageModel] Error parsing poll from metadata: $e');
      return null;
    }
  }

  /// Parse event from NEW API metadata format
  /// NEW API: metadata.event = {title, description, startTime, endTime, location, going, maybe, notGoing}
  static EventDto? _parseEventFromMetadata(Map<String, dynamic> eventJson, Map<String, dynamic> messageJson) {
    try {
      final going = (eventJson['going'] as List?)?.cast<int>() ?? [];
      final maybe = (eventJson['maybe'] as List?)?.cast<int>() ?? [];
      final notGoing = (eventJson['notGoing'] as List?)?.cast<int>() ?? [];

      // Create dummy RSVPs from user IDs
      final rsvps = <EventRsvpDto>[];
      final timestamp = messageJson['createdAt']?.toString() ?? DateTime.now().toIso8601String();
      final updatedTimestamp = messageJson['updatedAt']?.toString() ?? timestamp;
      
      for (var userId in going) {
        rsvps.add(EventRsvpDto(
          id: userId,
          user: UserDto(
            id: userId,
            username: '',
            email: '',
            emailVerified: false,
            fullName: '',
            createdAt: timestamp,
          ),
          status: 'GOING',
          createdAt: timestamp,
          updatedAt: updatedTimestamp,
        ));
      }
      for (var userId in maybe) {
        rsvps.add(EventRsvpDto(
          id: userId,
          user: UserDto(
            id: userId,
            username: '',
            email: '',
            emailVerified: false,
            fullName: '',
            createdAt: timestamp,
          ),
          status: 'MAYBE',
          createdAt: timestamp,
          updatedAt: updatedTimestamp,
        ));
      }
      for (var userId in notGoing) {
        rsvps.add(EventRsvpDto(
          id: userId,
          user: UserDto(
            id: userId,
            username: '',
            email: '',
            emailVerified: false,
            fullName: '',
            createdAt: timestamp,
          ),
          status: 'NOT_GOING',
          createdAt: timestamp,
          updatedAt: updatedTimestamp,
        ));
      }

      return EventDto(
        id: _parseIntSafe(messageJson['id']) ?? 0,
        conversationId: _parseIntSafe(messageJson['conversationId']) ?? 0,
        creator: UserDto(
          id: _parseIntSafe(messageJson['senderId']) ?? 0,
          username: messageJson['senderUsername']?.toString() ?? '',
          email: '',
          emailVerified: false,
          fullName: messageJson['senderFullName']?.toString() ?? '',
          createdAt: messageJson['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
        ),
        title: eventJson['title']?.toString() ?? '',
        description: eventJson['description']?.toString(),
        startTime: eventJson['startTime']?.toString() ?? DateTime.now().toIso8601String(),
        endTime: eventJson['endTime']?.toString() ?? eventJson['startTime']?.toString() ?? DateTime.now().toIso8601String(),
        location: eventJson['location']?.toString(),
        createdAt: messageJson['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
        updatedAt: messageJson['updatedAt']?.toString() ?? messageJson['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
        goingCount: going.length,
        maybeCount: maybe.length,
        notGoingCount: notGoing.length,
        currentUserRsvpStatus: null, // TODO: Determine from current user ID
        rsvps: rsvps,
      );
    } catch (e) {
      debugPrint('⚠️ [MessageModel] Error parsing event from metadata: $e');
      return null;
    }
  }

  /// Parse message from API response
  /// Handles both REST API and WebSocket message formats
  factory MessageModel.fromApi(Map<String, dynamic> json, {int? currentUserId}) {
    // Inject currentUserId into json for poll parsing
    if (currentUserId != null) {
      json = Map<String, dynamic>.from(json);
      json['currentUserId'] = currentUserId;
    }
    
    // Parse replyToMessage - remove metadata field to avoid parsing errors
    ReplyToMessageModel? replyToMessage;
    if (json['replyToMessage'] != null && json['replyToMessage'] is Map<String, dynamic>) {
      try {
        final replyJson = Map<String, dynamic>.from(json['replyToMessage']);
        
        // Remove metadata field as it's not part of ReplyToMessageModel
        replyJson.remove('metadata');
        replyToMessage = ReplyToMessageModel.fromJson(replyJson);
      } catch (e) {
        debugPrint('⚠️ [MessageModel] Failed to parse replyToMessage: $e');
      }
    }

    // Parse mentionedUsers - skip invalid entries
    List<MentionedUserModel> mentionedUsers = [];
    if (json['mentionedUsers'] != null && json['mentionedUsers'] is List) {
      for (var e in json['mentionedUsers'] as List) {
        try {
          mentionedUsers.add(MentionedUserModel.fromJson(e as Map<String, dynamic>));
        } catch (error) {
          // Skip invalid mentioned user (e.g., null userId from backend)
          debugPrint('⚠️ Skipping invalid mentioned user: $error');
        }
      }
    }

    // Parse readBy
    List<ReadReceiptModel> readBy = [];
    if (json['readBy'] != null && json['readBy'] is List) {
      readBy = (json['readBy'] as List).map((e) => ReadReceiptModel.fromJson(e as Map<String, dynamic>)).toList();
    }

    // Parse reactions - API returns Map<String, List<int>>
    Map<String, List<int>>? reactions;
    if (json['reactions'] != null && json['reactions'] is Map) {
      reactions = (json['reactions'] as Map).map(
        (key, value) => MapEntry(
          key.toString(),
          (value as List)
              .where((e) => e != null) // Filter out null values
              .map((e) => (e as num).toInt())
              .toList(),
        ),
      );
    }

    // Parse mentions - API returns List<int>
    List<int>? mentions;
    if (json['mentions'] != null && json['mentions'] is List) {
      mentions = (json['mentions'] as List)
          .where((e) => e != null) // Filter out null values
          .map((e) => (e as num).toInt())
          .toList();
    }

    // Parse poll data - NEW API returns metadata.poll for POLL type messages
    PollDto? pollData;
    
    // Try metadata.poll first (NEW API)
    if (json['metadata'] != null && json['metadata'] is Map) {
      final metadata = json['metadata'] as Map<String, dynamic>;
      if (metadata['poll'] != null && metadata['poll'] is Map) {
        try {
          // NEW API format - simpler structure
          final pollJson = metadata['poll'] as Map<String, dynamic>;
          pollData = MessageModel._parsePollFromMetadata(pollJson, json);
        } catch (e) {
          debugPrint('⚠️ [MessageModel] Failed to parse metadata.poll: $e');
        }
      }
    }
    
    // Fallback to old formats if not found in metadata
    if (pollData == null) {
      final pollJson = json['poll'] ?? json['pollData'];
      if (pollJson != null && pollJson is Map) {
        try {
          pollData = PollDto.fromJson(pollJson as Map<String, dynamic>);
        } catch (e) {
          debugPrint('⚠️ [MessageModel] Failed to parse poll: $e');
        }
      }
    }

    // Parse event data - NEW API returns metadata.event for EVENT type messages
    EventDto? eventData;
    
    // Try metadata.event first (NEW API)
    if (json['metadata'] != null && json['metadata'] is Map) {
      final metadata = json['metadata'] as Map<String, dynamic>;
      if (metadata['event'] != null && metadata['event'] is Map) {
        try {
          // NEW API format - simpler structure
          final eventJson = metadata['event'] as Map<String, dynamic>;
          eventData = MessageModel._parseEventFromMetadata(eventJson, json);
        } catch (e) {
          debugPrint('⚠️ [MessageModel] Failed to parse metadata.event: $e');
        }
      }
    }
    
    // Fallback to old formats if not found in metadata
    if (eventData == null) {
      final eventJson = json['event'] ?? json['eventData'];
      if (eventJson != null && eventJson is Map) {
        try {
          eventData = EventDto.fromJson(eventJson as Map<String, dynamic>);
        } catch (e) {
          debugPrint('⚠️ [MessageModel] Failed to parse event: $e');
        }
      }
    }

    // Extract mediaUrl and thumbnailUrl from metadata if not at root level
    String? mediaUrl = json['mediaUrl']?.toString();
    String? thumbnailUrl = json['thumbnailUrl']?.toString();
    
    // If mediaUrl is null, check in metadata object
    if (mediaUrl == null && json['metadata'] != null && json['metadata'] is Map) {
      final metadata = json['metadata'] as Map<String, dynamic>;
      mediaUrl = metadata['mediaUrl']?.toString();
      thumbnailUrl = metadata['thumbnailUrl']?.toString();
    }

    final model = MessageModel(
      id: (json['id'] ?? json['messageId'] ?? 0) as int,
      conversationId: (json['conversationId'] ?? json['conversation_id'] ?? 0) as int,
      senderId: (json['senderId'] ?? json['sender']?['id'] ?? 0) as int,
      senderUsername: json['senderUsername']?.toString() ?? json['sender']?['username']?.toString(),
      senderFullName: json['senderFullName']?.toString() ?? json['sender']?['fullName']?.toString(),
      content: (json['content'] ?? '').toString(),
      type: (json['type'] ?? 'TEXT').toString(),
      createdAt: (json['createdAt'] ?? json['sentAt'] ?? DateTime.now().toIso8601String()).toString(),
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      fileName: json['fileName']?.toString(),
      fileSize: _parseIntSafe(json['fileSize']),
      duration: _parseIntSafe(json['duration']),
      latitude: _parseDoubleSafe(json['latitude']),
      longitude: _parseDoubleSafe(json['longitude']),
      locationName: json['locationName']?.toString(),
      replyToMessageId: _parseIntSafe(json['replyToMessageId']),
      replyToMessage: replyToMessage,
      reactions: reactions,
      mentions: mentions,
      mentionedUsers: mentionedUsers,
      sentAt: json['sentAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
      edited: json['edited'] ?? false,
      editedAt: json['editedAt']?.toString(),
      deleted: json['deleted'] ?? false,
      deletedAt: json['deletedAt']?.toString(),
      forwarded: json['forwarded'] ?? false,
      originalMessageId: _parseIntSafe(json['originalMessageId']),
      forwardCount: _parseIntSafe(json['forwardCount']) ?? 0,
      readCount: _parseIntSafe(json['readCount']) ?? 0,
      readBy: readBy,
      scheduled: json['scheduled'] ?? false,
      scheduledTime: json['scheduledTime']?.toString(),
      scheduledStatus: json['scheduledStatus']?.toString(),
      pinned: json['pinned'] ?? false,
      pinnedAt: json['pinnedAt']?.toString(),
      pinnedBy: _parseIntSafe(json['pinnedBy']),
      pinnedByUsername: json['pinnedByUsername']?.toString(),
      pinnedByFullName: json['pinnedByFullName']?.toString(),
      pollData: pollData,
      eventData: eventData,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

    return model;
  }

  /// Convert to domain entity
  Message toEntity() {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      senderUsername: senderUsername,
      senderFullName: senderFullName,
      content: content,
      type: type,
      createdAt: DateTime.parse(createdAt),
      mediaUrl: mediaUrl,
      thumbnailUrl: thumbnailUrl,
      fileName: fileName,
      fileSize: fileSize,
      duration: duration,
      latitude: latitude,
      longitude: longitude,
      locationName: locationName,
      replyToMessageId: replyToMessageId,
      replyToMessage: replyToMessage?.toEntity(),
      reactions: reactions,
      mentions: mentions,
      mentionedUsers: mentionedUsers.map((e) => e.toEntity()).toList(),
      sentAt: sentAt != null ? DateTime.parse(sentAt!) : null,
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
      edited: edited,
      editedAt: editedAt != null ? DateTime.parse(editedAt!) : null,
      deleted: deleted,
      deletedAt: deletedAt != null ? DateTime.parse(deletedAt!) : null,
      forwarded: forwarded,
      originalMessageId: originalMessageId,
      forwardCount: forwardCount,
      readCount: readCount,
      readBy: readBy.map((e) => e.toEntity()).toList(),
      scheduled: scheduled,
      scheduledTime: scheduledTime != null ? DateTime.parse(scheduledTime!) : null,
      scheduledStatus: scheduledStatus,
      pinned: pinned,
      pinnedAt: pinnedAt != null ? DateTime.parse(pinnedAt!) : null,
      pinnedBy: pinnedBy,
      pinnedByUsername: pinnedByUsername,
      pinnedByFullName: pinnedByFullName,
      pollData: pollData?.toEntity(),
      eventData: eventData?.toEntity(),
      metadata: metadata,
    );
  }
}
