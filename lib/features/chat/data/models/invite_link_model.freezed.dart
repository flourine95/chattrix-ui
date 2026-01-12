// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_link_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InviteLinkModel {

 int get id; String get token; int get conversationId; int get createdBy; String get createdByUsername; DateTime get createdAt; int? get maxUses; int get currentUses; bool get revoked; DateTime? get revokedAt; int? get revokedBy; bool get valid;
/// Create a copy of InviteLinkModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinkModelCopyWith<InviteLinkModel> get copyWith => _$InviteLinkModelCopyWithImpl<InviteLinkModel>(this as InviteLinkModel, _$identity);

  /// Serializes this InviteLinkModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.revokedBy, revokedBy) || other.revokedBy == revokedBy)&&(identical(other.valid, valid) || other.valid == valid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,token,conversationId,createdBy,createdByUsername,createdAt,maxUses,currentUses,revoked,revokedAt,revokedBy,valid);

@override
String toString() {
  return 'InviteLinkModel(id: $id, token: $token, conversationId: $conversationId, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt, maxUses: $maxUses, currentUses: $currentUses, revoked: $revoked, revokedAt: $revokedAt, revokedBy: $revokedBy, valid: $valid)';
}


}

/// @nodoc
abstract mixin class $InviteLinkModelCopyWith<$Res>  {
  factory $InviteLinkModelCopyWith(InviteLinkModel value, $Res Function(InviteLinkModel) _then) = _$InviteLinkModelCopyWithImpl;
@useResult
$Res call({
 int id, String token, int conversationId, int createdBy, String createdByUsername, DateTime createdAt, int? maxUses, int currentUses, bool revoked, DateTime? revokedAt, int? revokedBy, bool valid
});




}
/// @nodoc
class _$InviteLinkModelCopyWithImpl<$Res>
    implements $InviteLinkModelCopyWith<$Res> {
  _$InviteLinkModelCopyWithImpl(this._self, this._then);

  final InviteLinkModel _self;
  final $Res Function(InviteLinkModel) _then;

/// Create a copy of InviteLinkModel
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


/// Adds pattern-matching-related methods to [InviteLinkModel].
extension InviteLinkModelPatterns on InviteLinkModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinkModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinkModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinkModel value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinkModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinkModel value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinkModel() when $default != null:
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
case _InviteLinkModel() when $default != null:
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
case _InviteLinkModel():
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
case _InviteLinkModel() when $default != null:
return $default(_that.id,_that.token,_that.conversationId,_that.createdBy,_that.createdByUsername,_that.createdAt,_that.maxUses,_that.currentUses,_that.revoked,_that.revokedAt,_that.revokedBy,_that.valid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteLinkModel implements InviteLinkModel {
  const _InviteLinkModel({required this.id, required this.token, required this.conversationId, required this.createdBy, required this.createdByUsername, required this.createdAt, this.maxUses, this.currentUses = 0, this.revoked = false, this.revokedAt, this.revokedBy, this.valid = true});
  factory _InviteLinkModel.fromJson(Map<String, dynamic> json) => _$InviteLinkModelFromJson(json);

@override final  int id;
@override final  String token;
@override final  int conversationId;
@override final  int createdBy;
@override final  String createdByUsername;
@override final  DateTime createdAt;
@override final  int? maxUses;
@override@JsonKey() final  int currentUses;
@override@JsonKey() final  bool revoked;
@override final  DateTime? revokedAt;
@override final  int? revokedBy;
@override@JsonKey() final  bool valid;

/// Create a copy of InviteLinkModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinkModelCopyWith<_InviteLinkModel> get copyWith => __$InviteLinkModelCopyWithImpl<_InviteLinkModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteLinkModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.revokedBy, revokedBy) || other.revokedBy == revokedBy)&&(identical(other.valid, valid) || other.valid == valid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,token,conversationId,createdBy,createdByUsername,createdAt,maxUses,currentUses,revoked,revokedAt,revokedBy,valid);

@override
String toString() {
  return 'InviteLinkModel(id: $id, token: $token, conversationId: $conversationId, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt, maxUses: $maxUses, currentUses: $currentUses, revoked: $revoked, revokedAt: $revokedAt, revokedBy: $revokedBy, valid: $valid)';
}


}

/// @nodoc
abstract mixin class _$InviteLinkModelCopyWith<$Res> implements $InviteLinkModelCopyWith<$Res> {
  factory _$InviteLinkModelCopyWith(_InviteLinkModel value, $Res Function(_InviteLinkModel) _then) = __$InviteLinkModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String token, int conversationId, int createdBy, String createdByUsername, DateTime createdAt, int? maxUses, int currentUses, bool revoked, DateTime? revokedAt, int? revokedBy, bool valid
});




}
/// @nodoc
class __$InviteLinkModelCopyWithImpl<$Res>
    implements _$InviteLinkModelCopyWith<$Res> {
  __$InviteLinkModelCopyWithImpl(this._self, this._then);

  final _InviteLinkModel _self;
  final $Res Function(_InviteLinkModel) _then;

/// Create a copy of InviteLinkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? token = null,Object? conversationId = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdAt = null,Object? maxUses = freezed,Object? currentUses = null,Object? revoked = null,Object? revokedAt = freezed,Object? revokedBy = freezed,Object? valid = null,}) {
  return _then(_InviteLinkModel(
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
mixin _$CreateInviteLinkRequest {

 int? get expiresInDays; int? get maxUses;
/// Create a copy of CreateInviteLinkRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateInviteLinkRequestCopyWith<CreateInviteLinkRequest> get copyWith => _$CreateInviteLinkRequestCopyWithImpl<CreateInviteLinkRequest>(this as CreateInviteLinkRequest, _$identity);

  /// Serializes this CreateInviteLinkRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateInviteLinkRequest&&(identical(other.expiresInDays, expiresInDays) || other.expiresInDays == expiresInDays)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiresInDays,maxUses);

@override
String toString() {
  return 'CreateInviteLinkRequest(expiresInDays: $expiresInDays, maxUses: $maxUses)';
}


}

/// @nodoc
abstract mixin class $CreateInviteLinkRequestCopyWith<$Res>  {
  factory $CreateInviteLinkRequestCopyWith(CreateInviteLinkRequest value, $Res Function(CreateInviteLinkRequest) _then) = _$CreateInviteLinkRequestCopyWithImpl;
@useResult
$Res call({
 int? expiresInDays, int? maxUses
});




}
/// @nodoc
class _$CreateInviteLinkRequestCopyWithImpl<$Res>
    implements $CreateInviteLinkRequestCopyWith<$Res> {
  _$CreateInviteLinkRequestCopyWithImpl(this._self, this._then);

  final CreateInviteLinkRequest _self;
  final $Res Function(CreateInviteLinkRequest) _then;

/// Create a copy of CreateInviteLinkRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expiresInDays = freezed,Object? maxUses = freezed,}) {
  return _then(_self.copyWith(
expiresInDays: freezed == expiresInDays ? _self.expiresInDays : expiresInDays // ignore: cast_nullable_to_non_nullable
as int?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateInviteLinkRequest].
extension CreateInviteLinkRequestPatterns on CreateInviteLinkRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateInviteLinkRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateInviteLinkRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateInviteLinkRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateInviteLinkRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateInviteLinkRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateInviteLinkRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? expiresInDays,  int? maxUses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateInviteLinkRequest() when $default != null:
return $default(_that.expiresInDays,_that.maxUses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? expiresInDays,  int? maxUses)  $default,) {final _that = this;
switch (_that) {
case _CreateInviteLinkRequest():
return $default(_that.expiresInDays,_that.maxUses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? expiresInDays,  int? maxUses)?  $default,) {final _that = this;
switch (_that) {
case _CreateInviteLinkRequest() when $default != null:
return $default(_that.expiresInDays,_that.maxUses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateInviteLinkRequest implements CreateInviteLinkRequest {
  const _CreateInviteLinkRequest({this.expiresInDays, this.maxUses});
  factory _CreateInviteLinkRequest.fromJson(Map<String, dynamic> json) => _$CreateInviteLinkRequestFromJson(json);

@override final  int? expiresInDays;
@override final  int? maxUses;

/// Create a copy of CreateInviteLinkRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateInviteLinkRequestCopyWith<_CreateInviteLinkRequest> get copyWith => __$CreateInviteLinkRequestCopyWithImpl<_CreateInviteLinkRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateInviteLinkRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateInviteLinkRequest&&(identical(other.expiresInDays, expiresInDays) || other.expiresInDays == expiresInDays)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiresInDays,maxUses);

@override
String toString() {
  return 'CreateInviteLinkRequest(expiresInDays: $expiresInDays, maxUses: $maxUses)';
}


}

/// @nodoc
abstract mixin class _$CreateInviteLinkRequestCopyWith<$Res> implements $CreateInviteLinkRequestCopyWith<$Res> {
  factory _$CreateInviteLinkRequestCopyWith(_CreateInviteLinkRequest value, $Res Function(_CreateInviteLinkRequest) _then) = __$CreateInviteLinkRequestCopyWithImpl;
@override @useResult
$Res call({
 int? expiresInDays, int? maxUses
});




}
/// @nodoc
class __$CreateInviteLinkRequestCopyWithImpl<$Res>
    implements _$CreateInviteLinkRequestCopyWith<$Res> {
  __$CreateInviteLinkRequestCopyWithImpl(this._self, this._then);

  final _CreateInviteLinkRequest _self;
  final $Res Function(_CreateInviteLinkRequest) _then;

/// Create a copy of CreateInviteLinkRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expiresInDays = freezed,Object? maxUses = freezed,}) {
  return _then(_CreateInviteLinkRequest(
expiresInDays: freezed == expiresInDays ? _self.expiresInDays : expiresInDays // ignore: cast_nullable_to_non_nullable
as int?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$InviteLinkInfoModel {

 String get token; int get groupId; int get memberCount; bool get valid; int get createdBy; String get createdByUsername; String get createdByFullName;
/// Create a copy of InviteLinkInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinkInfoModelCopyWith<InviteLinkInfoModel> get copyWith => _$InviteLinkInfoModelCopyWithImpl<InviteLinkInfoModel>(this as InviteLinkInfoModel, _$identity);

  /// Serializes this InviteLinkInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinkInfoModel&&(identical(other.token, token) || other.token == token)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdByFullName, createdByFullName) || other.createdByFullName == createdByFullName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,groupId,memberCount,valid,createdBy,createdByUsername,createdByFullName);

@override
String toString() {
  return 'InviteLinkInfoModel(token: $token, groupId: $groupId, memberCount: $memberCount, valid: $valid, createdBy: $createdBy, createdByUsername: $createdByUsername, createdByFullName: $createdByFullName)';
}


}

/// @nodoc
abstract mixin class $InviteLinkInfoModelCopyWith<$Res>  {
  factory $InviteLinkInfoModelCopyWith(InviteLinkInfoModel value, $Res Function(InviteLinkInfoModel) _then) = _$InviteLinkInfoModelCopyWithImpl;
@useResult
$Res call({
 String token, int groupId, int memberCount, bool valid, int createdBy, String createdByUsername, String createdByFullName
});




}
/// @nodoc
class _$InviteLinkInfoModelCopyWithImpl<$Res>
    implements $InviteLinkInfoModelCopyWith<$Res> {
  _$InviteLinkInfoModelCopyWithImpl(this._self, this._then);

  final InviteLinkInfoModel _self;
  final $Res Function(InviteLinkInfoModel) _then;

/// Create a copy of InviteLinkInfoModel
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


/// Adds pattern-matching-related methods to [InviteLinkInfoModel].
extension InviteLinkInfoModelPatterns on InviteLinkInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinkInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinkInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinkInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinkInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinkInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinkInfoModel() when $default != null:
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
case _InviteLinkInfoModel() when $default != null:
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
case _InviteLinkInfoModel():
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
case _InviteLinkInfoModel() when $default != null:
return $default(_that.token,_that.groupId,_that.memberCount,_that.valid,_that.createdBy,_that.createdByUsername,_that.createdByFullName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteLinkInfoModel implements InviteLinkInfoModel {
  const _InviteLinkInfoModel({required this.token, required this.groupId, required this.memberCount, required this.valid, required this.createdBy, required this.createdByUsername, required this.createdByFullName});
  factory _InviteLinkInfoModel.fromJson(Map<String, dynamic> json) => _$InviteLinkInfoModelFromJson(json);

@override final  String token;
@override final  int groupId;
@override final  int memberCount;
@override final  bool valid;
@override final  int createdBy;
@override final  String createdByUsername;
@override final  String createdByFullName;

/// Create a copy of InviteLinkInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinkInfoModelCopyWith<_InviteLinkInfoModel> get copyWith => __$InviteLinkInfoModelCopyWithImpl<_InviteLinkInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteLinkInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinkInfoModel&&(identical(other.token, token) || other.token == token)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdByFullName, createdByFullName) || other.createdByFullName == createdByFullName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,groupId,memberCount,valid,createdBy,createdByUsername,createdByFullName);

@override
String toString() {
  return 'InviteLinkInfoModel(token: $token, groupId: $groupId, memberCount: $memberCount, valid: $valid, createdBy: $createdBy, createdByUsername: $createdByUsername, createdByFullName: $createdByFullName)';
}


}

/// @nodoc
abstract mixin class _$InviteLinkInfoModelCopyWith<$Res> implements $InviteLinkInfoModelCopyWith<$Res> {
  factory _$InviteLinkInfoModelCopyWith(_InviteLinkInfoModel value, $Res Function(_InviteLinkInfoModel) _then) = __$InviteLinkInfoModelCopyWithImpl;
@override @useResult
$Res call({
 String token, int groupId, int memberCount, bool valid, int createdBy, String createdByUsername, String createdByFullName
});




}
/// @nodoc
class __$InviteLinkInfoModelCopyWithImpl<$Res>
    implements _$InviteLinkInfoModelCopyWith<$Res> {
  __$InviteLinkInfoModelCopyWithImpl(this._self, this._then);

  final _InviteLinkInfoModel _self;
  final $Res Function(_InviteLinkInfoModel) _then;

/// Create a copy of InviteLinkInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? groupId = null,Object? memberCount = null,Object? valid = null,Object? createdBy = null,Object? createdByUsername = null,Object? createdByFullName = null,}) {
  return _then(_InviteLinkInfoModel(
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
mixin _$JoinViaInviteLinkResponse {

 bool get success; int get conversationId; String get message;
/// Create a copy of JoinViaInviteLinkResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinViaInviteLinkResponseCopyWith<JoinViaInviteLinkResponse> get copyWith => _$JoinViaInviteLinkResponseCopyWithImpl<JoinViaInviteLinkResponse>(this as JoinViaInviteLinkResponse, _$identity);

  /// Serializes this JoinViaInviteLinkResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinViaInviteLinkResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,conversationId,message);

@override
String toString() {
  return 'JoinViaInviteLinkResponse(success: $success, conversationId: $conversationId, message: $message)';
}


}

/// @nodoc
abstract mixin class $JoinViaInviteLinkResponseCopyWith<$Res>  {
  factory $JoinViaInviteLinkResponseCopyWith(JoinViaInviteLinkResponse value, $Res Function(JoinViaInviteLinkResponse) _then) = _$JoinViaInviteLinkResponseCopyWithImpl;
@useResult
$Res call({
 bool success, int conversationId, String message
});




}
/// @nodoc
class _$JoinViaInviteLinkResponseCopyWithImpl<$Res>
    implements $JoinViaInviteLinkResponseCopyWith<$Res> {
  _$JoinViaInviteLinkResponseCopyWithImpl(this._self, this._then);

  final JoinViaInviteLinkResponse _self;
  final $Res Function(JoinViaInviteLinkResponse) _then;

/// Create a copy of JoinViaInviteLinkResponse
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


/// Adds pattern-matching-related methods to [JoinViaInviteLinkResponse].
extension JoinViaInviteLinkResponsePatterns on JoinViaInviteLinkResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinViaInviteLinkResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinViaInviteLinkResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinViaInviteLinkResponse value)  $default,){
final _that = this;
switch (_that) {
case _JoinViaInviteLinkResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinViaInviteLinkResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JoinViaInviteLinkResponse() when $default != null:
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
case _JoinViaInviteLinkResponse() when $default != null:
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
case _JoinViaInviteLinkResponse():
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
case _JoinViaInviteLinkResponse() when $default != null:
return $default(_that.success,_that.conversationId,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JoinViaInviteLinkResponse implements JoinViaInviteLinkResponse {
  const _JoinViaInviteLinkResponse({required this.success, required this.conversationId, required this.message});
  factory _JoinViaInviteLinkResponse.fromJson(Map<String, dynamic> json) => _$JoinViaInviteLinkResponseFromJson(json);

@override final  bool success;
@override final  int conversationId;
@override final  String message;

/// Create a copy of JoinViaInviteLinkResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinViaInviteLinkResponseCopyWith<_JoinViaInviteLinkResponse> get copyWith => __$JoinViaInviteLinkResponseCopyWithImpl<_JoinViaInviteLinkResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JoinViaInviteLinkResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinViaInviteLinkResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,conversationId,message);

@override
String toString() {
  return 'JoinViaInviteLinkResponse(success: $success, conversationId: $conversationId, message: $message)';
}


}

/// @nodoc
abstract mixin class _$JoinViaInviteLinkResponseCopyWith<$Res> implements $JoinViaInviteLinkResponseCopyWith<$Res> {
  factory _$JoinViaInviteLinkResponseCopyWith(_JoinViaInviteLinkResponse value, $Res Function(_JoinViaInviteLinkResponse) _then) = __$JoinViaInviteLinkResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, int conversationId, String message
});




}
/// @nodoc
class __$JoinViaInviteLinkResponseCopyWithImpl<$Res>
    implements _$JoinViaInviteLinkResponseCopyWith<$Res> {
  __$JoinViaInviteLinkResponseCopyWithImpl(this._self, this._then);

  final _JoinViaInviteLinkResponse _self;
  final $Res Function(_JoinViaInviteLinkResponse) _then;

/// Create a copy of JoinViaInviteLinkResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? conversationId = null,Object? message = null,}) {
  return _then(_JoinViaInviteLinkResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
