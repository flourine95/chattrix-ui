import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/call_connection_entity.dart';
import 'call_model.dart';

part 'call_connection_model.freezed.dart';
part 'call_connection_model.g.dart';

/// Data Transfer Object for Call Connection with JSON serialization
@freezed
abstract class CallConnectionModel with _$CallConnectionModel {
  const CallConnectionModel._();

  const factory CallConnectionModel({required CallModel callData, required String token}) = _CallConnectionModel;

  factory CallConnectionModel.fromJson(Map<String, dynamic> json) => _$CallConnectionModelFromJson(json);
}

/// Extension to convert CallConnectionModel to CallConnectionEntity
extension CallConnectionModelX on CallConnectionModel {
  CallConnectionEntity toEntity() {
    return CallConnectionEntity(callEntity: callData.toEntity(), token: token);
  }
}
