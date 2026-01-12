import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement_request.freezed.dart';
part 'announcement_request.g.dart';

@freezed
abstract class CreateAnnouncementRequest with _$CreateAnnouncementRequest {
  const factory CreateAnnouncementRequest({required String content}) = _CreateAnnouncementRequest;

  factory CreateAnnouncementRequest.fromJson(Map<String, dynamic> json) => _$CreateAnnouncementRequestFromJson(json);
}
