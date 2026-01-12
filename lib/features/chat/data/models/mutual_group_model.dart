import 'package:freezed_annotation/freezed_annotation.dart';
import 'participant_model.dart';

part 'mutual_group_model.freezed.dart';
part 'mutual_group_model.g.dart';

@freezed
abstract class MutualGroupModel with _$MutualGroupModel {
  const factory MutualGroupModel({
    required int id,
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<ParticipantModel> participants,
  }) = _MutualGroupModel;

  factory MutualGroupModel.fromJson(Map<String, dynamic> json) => _$MutualGroupModelFromJson(json);
}
