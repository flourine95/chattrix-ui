import 'package:freezed_annotation/freezed_annotation.dart';
import 'participant.dart';

part 'mutual_group.freezed.dart';

/// Domain entity for mutual group
/// Framework-agnostic - NO Flutter/Dio/json_annotation imports
@freezed
abstract class MutualGroup with _$MutualGroup {
  const factory MutualGroup({
    required int id,
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<Participant> participants,
  }) = _MutualGroup;
}
