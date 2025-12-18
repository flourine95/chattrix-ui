import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_accept.freezed.dart';

@freezed
abstract class CallAccept with _$CallAccept {
  const factory CallAccept({required String callId, required int acceptedBy}) = _CallAccept;
}
