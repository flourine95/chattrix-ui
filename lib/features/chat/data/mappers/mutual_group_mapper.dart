import '../models/mutual_group_model.dart';
import '../../domain/entities/mutual_group.dart';

extension MutualGroupModelMapper on MutualGroupModel {
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
