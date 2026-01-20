// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallHistoryModel {

 String? get id;// Changed from callId
 int? get conversationId; int? get callerId;// NEW - to determine incoming/outgoing
 String? get callerName;// Changed from participantName
 String? get callerAvatar;// Changed from participantAvatar
 String? get callType; String? get status;// NEW - to determine if missed
 String? get createdAt;// Changed from timestamp (String in API)
 int? get durationSeconds;
/// Create a copy of CallHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallHistoryModelCopyWith<CallHistoryModel> get copyWith => _$CallHistoryModelCopyWithImpl<CallHistoryModel>(this as CallHistoryModel, _$identity);

  /// Serializes this CallHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,callerId,callerName,callerAvatar,callType,status,createdAt,durationSeconds);

@override
String toString() {
  return 'CallHistoryModel(id: $id, conversationId: $conversationId, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, callType: $callType, status: $status, createdAt: $createdAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class $CallHistoryModelCopyWith<$Res>  {
  factory $CallHistoryModelCopyWith(CallHistoryModel value, $Res Function(CallHistoryModel) _then) = _$CallHistoryModelCopyWithImpl;
@useResult
$Res call({
 String? id, int? conversationId, int? callerId, String? callerName, String? callerAvatar, String? callType, String? status, String? createdAt, int? durationSeconds
});




}
/// @nodoc
class _$CallHistoryModelCopyWithImpl<$Res>
    implements $CallHistoryModelCopyWith<$Res> {
  _$CallHistoryModelCopyWithImpl(this._self, this._then);

  final CallHistoryModel _self;
  final $Res Function(CallHistoryModel) _then;

/// Create a copy of CallHistoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? conversationId = freezed,Object? callerId = freezed,Object? callerName = freezed,Object? callerAvatar = freezed,Object? callType = freezed,Object? status = freezed,Object? createdAt = freezed,Object? durationSeconds = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int?,callerId: freezed == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as int?,callerName: freezed == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String?,callerAvatar: freezed == callerAvatar ? _self.callerAvatar : callerAvatar // ignore: cast_nullable_to_non_nullable
as String?,callType: freezed == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallHistoryModel].
extension CallHistoryModelPatterns on CallHistoryModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallHistoryModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _CallHistoryModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _CallHistoryModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  int? conversationId,  int? callerId,  String? callerName,  String? callerAvatar,  String? callType,  String? status,  String? createdAt,  int? durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallHistoryModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.callerId,_that.callerName,_that.callerAvatar,_that.callType,_that.status,_that.createdAt,_that.durationSeconds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  int? conversationId,  int? callerId,  String? callerName,  String? callerAvatar,  String? callType,  String? status,  String? createdAt,  int? durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _CallHistoryModel():
return $default(_that.id,_that.conversationId,_that.callerId,_that.callerName,_that.callerAvatar,_that.callType,_that.status,_that.createdAt,_that.durationSeconds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  int? conversationId,  int? callerId,  String? callerName,  String? callerAvatar,  String? callType,  String? status,  String? createdAt,  int? durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _CallHistoryModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.callerId,_that.callerName,_that.callerAvatar,_that.callType,_that.status,_that.createdAt,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallHistoryModel extends CallHistoryModel {
  const _CallHistoryModel({this.id, this.conversationId, this.callerId, this.callerName, this.callerAvatar, this.callType, this.status, this.createdAt, this.durationSeconds}): super._();
  factory _CallHistoryModel.fromJson(Map<String, dynamic> json) => _$CallHistoryModelFromJson(json);

@override final  String? id;
// Changed from callId
@override final  int? conversationId;
@override final  int? callerId;
// NEW - to determine incoming/outgoing
@override final  String? callerName;
// Changed from participantName
@override final  String? callerAvatar;
// Changed from participantAvatar
@override final  String? callType;
@override final  String? status;
// NEW - to determine if missed
@override final  String? createdAt;
// Changed from timestamp (String in API)
@override final  int? durationSeconds;

/// Create a copy of CallHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallHistoryModelCopyWith<_CallHistoryModel> get copyWith => __$CallHistoryModelCopyWithImpl<_CallHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.callerId, callerId) || other.callerId == callerId)&&(identical(other.callerName, callerName) || other.callerName == callerName)&&(identical(other.callerAvatar, callerAvatar) || other.callerAvatar == callerAvatar)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,callerId,callerName,callerAvatar,callType,status,createdAt,durationSeconds);

@override
String toString() {
  return 'CallHistoryModel(id: $id, conversationId: $conversationId, callerId: $callerId, callerName: $callerName, callerAvatar: $callerAvatar, callType: $callType, status: $status, createdAt: $createdAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$CallHistoryModelCopyWith<$Res> implements $CallHistoryModelCopyWith<$Res> {
  factory _$CallHistoryModelCopyWith(_CallHistoryModel value, $Res Function(_CallHistoryModel) _then) = __$CallHistoryModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, int? conversationId, int? callerId, String? callerName, String? callerAvatar, String? callType, String? status, String? createdAt, int? durationSeconds
});




}
/// @nodoc
class __$CallHistoryModelCopyWithImpl<$Res>
    implements _$CallHistoryModelCopyWith<$Res> {
  __$CallHistoryModelCopyWithImpl(this._self, this._then);

  final _CallHistoryModel _self;
  final $Res Function(_CallHistoryModel) _then;

/// Create a copy of CallHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? conversationId = freezed,Object? callerId = freezed,Object? callerName = freezed,Object? callerAvatar = freezed,Object? callType = freezed,Object? status = freezed,Object? createdAt = freezed,Object? durationSeconds = freezed,}) {
  return _then(_CallHistoryModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int?,callerId: freezed == callerId ? _self.callerId : callerId // ignore: cast_nullable_to_non_nullable
as int?,callerName: freezed == callerName ? _self.callerName : callerName // ignore: cast_nullable_to_non_nullable
as String?,callerAvatar: freezed == callerAvatar ? _self.callerAvatar : callerAvatar // ignore: cast_nullable_to_non_nullable
as String?,callType: freezed == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
