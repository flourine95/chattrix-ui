import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_connection.dart';
import 'call_info_model.dart';

part 'call_connection_model.freezed.dart';
part 'call_connection_model.g.dart';

@freezed
abstract class CallConnectionModel with _$CallConnectionModel {
  const CallConnectionModel._();

  const factory CallConnectionModel({
    required CallInfoModel callInfo,
    required String token,
  }) = _CallConnectionModel;

  factory CallConnectionModel.fromJson(Map<String, dynamic> json) =>
      _$CallConnectionModelFromJson(json);

  CallConnection toEntity() {
    return CallConnection(
      callInfo: callInfo.toEntity(),
      token: token,
    );
  }
}
