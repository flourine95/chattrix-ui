// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InviteLink {

 int get id; String get token; int get conversationId; int get createdBy; String get createdByUsername; DateTime get createdAt; int? get maxUses; int get currentUses; bool get revoked; DateTime? get revokedAt; int? get revokedBy; bool get valid;
/// Create a copy of InviteLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinkCopyWith<InviteLink> get copyWith => _$InviteLinkCopyWithImpl<InviteLink>(this as InviteLink, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLink&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.revokedBy, revokedBy) || other.revokedBy == revokedBy)&&(identical(other.valid, valid) || other.valid == valid));
}


@override
int get hashCode => Object.hash(runtimeType,id,token,conversationId,createdBy,createdByUsername,createdAt,maxUses,currentUses,revoked,revokedAt,revokedBy,valid);

@override
String toString() {
  return 'InviteLink(id: $id, token: $token, conversationId: $conversationId, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt, maxUses: $maxUses, currentUses: $currentUses, revoked: $revoked, revokedAt: $revokedAt, revokedBy: $revokedBy, valid: $valid)';
}


}

/// @nodoc
abstract mixin class $InviteLinkCopyWith<$Res>  {
  factory $InviteLinkCopyWith(InviteLink value, $Res Function(InviteLink) _then) = _$InviteLinkCopyWithImpl;
@useResult
$Res call({
 int id, String token, int conversationId, int createdBy, String createdByUsername, DateTime createdAt, int? maxUses, int currentUses, bool revoked, DateTime? revokedAt, int? revokedBy, bool valid
});




}
/// @nodoc
class _$InviteLinkCopyWithImpl<$Res>
    implements $InviteLinkCopyWith<$Res> {
  _$InviteLinkCopyWithImpl(this._self, this._then);

  final InviteLink _self;
  final $Res Function(InviteLink) _then;

/// Create a copy of InviteLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? token = null,Object? conversationId = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdAt = null,Object? maxUses = freezed,Object? currentUses = null,Object? revoked = null,Object? revokedAt = freezed,Object? revokedBy = freezed,Object? valid = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,currentUses: null == currentUses ? _self.currentUses : currentUses // ignore: cast_nullable_to_non_nullable
as int,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revokedBy: freezed == revokedBy ? _self.revokedBy : revokedBy // ignore: cast_nullable_to_non_nullable
as int?,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteLink].
extension InviteLinkPatterns on InviteLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLink value)  $default,){
final _that = this;
switch (_that) {
case _InviteLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLink value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String token,  int conversationId,  int createdBy,  String createdByUsername,  DateTime createdAt,  int? maxUses,  int currentUses,  bool revoked,  DateTime? revokedAt,  int? revokedBy,  bool valid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteLink() when $default != null:
return $default(_that.id,_that.token,_that.conversationId,_that.createdBy,_that.createdByUsername,_that.createdAt,_that.maxUses,_that.currentUses,_that.revoked,_that.revokedAt,_that.revokedBy,_that.valid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String token,  int conversationId,  int createdBy,  String createdByUsername,  DateTime createdAt,  int? maxUses,  int currentUses,  bool revoked,  DateTime? revokedAt,  int? revokedBy,  bool valid)  $default,) {final _that = this;
switch (_that) {
case _InviteLink():
return $default(_that.id,_that.token,_that.conversationId,_that.createdBy,_that.createdByUsername,_that.createdAt,_that.maxUses,_that.currentUses,_that.revoked,_that.revokedAt,_that.revokedBy,_that.valid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String token,  int conversationId,  int createdBy,  String createdByUsername,  DateTime createdAt,  int? maxUses,  int currentUses,  bool revoked,  DateTime? revokedAt,  int? revokedBy,  bool valid)?  $default,) {final _that = this;
switch (_that) {
case _InviteLink() when $default != null:
return $default(_that.id,_that.token,_that.conversationId,_that.createdBy,_that.createdByUsername,_that.createdAt,_that.maxUses,_that.currentUses,_that.revoked,_that.revokedAt,_that.revokedBy,_that.valid);case _:
  return null;

}
}

}

/// @nodoc


class _InviteLink implements InviteLink {
  const _InviteLink({required this.id, required this.token, required this.conversationId, required this.createdBy, required this.createdByUsername, required this.createdAt, this.maxUses, required this.currentUses, required this.revoked, this.revokedAt, this.revokedBy, required this.valid});
  

@override final  int id;
@override final  String token;
@override final  int conversationId;
@override final  int createdBy;
@override final  String createdByUsername;
@override final  DateTime createdAt;
@override final  int? maxUses;
@override final  int currentUses;
@override final  bool revoked;
@override final  DateTime? revokedAt;
@override final  int? revokedBy;
@override final  bool valid;

/// Create a copy of InviteLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinkCopyWith<_InviteLink> get copyWith => __$InviteLinkCopyWithImpl<_InviteLink>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLink&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.revokedBy, revokedBy) || other.revokedBy == revokedBy)&&(identical(other.valid, valid) || other.valid == valid));
}


@override
int get hashCode => Object.hash(runtimeType,id,token,conversationId,createdBy,createdByUsername,createdAt,maxUses,currentUses,revoked,revokedAt,revokedBy,valid);

@override
String toString() {
  return 'InviteLink(id: $id, token: $token, conversationId: $conversationId, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt, maxUses: $maxUses, currentUses: $currentUses, revoked: $revoked, revokedAt: $revokedAt, revokedBy: $revokedBy, valid: $valid)';
}


}

/// @nodoc
abstract mixin class _$InviteLinkCopyWith<$Res> implements $InviteLinkCopyWith<$Res> {
  factory _$InviteLinkCopyWith(_InviteLink value, $Res Function(_InviteLink) _then) = __$InviteLinkCopyWithImpl;
@override @useResult
$Res call({
 int id, String token, int conversationId, int createdBy, String createdByUsername, DateTime createdAt, int? maxUses, int currentUses, bool revoked, DateTime? revokedAt, int? revokedBy, bool valid
});




}
/// @nodoc
class __$InviteLinkCopyWithImpl<$Res>
    implements _$InviteLinkCopyWith<$Res> {
  __$InviteLinkCopyWithImpl(this._self, this._then);

  final _InviteLink _self;
  final $Res Function(_InviteLink) _then;

/// Create a copy of InviteLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? token = null,Object? conversationId = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdAt = null,Object? maxUses = freezed,Object? currentUses = null,Object? revoked = null,Object? revokedAt = freezed,Object? revokedBy = freezed,Object? valid = null,}) {
  return _then(_InviteLink(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
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
mixin _$InviteLinkInfo {

 String get token; int get groupId; int get memberCount; bool get valid; int get createdBy; String get createdByUsername; String get createdByFullName;
/// Create a copy of InviteLinkInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinkInfoCopyWith<InviteLinkInfo> get copyWith => _$InviteLinkInfoCopyWithImpl<InviteLinkInfo>(this as InviteLinkInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinkInfo&&(identical(other.token, token) || other.token == token)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdByFullName, createdByFullName) || other.createdByFullName == createdByFullName));
}


@override
int get hashCode => Object.hash(runtimeType,token,groupId,memberCount,valid,createdBy,createdByUsername,createdByFullName);

@override
String toString() {
  return 'InviteLinkInfo(token: $token, groupId: $groupId, memberCount: $memberCount, valid: $valid, createdBy: $createdBy, createdByUsername: $createdByUsername, createdByFullName: $createdByFullName)';
}


}

/// @nodoc
abstract mixin class $InviteLinkInfoCopyWith<$Res>  {
  factory $InviteLinkInfoCopyWith(InviteLinkInfo value, $Res Function(InviteLinkInfo) _then) = _$InviteLinkInfoCopyWithImpl;
@useResult
$Res call({
 String token, int groupId, int memberCount, bool valid, int createdBy, String createdByUsername, String createdByFullName
});




}
/// @nodoc
class _$InviteLinkInfoCopyWithImpl<$Res>
    implements $InviteLinkInfoCopyWith<$Res> {
  _$InviteLinkInfoCopyWithImpl(this._self, this._then);

  final InviteLinkInfo _self;
  final $Res Function(InviteLinkInfo) _then;

/// Create a copy of InviteLinkInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? groupId = null,Object? memberCount = null,Object? valid = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdByFullName = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdByFullName: null == createdByFullName ? _self.createdByFullName : createdByFullName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteLinkInfo].
extension InviteLinkInfoPatterns on InviteLinkInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinkInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinkInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinkInfo value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinkInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinkInfo value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinkInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  int groupId,  int memberCount,  bool valid,  int createdBy,  String createdByUsername,  String createdByFullName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteLinkInfo() when $default != null:
return $default(_that.token,_that.groupId,_that.memberCount,_that.valid,_that.createdBy,_that.createdByUsername,_that.createdByFullName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  int groupId,  int memberCount,  bool valid,  int createdBy,  String createdByUsername,  String createdByFullName)  $default,) {final _that = this;
switch (_that) {
case _InviteLinkInfo():
return $default(_that.token,_that.groupId,_that.memberCount,_that.valid,_that.createdBy,_that.createdByUsername,_that.createdByFullName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  int groupId,  int memberCount,  bool valid,  int createdBy,  String createdByUsername,  String createdByFullName)?  $default,) {final _that = this;
switch (_that) {
case _InviteLinkInfo() when $default != null:
return $default(_that.token,_that.groupId,_that.memberCount,_that.valid,_that.createdBy,_that.createdByUsername,_that.createdByFullName);case _:
  return null;

}
}

}

/// @nodoc


class _InviteLinkInfo implements InviteLinkInfo {
  const _InviteLinkInfo({required this.token, required this.groupId, required this.memberCount, required this.valid, required this.createdBy, required this.createdByUsername, required this.createdByFullName});
  

@override final  String token;
@override final  int groupId;
@override final  int memberCount;
@override final  bool valid;
@override final  int createdBy;
@override final  String createdByUsername;
@override final  String createdByFullName;

/// Create a copy of InviteLinkInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinkInfoCopyWith<_InviteLinkInfo> get copyWith => __$InviteLinkInfoCopyWithImpl<_InviteLinkInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinkInfo&&(identical(other.token, token) || other.token == token)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdByFullName, createdByFullName) || other.createdByFullName == createdByFullName));
}


@override
int get hashCode => Object.hash(runtimeType,token,groupId,memberCount,valid,createdBy,createdByUsername,createdByFullName);

@override
String toString() {
  return 'InviteLinkInfo(token: $token, groupId: $groupId, memberCount: $memberCount, valid: $valid, createdBy: $createdBy, createdByUsername: $createdByUsername, createdByFullName: $createdByFullName)';
}


}

/// @nodoc
abstract mixin class _$InviteLinkInfoCopyWith<$Res> implements $InviteLinkInfoCopyWith<$Res> {
  factory _$InviteLinkInfoCopyWith(_InviteLinkInfo value, $Res Function(_InviteLinkInfo) _then) = __$InviteLinkInfoCopyWithImpl;
@override @useResult
$Res call({
 String token, int groupId, int memberCount, bool valid, int createdBy, String createdByUsername, String createdByFullName
});




}
/// @nodoc
class __$InviteLinkInfoCopyWithImpl<$Res>
    implements _$InviteLinkInfoCopyWith<$Res> {
  __$InviteLinkInfoCopyWithImpl(this._self, this._then);

  final _InviteLinkInfo _self;
  final $Res Function(_InviteLinkInfo) _then;

/// Create a copy of InviteLinkInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? groupId = null,Object? memberCount = null,Object? valid = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdByFullName = null,}) {
  return _then(_InviteLinkInfo(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: null == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String,createdByFullName: null == createdByFullName ? _self.createdByFullName : createdByFullName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$JoinViaInviteLink {

 bool get success; int get conversationId; String get message;
/// Create a copy of JoinViaInviteLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinViaInviteLinkCopyWith<JoinViaInviteLink> get copyWith => _$JoinViaInviteLinkCopyWithImpl<JoinViaInviteLink>(this as JoinViaInviteLink, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinViaInviteLink&&(identical(other.success, success) || other.success == success)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,success,conversationId,message);

@override
String toString() {
  return 'JoinViaInviteLink(success: $success, conversationId: $conversationId, message: $message)';
}


}

/// @nodoc
abstract mixin class $JoinViaInviteLinkCopyWith<$Res>  {
  factory $JoinViaInviteLinkCopyWith(JoinViaInviteLink value, $Res Function(JoinViaInviteLink) _then) = _$JoinViaInviteLinkCopyWithImpl;
@useResult
$Res call({
 bool success, int conversationId, String message
});




}
/// @nodoc
class _$JoinViaInviteLinkCopyWithImpl<$Res>
    implements $JoinViaInviteLinkCopyWith<$Res> {
  _$JoinViaInviteLinkCopyWithImpl(this._self, this._then);

  final JoinViaInviteLink _self;
  final $Res Function(JoinViaInviteLink) _then;

/// Create a copy of JoinViaInviteLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? conversationId = null,Object? message = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JoinViaInviteLink].
extension JoinViaInviteLinkPatterns on JoinViaInviteLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinViaInviteLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinViaInviteLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinViaInviteLink value)  $default,){
final _that = this;
switch (_that) {
case _JoinViaInviteLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinViaInviteLink value)?  $default,){
final _that = this;
switch (_that) {
case _JoinViaInviteLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  int conversationId,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JoinViaInviteLink() when $default != null:
return $default(_that.success,_that.conversationId,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  int conversationId,  String message)  $default,) {final _that = this;
switch (_that) {
case _JoinViaInviteLink():
return $default(_that.success,_that.conversationId,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  int conversationId,  String message)?  $default,) {final _that = this;
switch (_that) {
case _JoinViaInviteLink() when $default != null:
return $default(_that.success,_that.conversationId,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _JoinViaInviteLink implements JoinViaInviteLink {
  const _JoinViaInviteLink({required this.success, required this.conversationId, required this.message});
  

@override final  bool success;
@override final  int conversationId;
@override final  String message;

/// Create a copy of JoinViaInviteLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinViaInviteLinkCopyWith<_JoinViaInviteLink> get copyWith => __$JoinViaInviteLinkCopyWithImpl<_JoinViaInviteLink>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinViaInviteLink&&(identical(other.success, success) || other.success == success)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,success,conversationId,message);

@override
String toString() {
  return 'JoinViaInviteLink(success: $success, conversationId: $conversationId, message: $message)';
}


}

/// @nodoc
abstract mixin class _$JoinViaInviteLinkCopyWith<$Res> implements $JoinViaInviteLinkCopyWith<$Res> {
  factory _$JoinViaInviteLinkCopyWith(_JoinViaInviteLink value, $Res Function(_JoinViaInviteLink) _then) = __$JoinViaInviteLinkCopyWithImpl;
@override @useResult
$Res call({
 bool success, int conversationId, String message
});




}
/// @nodoc
class __$JoinViaInviteLinkCopyWithImpl<$Res>
    implements _$JoinViaInviteLinkCopyWith<$Res> {
  __$JoinViaInviteLinkCopyWithImpl(this._self, this._then);

  final _JoinViaInviteLink _self;
  final $Res Function(_JoinViaInviteLink) _then;

/// Create a copy of JoinViaInviteLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? conversationId = null,Object? message = null,}) {
  return _then(_JoinViaInviteLink(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
