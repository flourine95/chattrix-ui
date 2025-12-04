import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_end.freezed.dart';

@freezed
abstract class CallEnd with _$CallEnd {
  const factory CallEnd({
    required String callId,
    required int endedBy,
    int? durationSeconds,
  }) = _CallEnd;
}

