import 'package:freezed_annotation/freezed_annotation.dart';
import 'call_info.dart';

part 'call_connection.freezed.dart';

@freezed
abstract class CallConnection with _$CallConnection {
  const factory CallConnection({
    required CallInfo callInfo,
    required String token,
  }) = _CallConnection;
}

