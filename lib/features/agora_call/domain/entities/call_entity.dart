import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_entity.freezed.dart';

/// Core call information (framework-agnostic)
@freezed
abstract class CallEntity with _$CallEntity {
  const factory CallEntity({
    required String id,
    required String channelId,
    required CallStatus status,
    required CallType callType,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required int calleeId,
    required String calleeName,
    String? calleeAvatar,
    required DateTime createdAt,
    int? durationSeconds,
  }) = _CallEntity;
}

/// Call status enumeration
enum CallStatus { initiating, ringing, connecting, connected, rejected, ended }

/// Call type enumeration
enum CallType { audio, video }
