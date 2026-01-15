import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_list_item_dto.freezed.dart';
part 'event_list_item_dto.g.dart';

/// Event List Item DTO - matches actual API response from GET /v1/conversations/{id}/events
@freezed
abstract  class EventListItemDto with _$EventListItemDto {
  const factory EventListItemDto({
    required int messageId,
    required String title,
    String? description,
    required String startTime,
    required String endTime,
    String? location,
    required List<int> going,
    required List<int> maybe,
    required List<int> notGoing,
    required int createdBy,
    required String createdByUsername,
    required String createdAt,
  }) = _EventListItemDto;

  factory EventListItemDto.fromJson(Map<String, dynamic> json) =>
      _$EventListItemDtoFromJson(json);
}
