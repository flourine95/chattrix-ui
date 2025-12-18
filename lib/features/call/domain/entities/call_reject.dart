import 'package:freezed_annotation/freezed_annotation.dart';
import 'call_reject_reason.dart';

part 'call_reject.freezed.dart';

@freezed
abstract class CallReject with _$CallReject {
  const factory CallReject({required String callId, required int rejectedBy, required CallRejectReason reason}) =
      _CallReject;
}
