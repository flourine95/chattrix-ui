import 'package:freezed_annotation/freezed_annotation.dart';
import 'call_entity.dart';

part 'call_connection_entity.freezed.dart';

/// Connection credentials for joining an Agora channel
@freezed
abstract class CallConnectionEntity with _$CallConnectionEntity {
  const factory CallConnectionEntity({
    required CallEntity callEntity,
    required String token, // Agora token
  }) = _CallConnectionEntity;
}
