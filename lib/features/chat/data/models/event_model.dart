import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
abstract class EventModel with _$EventModel {
  const factory EventModel({
    required int id,
    required int conversationId,
    required UserDto creator,
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int goingCount,
    @Default(0) int maybeCount,
    @Default(0) int notGoingCount,
    String? currentUserRsvpStatus,
    @Default([]) List<EventRsvpModel> rsvps,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}

@freezed
abstract class EventRsvpModel with _$EventRsvpModel {
  const factory EventRsvpModel({
    required int id,
    required UserDto user,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EventRsvpModel;

  factory EventRsvpModel.fromJson(Map<String, dynamic> json) =>
      _$EventRsvpModelFromJson(json);
}

@freezed
abstract class CreateEventRequest with _$CreateEventRequest {
  const factory CreateEventRequest({
    required String title,
    String? description,
    required DateTime startTime,
    required DateTime endTime,
    String? location,
  }) = _CreateEventRequest;

  factory CreateEventRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateEventRequestFromJson(json);
}

@freezed
abstract class UpdateEventRequest with _$UpdateEventRequest {
  const factory UpdateEventRequest({
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
  }) = _UpdateEventRequest;

  factory UpdateEventRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateEventRequestFromJson(json);
}

@freezed
abstract class RsvpEventRequest with _$RsvpEventRequest {
  const factory RsvpEventRequest({
    required String status,
  }) = _RsvpEventRequest;

  factory RsvpEventRequest.fromJson(Map<String, dynamic> json) =>
      _$RsvpEventRequestFromJson(json);
}

