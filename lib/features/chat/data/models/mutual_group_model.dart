import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/chat/domain/entities/mutual_group.dart';
import 'participant_model.dart';

part 'mutual_group_model.freezed.dart';
part 'mutual_group_model.g.dart';

@freezed
abstract class MutualGroupModel with _$MutualGroupModel {
  const MutualGroupModel._();

  const factory MutualGroupModel({
    required int id,
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<ParticipantModel> participants,
  }) = _MutualGroupModel;

  factory MutualGroupModel.fromJson(Map<String, dynamic> json) => _$MutualGroupModelFromJson(json);

  MutualGroup toEntity() {
    return MutualGroup(
      id: id,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
      participants: participants.map((p) => p.toEntity()).toList(),
    );
  }
}
