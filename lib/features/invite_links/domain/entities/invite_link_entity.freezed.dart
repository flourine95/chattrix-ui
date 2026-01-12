// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_link_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InviteLinkEntity {

 int get id; String get token; int get conversationId; int get createdBy; String get createdByUsername; DateTime get createdAt; DateTime? get expiresAt; int? get maxUses; int get currentUses; bool get revoked; DateTime? get revokedAt; int? get revokedBy; bool get valid;
/// Create a copy of InviteLinkEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinkEntityCopyWith<InviteLinkEntity> get copyWith => _$InviteLinkEntityCopyWithImpl<InviteLinkEntity>(this as InviteLinkEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinkEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.revokedBy, revokedBy) || other.revokedBy == revokedBy)&&(identical(other.valid, valid) || other.valid == valid));
}


@override
int get hashCode => Object.hash(runtimeType,id,token,conversationId,createdBy,createdByUsername,createdAt,expiresAt,maxUses,currentUses,revoked,revokedAt,revokedBy,valid);

@override
String toString() {
  return 'InviteLinkEntity(id: $id, token: $token, conversationId: $conversationId, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt, expiresAt: $expiresAt, maxUses: $maxUses, currentUses: $currentUses, revoked: $revoked, revokedAt: $revokedAt, revokedBy: $revokedBy, valid: $valid)';
}


}

/// @nodoc
abstract mixin class $InviteLinkEntityCopyWith<$Res>  {
  factory $InviteLinkEntityCopyWith(InviteLinkEntity value, $Res Function(InviteLinkEntity) _then) = _$InviteLinkEntityCopyWithImpl;
@useResult
$Res call({
 int id, String token, int conversationId, int createdBy, String createdByUsername, DateTime createdAt, DateTime? expiresAt, int? maxUses, int currentUses, bool revoked, DateTime? revokedAt, int? revokedBy, bool valid
});




}
/// @nodoc
class _$InviteLinkEntityCopyWithImpl<$Res>
    implements $InviteLinkEntityCopyWith<$Res> {
  _$InviteLinkEntityCopyWithImpl(this._self, this._then);

  final InviteLinkEntity _self;
  final $Res Function(InviteLinkEntity) _then;

/// Create a copy of InviteLinkEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? token = null,Object? conversationId = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdAt = null,Object? expiresAt = freezed,Object? maxUses = freezed,Object? currentUses = null,Object? revoked = null,Object? revokedAt = freezed,Object? revokedBy = freezed,Object? valid = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,currentUses: null == currentUses ? _self.currentUses : currentUses // ignore: cast_nullable_to_non_nullable
as int,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedBy: freezed == revokedBy ? _self.revokedBy : revokedBy // ignore: cast_nullable_to_non_nullable
as int?,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteLinkEntity].
extension InviteLinkEntityPatterns on InviteLinkEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinkEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinkEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinkEntity value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinkEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinkEntity value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinkEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String token,  int conversationId,  int createdBy,  String createdByUsername,  DateTime createdAt,  DateTime? expiresAt,  int? maxUses,  int currentUses,  bool revoked,  DateTime? revokedAt,  int? revokedBy,  bool valid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteLinkEntity() when $default != null:
return $default(_that.id,_that.token,_that.conversationId,_that.createdBy,_that.createdByUsername,_that.createdAt,_that.expiresAt,_that.maxUses,_that.currentUses,_that.revoked,_that.revokedAt,_that.revokedBy,_that.valid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String token,  int conversationId,  int createdBy,  String createdByUsername,  DateTime createdAt,  DateTime? expiresAt,  int? maxUses,  int currentUses,  bool revoked,  DateTime? revokedAt,  int? revokedBy,  bool valid)  $default,) {final _that = this;
switch (_that) {
case _InviteLinkEntity():
return $default(_that.id,_that.token,_that.conversationId,_that.createdBy,_that.createdByUsername,_that.createdAt,_that.expiresAt,_that.maxUses,_that.currentUses,_that.revoked,_that.revokedAt,_that.revokedBy,_that.valid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String token,  int conversationId,  int createdBy,  String createdByUsername,  DateTime createdAt,  DateTime? expiresAt,  int? maxUses,  int currentUses,  bool revoked,  DateTime? revokedAt,  int? revokedBy,  bool valid)?  $default,) {final _that = this;
switch (_that) {
case _InviteLinkEntity() when $default != null:
return $default(_that.id,_that.token,_that.conversationId,_that.createdBy,_that.createdByUsername,_that.createdAt,_that.expiresAt,_that.maxUses,_that.currentUses,_that.revoked,_that.revokedAt,_that.revokedBy,_that.valid);case _:
  return null;

}
}

}

/// @nodoc


class _InviteLinkEntity extends InviteLinkEntity {
  const _InviteLinkEntity({required this.id, required this.token, required this.conversationId, required this.createdBy, required this.createdByUsername, required this.createdAt, this.expiresAt, this.maxUses, required this.currentUses, required this.revoked, this.revokedAt, this.revokedBy, required this.valid}): super._();
  

@override final  int id;
@override final  String token;
@override final  int conversationId;
@override final  int createdBy;
@override final  String createdByUsername;
@override final  DateTime createdAt;
@override final  DateTime? expiresAt;
@override final  int? maxUses;
@override final  int currentUses;
@override final  bool revoked;
@override final  DateTime? revokedAt;
@override final  int? revokedBy;
@override final  bool valid;

/// Create a copy of InviteLinkEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinkEntityCopyWith<_InviteLinkEntity> get copyWith => __$InviteLinkEntityCopyWithImpl<_InviteLinkEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinkEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.revokedBy, revokedBy) || other.revokedBy == revokedBy)&&(identical(other.valid, valid) || other.valid == valid));
}


@override
int get hashCode => Object.hash(runtimeType,id,token,conversationId,createdBy,createdByUsername,createdAt,expiresAt,maxUses,currentUses,revoked,revokedAt,revokedBy,valid);

@override
String toString() {
  return 'InviteLinkEntity(id: $id, token: $token, conversationId: $conversationId, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt, expiresAt: $expiresAt, maxUses: $maxUses, currentUses: $currentUses, revoked: $revoked, revokedAt: $revokedAt, revokedBy: $revokedBy, valid: $valid)';
}


}

/// @nodoc
abstract mixin class _$InviteLinkEntityCopyWith<$Res> implements $InviteLinkEntityCopyWith<$Res> {
  factory _$InviteLinkEntityCopyWith(_InviteLinkEntity value, $Res Function(_InviteLinkEntity) _then) = __$InviteLinkEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String token, int conversationId, int createdBy, String createdByUsername, DateTime createdAt, DateTime? expiresAt, int? maxUses, int currentUses, bool revoked, DateTime? revokedAt, int? revokedBy, bool valid
});




}
/// @nodoc
class __$InviteLinkEntityCopyWithImpl<$Res>
    implements _$InviteLinkEntityCopyWith<$Res> {
  __$InviteLinkEntityCopyWithImpl(this._self, this._then);

  final _InviteLinkEntity _self;
  final $Res Function(_InviteLinkEntity) _then;

/// Create a copy of InviteLinkEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? token = null,Object? conversationId = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdAt = null,Object? expiresAt = freezed,Object? maxUses = freezed,Object? currentUses = null,Object? revoked = null,Object? revokedAt = freezed,Object? revokedBy = freezed,Object? valid = null,}) {
  return _then(_InviteLinkEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,currentUses: null == currentUses ? _self.currentUses : currentUses // ignore: cast_nullable_to_non_nullable
as int,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedBy: freezed == revokedBy ? _self.revokedBy : revokedBy // ignore: cast_nullable_to_non_nullable
as int?,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$InviteLinkInfoEntity {

 String get token; int get groupId; String get groupName; int get memberCount; bool get valid; DateTime? get expiresAt; int get createdBy; String get createdByUsername; String get createdByFullName; int? get maxUses; int get usesCount; bool get revoked; String? get groupAvatar;
/// Create a copy of InviteLinkInfoEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinkInfoEntityCopyWith<InviteLinkInfoEntity> get copyWith => _$InviteLinkInfoEntityCopyWithImpl<InviteLinkInfoEntity>(this as InviteLinkInfoEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinkInfoEntity&&(identical(other.token, token) || other.token == token)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdByFullName, createdByFullName) || other.createdByFullName == createdByFullName)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.usesCount, usesCount) || other.usesCount == usesCount)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.groupAvatar, groupAvatar) || other.groupAvatar == groupAvatar));
}


@override
int get hashCode => Object.hash(runtimeType,token,groupId,groupName,memberCount,valid,expiresAt,createdBy,createdByUsername,createdByFullName,maxUses,usesCount,revoked,groupAvatar);

@override
String toString() {
  return 'InviteLinkInfoEntity(token: $token, groupId: $groupId, groupName: $groupName, memberCount: $memberCount, valid: $valid, expiresAt: $expiresAt, createdBy: $createdBy, createdByUsername: $createdByUsername, createdByFullName: $createdByFullName, maxUses: $maxUses, usesCount: $usesCount, revoked: $revoked, groupAvatar: $groupAvatar)';
}


}

/// @nodoc
abstract mixin class $InviteLinkInfoEntityCopyWith<$Res>  {
  factory $InviteLinkInfoEntityCopyWith(InviteLinkInfoEntity value, $Res Function(InviteLinkInfoEntity) _then) = _$InviteLinkInfoEntityCopyWithImpl;
@useResult
$Res call({
 String token, int groupId, String groupName, int memberCount, bool valid, DateTime? expiresAt, int createdBy, String createdByUsername, String createdByFullName, int? maxUses, int usesCount, bool revoked, String? groupAvatar
});




}
/// @nodoc
class _$InviteLinkInfoEntityCopyWithImpl<$Res>
    implements $InviteLinkInfoEntityCopyWith<$Res> {
  _$InviteLinkInfoEntityCopyWithImpl(this._self, this._then);

  final InviteLinkInfoEntity _self;
  final $Res Function(InviteLinkInfoEntity) _then;

/// Create a copy of InviteLinkInfoEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? groupId = null,Object? groupName = null,Object? memberCount = null,Object? valid = null,Object? expiresAt = freezed,Object? createdBy = null,Object? createdByUsername = null,Object? createdByFullName = null,Object? maxUses = freezed,Object? usesCount = null,Object? revoked = null,Object? groupAvatar = freezed,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdByFullName: null == createdByFullName ? _self.createdByFullName : createdByFullName // ignore: cast_nullable_to_non_nullable
as String,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,usesCount: null == usesCount ? _self.usesCount : usesCount // ignore: cast_nullable_to_non_nullable
as int,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,groupAvatar: freezed == groupAvatar ? _self.groupAvatar : groupAvatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteLinkInfoEntity].
extension InviteLinkInfoEntityPatterns on InviteLinkInfoEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinkInfoEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinkInfoEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinkInfoEntity value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinkInfoEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinkInfoEntity value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinkInfoEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  int groupId,  String groupName,  int memberCount,  bool valid,  DateTime? expiresAt,  int createdBy,  String createdByUsername,  String createdByFullName,  int? maxUses,  int usesCount,  bool revoked,  String? groupAvatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteLinkInfoEntity() when $default != null:
return $default(_that.token,_that.groupId,_that.groupName,_that.memberCount,_that.valid,_that.expiresAt,_that.createdBy,_that.createdByUsername,_that.createdByFullName,_that.maxUses,_that.usesCount,_that.revoked,_that.groupAvatar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  int groupId,  String groupName,  int memberCount,  bool valid,  DateTime? expiresAt,  int createdBy,  String createdByUsername,  String createdByFullName,  int? maxUses,  int usesCount,  bool revoked,  String? groupAvatar)  $default,) {final _that = this;
switch (_that) {
case _InviteLinkInfoEntity():
return $default(_that.token,_that.groupId,_that.groupName,_that.memberCount,_that.valid,_that.expiresAt,_that.createdBy,_that.createdByUsername,_that.createdByFullName,_that.maxUses,_that.usesCount,_that.revoked,_that.groupAvatar);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  int groupId,  String groupName,  int memberCount,  bool valid,  DateTime? expiresAt,  int createdBy,  String createdByUsername,  String createdByFullName,  int? maxUses,  int usesCount,  bool revoked,  String? groupAvatar)?  $default,) {final _that = this;
switch (_that) {
case _InviteLinkInfoEntity() when $default != null:
return $default(_that.token,_that.groupId,_that.groupName,_that.memberCount,_that.valid,_that.expiresAt,_that.createdBy,_that.createdByUsername,_that.createdByFullName,_that.maxUses,_that.usesCount,_that.revoked,_that.groupAvatar);case _:
  return null;

}
}

}

/// @nodoc


class _InviteLinkInfoEntity extends InviteLinkInfoEntity {
  const _InviteLinkInfoEntity({required this.token, required this.groupId, required this.groupName, required this.memberCount, required this.valid, this.expiresAt, required this.createdBy, required this.createdByUsername, required this.createdByFullName, this.maxUses, this.usesCount = 0, this.revoked = false, this.groupAvatar}): super._();
  

@override final  String token;
@override final  int groupId;
@override final  String groupName;
@override final  int memberCount;
@override final  bool valid;
@override final  DateTime? expiresAt;
@override final  int createdBy;
@override final  String createdByUsername;
@override final  String createdByFullName;
@override final  int? maxUses;
@override@JsonKey() final  int usesCount;
@override@JsonKey() final  bool revoked;
@override final  String? groupAvatar;

/// Create a copy of InviteLinkInfoEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinkInfoEntityCopyWith<_InviteLinkInfoEntity> get copyWith => __$InviteLinkInfoEntityCopyWithImpl<_InviteLinkInfoEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinkInfoEntity&&(identical(other.token, token) || other.token == token)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdByFullName, createdByFullName) || other.createdByFullName == createdByFullName)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.usesCount, usesCount) || other.usesCount == usesCount)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.groupAvatar, groupAvatar) || other.groupAvatar == groupAvatar));
}


@override
int get hashCode => Object.hash(runtimeType,token,groupId,groupName,memberCount,valid,expiresAt,createdBy,createdByUsername,createdByFullName,maxUses,usesCount,revoked,groupAvatar);

@override
String toString() {
  return 'InviteLinkInfoEntity(token: $token, groupId: $groupId, groupName: $groupName, memberCount: $memberCount, valid: $valid, expiresAt: $expiresAt, createdBy: $createdBy, createdByUsername: $createdByUsername, createdByFullName: $createdByFullName, maxUses: $maxUses, usesCount: $usesCount, revoked: $revoked, groupAvatar: $groupAvatar)';
}


}

/// @nodoc
abstract mixin class _$InviteLinkInfoEntityCopyWith<$Res> implements $InviteLinkInfoEntityCopyWith<$Res> {
  factory _$InviteLinkInfoEntityCopyWith(_InviteLinkInfoEntity value, $Res Function(_InviteLinkInfoEntity) _then) = __$InviteLinkInfoEntityCopyWithImpl;
@override @useResult
$Res call({
 String token, int groupId, String groupName, int memberCount, bool valid, DateTime? expiresAt, int createdBy, String createdByUsername, String createdByFullName, int? maxUses, int usesCount, bool revoked, String? groupAvatar
});




}
/// @nodoc
class __$InviteLinkInfoEntityCopyWithImpl<$Res>
    implements _$InviteLinkInfoEntityCopyWith<$Res> {
  __$InviteLinkInfoEntityCopyWithImpl(this._self, this._then);

  final _InviteLinkInfoEntity _self;
  final $Res Function(_InviteLinkInfoEntity) _then;

/// Create a copy of InviteLinkInfoEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? groupId = null,Object? groupName = null,Object? memberCount = null,Object? valid = null,Object? expiresAt = freezed,Object? createdBy = null,Object? createdByUsername = null,Object? createdByFullName = null,Object? maxUses = freezed,Object? usesCount = null,Object? revoked = null,Object? groupAvatar = freezed,}) {
  return _then(_InviteLinkInfoEntity(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdByFullName: null == createdByFullName ? _self.createdByFullName : createdByFullName // ignore: cast_nullable_to_non_nullable
as String,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,usesCount: null == usesCount ? _self.usesCount : usesCount // ignore: cast_nullable_to_non_nullable
as int,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,groupAvatar: freezed == groupAvatar ? _self.groupAvatar : groupAvatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$JoinGroupResultEntity {

 bool get success; int get conversationId; String get message; String? get groupName;
/// Create a copy of JoinGroupResultEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinGroupResultEntityCopyWith<JoinGroupResultEntity> get copyWith => _$JoinGroupResultEntityCopyWithImpl<JoinGroupResultEntity>(this as JoinGroupResultEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinGroupResultEntity&&(identical(other.success, success) || other.success == success)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.message, message) || other.message == message)&&(identical(other.groupName, groupName) || other.groupName == groupName));
}


@override
int get hashCode => Object.hash(runtimeType,success,conversationId,message,groupName);

@override
String toString() {
  return 'JoinGroupResultEntity(success: $success, conversationId: $conversationId, message: $message, groupName: $groupName)';
}


}

/// @nodoc
abstract mixin class $JoinGroupResultEntityCopyWith<$Res>  {
  factory $JoinGroupResultEntityCopyWith(JoinGroupResultEntity value, $Res Function(JoinGroupResultEntity) _then) = _$JoinGroupResultEntityCopyWithImpl;
@useResult
$Res call({
 bool success, int conversationId, String message, String? groupName
});




}
/// @nodoc
class _$JoinGroupResultEntityCopyWithImpl<$Res>
    implements $JoinGroupResultEntityCopyWith<$Res> {
  _$JoinGroupResultEntityCopyWithImpl(this._self, this._then);

  final JoinGroupResultEntity _self;
  final $Res Function(JoinGroupResultEntity) _then;

/// Create a copy of JoinGroupResultEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? conversationId = null,Object? message = null,Object? groupName = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JoinGroupResultEntity].
extension JoinGroupResultEntityPatterns on JoinGroupResultEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinGroupResultEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinGroupResultEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinGroupResultEntity value)  $default,){
final _that = this;
switch (_that) {
case _JoinGroupResultEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinGroupResultEntity value)?  $default,){
final _that = this;
switch (_that) {
case _JoinGroupResultEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  int conversationId,  String message,  String? groupName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JoinGroupResultEntity() when $default != null:
return $default(_that.success,_that.conversationId,_that.message,_that.groupName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  int conversationId,  String message,  String? groupName)  $default,) {final _that = this;
switch (_that) {
case _JoinGroupResultEntity():
return $default(_that.success,_that.conversationId,_that.message,_that.groupName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  int conversationId,  String message,  String? groupName)?  $default,) {final _that = this;
switch (_that) {
case _JoinGroupResultEntity() when $default != null:
return $default(_that.success,_that.conversationId,_that.message,_that.groupName);case _:
  return null;

}
}

}

/// @nodoc


class _JoinGroupResultEntity implements JoinGroupResultEntity {
  const _JoinGroupResultEntity({required this.success, required this.conversationId, required this.message, this.groupName});
  

@override final  bool success;
@override final  int conversationId;
@override final  String message;
@override final  String? groupName;

/// Create a copy of JoinGroupResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinGroupResultEntityCopyWith<_JoinGroupResultEntity> get copyWith => __$JoinGroupResultEntityCopyWithImpl<_JoinGroupResultEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinGroupResultEntity&&(identical(other.success, success) || other.success == success)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.message, message) || other.message == message)&&(identical(other.groupName, groupName) || other.groupName == groupName));
}


@override
int get hashCode => Object.hash(runtimeType,success,conversationId,message,groupName);

@override
String toString() {
  return 'JoinGroupResultEntity(success: $success, conversationId: $conversationId, message: $message, groupName: $groupName)';
}


}

/// @nodoc
abstract mixin class _$JoinGroupResultEntityCopyWith<$Res> implements $JoinGroupResultEntityCopyWith<$Res> {
  factory _$JoinGroupResultEntityCopyWith(_JoinGroupResultEntity value, $Res Function(_JoinGroupResultEntity) _then) = __$JoinGroupResultEntityCopyWithImpl;
@override @useResult
$Res call({
 bool success, int conversationId, String message, String? groupName
});




}
/// @nodoc
class __$JoinGroupResultEntityCopyWithImpl<$Res>
    implements _$JoinGroupResultEntityCopyWith<$Res> {
  __$JoinGroupResultEntityCopyWithImpl(this._self, this._then);

  final _JoinGroupResultEntity _self;
  final $Res Function(_JoinGroupResultEntity) _then;

/// Create a copy of JoinGroupResultEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? conversationId = null,Object? message = null,Object? groupName = freezed,}) {
  return _then(_JoinGroupResultEntity(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
