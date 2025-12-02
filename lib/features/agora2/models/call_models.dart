import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_models.freezed.dart';
part 'call_models.g.dart';

enum CallType {
  @JsonValue('AUDIO')
  audio,
  @JsonValue('VIDEO')
  video,
}

enum CallStatus {
  @JsonValue('RINGING')
  ringing,
  @JsonValue('CONNECTING')
  connecting,
  @JsonValue('CONNECTED')
  connected,
  @JsonValue('REJECTED')
  rejected,
  @JsonValue('ENDED')
  ended,
  @JsonValue('INITIATING')
  initiating,
}

enum RejectReason {
  @JsonValue('busy')
  busy,
  @JsonValue('declined')
  declined,
  @JsonValue('unavailable')
  unavailable,
}

enum EndReason {
  @JsonValue('hangup')
  hangup,
  @JsonValue('network error')
  networkError,
  @JsonValue('device error')
  deviceError,
  @JsonValue('timeout')
  timeout,
}

@freezed
abstract class CallResponse with _$CallResponse {
  const factory CallResponse({
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
  }) = _CallResponse;

  factory CallResponse.fromJson(Map<String, dynamic> json) =>
      _$CallResponseFromJson(json);
}

@freezed
abstract class CallConnectionResponse with _$CallConnectionResponse {
  const factory CallConnectionResponse({
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
    required String token,
  }) = _CallConnectionResponse;

  factory CallConnectionResponse.fromJson(Map<String, dynamic> json) =>
      _$CallConnectionResponseFromJson(json);
}

@freezed
abstract class InitiateCallRequest with _$InitiateCallRequest {
  const factory InitiateCallRequest({
    required int calleeId,
    required CallType callType,
  }) = _InitiateCallRequest;

  factory InitiateCallRequest.fromJson(Map<String, dynamic> json) =>
      _$InitiateCallRequestFromJson(json);
}

@freezed
abstract class RejectCallRequest with _$RejectCallRequest {
  const factory RejectCallRequest({
    required RejectReason reason,
  }) = _RejectCallRequest;

  factory RejectCallRequest.fromJson(Map<String, dynamic> json) =>
      _$RejectCallRequestFromJson(json);
}

@freezed
abstract class EndCallRequest with _$EndCallRequest {
  const factory EndCallRequest({
    @Default(EndReason.hangup) EndReason reason,
  }) = _EndCallRequest;

  factory EndCallRequest.fromJson(Map<String, dynamic> json) =>
      _$EndCallRequestFromJson(json);
}

@Freezed(genericArgumentFactories: true) // CHỈ SỬ DỤNG ANNOTATION NÀY
abstract class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    required bool success,
    required String message,
    T? data,
  }) = _ApiResponse<T>;

  // Giữ nguyên factory constructor tùy chỉnh cho generic type T
  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object?) fromJsonT,
      ) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

// WebSocket DTOs
@freezed
abstract class CallInvitationDto with _$CallInvitationDto {
  const factory CallInvitationDto({
    required String callId,
    required String channelId,
    required int callerId,
    required String callerName,
    String? callerAvatar,
    required CallType callType,
  }) = _CallInvitationDto;

  factory CallInvitationDto.fromJson(Map<String, dynamic> json) =>
      _$CallInvitationDtoFromJson(json);
}

@freezed
abstract class CallAcceptDto with _$CallAcceptDto {
  const factory CallAcceptDto({
    required String callId,
    required int acceptedBy,
  }) = _CallAcceptDto;

  factory CallAcceptDto.fromJson(Map<String, dynamic> json) =>
      _$CallAcceptDtoFromJson(json);
}

@freezed
abstract class CallRejectDto with _$CallRejectDto {
  const factory CallRejectDto({
    required String callId,
    required int rejectedBy,
    required RejectReason reason,
  }) = _CallRejectDto;

  factory CallRejectDto.fromJson(Map<String, dynamic> json) =>
      _$CallRejectDtoFromJson(json);
}

@freezed
abstract class CallEndDto with _$CallEndDto {
  const factory CallEndDto({
    required String callId,
    required int endedBy,
    required int durationSeconds,
  }) = _CallEndDto;

  factory CallEndDto.fromJson(Map<String, dynamic> json) =>
      _$CallEndDtoFromJson(json);
}

@freezed
abstract class CallTimeoutDto with _$CallTimeoutDto {
  const factory CallTimeoutDto({
    required String callId,
    required String reason,
  }) = _CallTimeoutDto;

  factory CallTimeoutDto.fromJson(Map<String, dynamic> json) =>
      _$CallTimeoutDtoFromJson(json);
}

@freezed
abstract class WebSocketMessage with _$WebSocketMessage {
  const factory WebSocketMessage({
    required String type,
    required Map<String, dynamic> payload,
  }) = _WebSocketMessage;

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageFromJson(json);
}
