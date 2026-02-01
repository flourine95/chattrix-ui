// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invite_link_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateInviteLinkRequestDto {

 int? get expiresIn; int? get maxUses;
/// Create a copy of CreateInviteLinkRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateInviteLinkRequestDtoCopyWith<CreateInviteLinkRequestDto> get copyWith => _$CreateInviteLinkRequestDtoCopyWithImpl<CreateInviteLinkRequestDto>(this as CreateInviteLinkRequestDto, _$identity);

  /// Serializes this CreateInviteLinkRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateInviteLinkRequestDto&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiresIn,maxUses);

@override
String toString() {
  return 'CreateInviteLinkRequestDto(expiresIn: $expiresIn, maxUses: $maxUses)';
}


}

/// @nodoc
abstract mixin class $CreateInviteLinkRequestDtoCopyWith<$Res>  {
  factory $CreateInviteLinkRequestDtoCopyWith(CreateInviteLinkRequestDto value, $Res Function(CreateInviteLinkRequestDto) _then) = _$CreateInviteLinkRequestDtoCopyWithImpl;
@useResult
$Res call({
 int? expiresIn, int? maxUses
});




}
/// @nodoc
class _$CreateInviteLinkRequestDtoCopyWithImpl<$Res>
    implements $CreateInviteLinkRequestDtoCopyWith<$Res> {
  _$CreateInviteLinkRequestDtoCopyWithImpl(this._self, this._then);

  final CreateInviteLinkRequestDto _self;
  final $Res Function(CreateInviteLinkRequestDto) _then;

/// Create a copy of CreateInviteLinkRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expiresIn = freezed,Object? maxUses = freezed,}) {
  return _then(_self.copyWith(
expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateInviteLinkRequestDto].
extension CreateInviteLinkRequestDtoPatterns on CreateInviteLinkRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateInviteLinkRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateInviteLinkRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateInviteLinkRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateInviteLinkRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateInviteLinkRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateInviteLinkRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? expiresIn,  int? maxUses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateInviteLinkRequestDto() when $default != null:
return $default(_that.expiresIn,_that.maxUses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? expiresIn,  int? maxUses)  $default,) {final _that = this;
switch (_that) {
case _CreateInviteLinkRequestDto():
return $default(_that.expiresIn,_that.maxUses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? expiresIn,  int? maxUses)?  $default,) {final _that = this;
switch (_that) {
case _CreateInviteLinkRequestDto() when $default != null:
return $default(_that.expiresIn,_that.maxUses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateInviteLinkRequestDto implements CreateInviteLinkRequestDto {
  const _CreateInviteLinkRequestDto({this.expiresIn, this.maxUses});
  factory _CreateInviteLinkRequestDto.fromJson(Map<String, dynamic> json) => _$CreateInviteLinkRequestDtoFromJson(json);

@override final  int? expiresIn;
@override final  int? maxUses;

/// Create a copy of CreateInviteLinkRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateInviteLinkRequestDtoCopyWith<_CreateInviteLinkRequestDto> get copyWith => __$CreateInviteLinkRequestDtoCopyWithImpl<_CreateInviteLinkRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateInviteLinkRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateInviteLinkRequestDto&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiresIn,maxUses);

@override
String toString() {
  return 'CreateInviteLinkRequestDto(expiresIn: $expiresIn, maxUses: $maxUses)';
}


}

/// @nodoc
abstract mixin class _$CreateInviteLinkRequestDtoCopyWith<$Res> implements $CreateInviteLinkRequestDtoCopyWith<$Res> {
  factory _$CreateInviteLinkRequestDtoCopyWith(_CreateInviteLinkRequestDto value, $Res Function(_CreateInviteLinkRequestDto) _then) = __$CreateInviteLinkRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 int? expiresIn, int? maxUses
});




}
/// @nodoc
class __$CreateInviteLinkRequestDtoCopyWithImpl<$Res>
    implements _$CreateInviteLinkRequestDtoCopyWith<$Res> {
  __$CreateInviteLinkRequestDtoCopyWithImpl(this._self, this._then);

  final _CreateInviteLinkRequestDto _self;
  final $Res Function(_CreateInviteLinkRequestDto) _then;

/// Create a copy of CreateInviteLinkRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expiresIn = freezed,Object? maxUses = freezed,}) {
  return _then(_CreateInviteLinkRequestDto(
expiresIn: freezed == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$InviteLinkDto {

 int get id; String get token; String? get link;// Full URL from backend (e.g., ngrok URL)
 int get conversationId; int get createdBy; String? get createdByUsername;// Made nullable - backend may not return this
 String get createdAt; String? get expiresAt; int? get maxUses; int get currentUses; bool get revoked; String? get revokedAt; int? get revokedBy; bool get valid;
/// Create a copy of InviteLinkDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinkDtoCopyWith<InviteLinkDto> get copyWith => _$InviteLinkDtoCopyWithImpl<InviteLinkDto>(this as InviteLinkDto, _$identity);

  /// Serializes this InviteLinkDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinkDto&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.link, link) || other.link == link)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.revokedBy, revokedBy) || other.revokedBy == revokedBy)&&(identical(other.valid, valid) || other.valid == valid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,token,link,conversationId,createdBy,createdByUsername,createdAt,expiresAt,maxUses,currentUses,revoked,revokedAt,revokedBy,valid);

@override
String toString() {
  return 'InviteLinkDto(id: $id, token: $token, link: $link, conversationId: $conversationId, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt, expiresAt: $expiresAt, maxUses: $maxUses, currentUses: $currentUses, revoked: $revoked, revokedAt: $revokedAt, revokedBy: $revokedBy, valid: $valid)';
}


}

/// @nodoc
abstract mixin class $InviteLinkDtoCopyWith<$Res>  {
  factory $InviteLinkDtoCopyWith(InviteLinkDto value, $Res Function(InviteLinkDto) _then) = _$InviteLinkDtoCopyWithImpl;
@useResult
$Res call({
 int id, String token, String? link, int conversationId, int createdBy, String? createdByUsername, String createdAt, String? expiresAt, int? maxUses, int currentUses, bool revoked, String? revokedAt, int? revokedBy, bool valid
});




}
/// @nodoc
class _$InviteLinkDtoCopyWithImpl<$Res>
    implements $InviteLinkDtoCopyWith<$Res> {
  _$InviteLinkDtoCopyWithImpl(this._self, this._then);

  final InviteLinkDto _self;
  final $Res Function(InviteLinkDto) _then;

/// Create a copy of InviteLinkDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? token = null,Object? link = freezed,Object? conversationId = null,Object? createdBy = null,Object? createdByUsername = freezed,Object? createdAt = null,Object? expiresAt = freezed,Object? maxUses = freezed,Object? currentUses = null,Object? revoked = null,Object? revokedAt = freezed,Object? revokedBy = freezed,Object? valid = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: freezed == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,currentUses: null == currentUses ? _self.currentUses : currentUses // ignore: cast_nullable_to_non_nullable
as int,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as String?,revokedBy: freezed == revokedBy ? _self.revokedBy : revokedBy // ignore: cast_nullable_to_non_nullable
as int?,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteLinkDto].
extension InviteLinkDtoPatterns on InviteLinkDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinkDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinkDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinkDto value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinkDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinkDto value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinkDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String token,  String? link,  int conversationId,  int createdBy,  String? createdByUsername,  String createdAt,  String? expiresAt,  int? maxUses,  int currentUses,  bool revoked,  String? revokedAt,  int? revokedBy,  bool valid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteLinkDto() when $default != null:
return $default(_that.id,_that.token,_that.link,_that.conversationId,_that.createdBy,_that.createdByUsername,_that.createdAt,_that.expiresAt,_that.maxUses,_that.currentUses,_that.revoked,_that.revokedAt,_that.revokedBy,_that.valid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String token,  String? link,  int conversationId,  int createdBy,  String? createdByUsername,  String createdAt,  String? expiresAt,  int? maxUses,  int currentUses,  bool revoked,  String? revokedAt,  int? revokedBy,  bool valid)  $default,) {final _that = this;
switch (_that) {
case _InviteLinkDto():
return $default(_that.id,_that.token,_that.link,_that.conversationId,_that.createdBy,_that.createdByUsername,_that.createdAt,_that.expiresAt,_that.maxUses,_that.currentUses,_that.revoked,_that.revokedAt,_that.revokedBy,_that.valid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String token,  String? link,  int conversationId,  int createdBy,  String? createdByUsername,  String createdAt,  String? expiresAt,  int? maxUses,  int currentUses,  bool revoked,  String? revokedAt,  int? revokedBy,  bool valid)?  $default,) {final _that = this;
switch (_that) {
case _InviteLinkDto() when $default != null:
return $default(_that.id,_that.token,_that.link,_that.conversationId,_that.createdBy,_that.createdByUsername,_that.createdAt,_that.expiresAt,_that.maxUses,_that.currentUses,_that.revoked,_that.revokedAt,_that.revokedBy,_that.valid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteLinkDto implements InviteLinkDto {
  const _InviteLinkDto({required this.id, required this.token, this.link, required this.conversationId, required this.createdBy, this.createdByUsername, required this.createdAt, this.expiresAt, this.maxUses, required this.currentUses, required this.revoked, this.revokedAt, this.revokedBy, required this.valid});
  factory _InviteLinkDto.fromJson(Map<String, dynamic> json) => _$InviteLinkDtoFromJson(json);

@override final  int id;
@override final  String token;
@override final  String? link;
// Full URL from backend (e.g., ngrok URL)
@override final  int conversationId;
@override final  int createdBy;
@override final  String? createdByUsername;
// Made nullable - backend may not return this
@override final  String createdAt;
@override final  String? expiresAt;
@override final  int? maxUses;
@override final  int currentUses;
@override final  bool revoked;
@override final  String? revokedAt;
@override final  int? revokedBy;
@override final  bool valid;

/// Create a copy of InviteLinkDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinkDtoCopyWith<_InviteLinkDto> get copyWith => __$InviteLinkDtoCopyWithImpl<_InviteLinkDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteLinkDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinkDto&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.link, link) || other.link == link)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.revokedAt, revokedAt) || other.revokedAt == revokedAt)&&(identical(other.revokedBy, revokedBy) || other.revokedBy == revokedBy)&&(identical(other.valid, valid) || other.valid == valid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,token,link,conversationId,createdBy,createdByUsername,createdAt,expiresAt,maxUses,currentUses,revoked,revokedAt,revokedBy,valid);

@override
String toString() {
  return 'InviteLinkDto(id: $id, token: $token, link: $link, conversationId: $conversationId, createdBy: $createdBy, createdByUsername: $createdByUsername, createdAt: $createdAt, expiresAt: $expiresAt, maxUses: $maxUses, currentUses: $currentUses, revoked: $revoked, revokedAt: $revokedAt, revokedBy: $revokedBy, valid: $valid)';
}


}

/// @nodoc
abstract mixin class _$InviteLinkDtoCopyWith<$Res> implements $InviteLinkDtoCopyWith<$Res> {
  factory _$InviteLinkDtoCopyWith(_InviteLinkDto value, $Res Function(_InviteLinkDto) _then) = __$InviteLinkDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String token, String? link, int conversationId, int createdBy, String? createdByUsername, String createdAt, String? expiresAt, int? maxUses, int currentUses, bool revoked, String? revokedAt, int? revokedBy, bool valid
});




}
/// @nodoc
class __$InviteLinkDtoCopyWithImpl<$Res>
    implements _$InviteLinkDtoCopyWith<$Res> {
  __$InviteLinkDtoCopyWithImpl(this._self, this._then);

  final _InviteLinkDto _self;
  final $Res Function(_InviteLinkDto) _then;

/// Create a copy of InviteLinkDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? token = null,Object? link = freezed,Object? conversationId = null,Object? createdBy = null,Object? createdByUsername = freezed,Object? createdAt = null,Object? expiresAt = freezed,Object? maxUses = freezed,Object? currentUses = null,Object? revoked = null,Object? revokedAt = freezed,Object? revokedBy = freezed,Object? valid = null,}) {
  return _then(_InviteLinkDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as int,createdByUsername: freezed == createdByUsername ? _self.createdByUsername : createdByUsername // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,currentUses: null == currentUses ? _self.currentUses : currentUses // ignore: cast_nullable_to_non_nullable
as int,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,revokedAt: freezed == revokedAt ? _self.revokedAt : revokedAt // ignore: cast_nullable_to_non_nullable
as String?,revokedBy: freezed == revokedBy ? _self.revokedBy : revokedBy // ignore: cast_nullable_to_non_nullable
as int?,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$InviteLinkInfoDto {

 String get token; int get groupId; String get groupName; int get memberCount; bool get valid; String? get expiresAt; int get createdBy; String get createdByUsername; String get createdByFullName; int? get maxUses; int get usesCount; bool get revoked; String? get groupAvatar;
/// Create a copy of InviteLinkInfoDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinkInfoDtoCopyWith<InviteLinkInfoDto> get copyWith => _$InviteLinkInfoDtoCopyWithImpl<InviteLinkInfoDto>(this as InviteLinkInfoDto, _$identity);

  /// Serializes this InviteLinkInfoDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinkInfoDto&&(identical(other.token, token) || other.token == token)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdByFullName, createdByFullName) || other.createdByFullName == createdByFullName)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.usesCount, usesCount) || other.usesCount == usesCount)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.groupAvatar, groupAvatar) || other.groupAvatar == groupAvatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,groupId,groupName,memberCount,valid,expiresAt,createdBy,createdByUsername,createdByFullName,maxUses,usesCount,revoked,groupAvatar);

@override
String toString() {
  return 'InviteLinkInfoDto(token: $token, groupId: $groupId, groupName: $groupName, memberCount: $memberCount, valid: $valid, expiresAt: $expiresAt, createdBy: $createdBy, createdByUsername: $createdByUsername, createdByFullName: $createdByFullName, maxUses: $maxUses, usesCount: $usesCount, revoked: $revoked, groupAvatar: $groupAvatar)';
}


}

/// @nodoc
abstract mixin class $InviteLinkInfoDtoCopyWith<$Res>  {
  factory $InviteLinkInfoDtoCopyWith(InviteLinkInfoDto value, $Res Function(InviteLinkInfoDto) _then) = _$InviteLinkInfoDtoCopyWithImpl;
@useResult
$Res call({
 String token, int groupId, String groupName, int memberCount, bool valid, String? expiresAt, int createdBy, String createdByUsername, String createdByFullName, int? maxUses, int usesCount, bool revoked, String? groupAvatar
});




}
/// @nodoc
class _$InviteLinkInfoDtoCopyWithImpl<$Res>
    implements $InviteLinkInfoDtoCopyWith<$Res> {
  _$InviteLinkInfoDtoCopyWithImpl(this._self, this._then);

  final InviteLinkInfoDto _self;
  final $Res Function(InviteLinkInfoDto) _then;

/// Create a copy of InviteLinkInfoDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? groupId = null,Object? groupName = null,Object? memberCount = null,Object? valid = null,Object? expiresAt = freezed,Object? createdBy = null,Object? createdByUsername = null,Object? createdByFullName = null,Object? maxUses = freezed,Object? usesCount = null,Object? revoked = null,Object? groupAvatar = freezed,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [InviteLinkInfoDto].
extension InviteLinkInfoDtoPatterns on InviteLinkInfoDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinkInfoDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinkInfoDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinkInfoDto value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinkInfoDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinkInfoDto value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinkInfoDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  int groupId,  String groupName,  int memberCount,  bool valid,  String? expiresAt,  int createdBy,  String createdByUsername,  String createdByFullName,  int? maxUses,  int usesCount,  bool revoked,  String? groupAvatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteLinkInfoDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  int groupId,  String groupName,  int memberCount,  bool valid,  String? expiresAt,  int createdBy,  String createdByUsername,  String createdByFullName,  int? maxUses,  int usesCount,  bool revoked,  String? groupAvatar)  $default,) {final _that = this;
switch (_that) {
case _InviteLinkInfoDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  int groupId,  String groupName,  int memberCount,  bool valid,  String? expiresAt,  int createdBy,  String createdByUsername,  String createdByFullName,  int? maxUses,  int usesCount,  bool revoked,  String? groupAvatar)?  $default,) {final _that = this;
switch (_that) {
case _InviteLinkInfoDto() when $default != null:
return $default(_that.token,_that.groupId,_that.groupName,_that.memberCount,_that.valid,_that.expiresAt,_that.createdBy,_that.createdByUsername,_that.createdByFullName,_that.maxUses,_that.usesCount,_that.revoked,_that.groupAvatar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteLinkInfoDto implements InviteLinkInfoDto {
  const _InviteLinkInfoDto({required this.token, required this.groupId, required this.groupName, required this.memberCount, required this.valid, this.expiresAt, required this.createdBy, required this.createdByUsername, required this.createdByFullName, this.maxUses, this.usesCount = 0, this.revoked = false, this.groupAvatar});
  factory _InviteLinkInfoDto.fromJson(Map<String, dynamic> json) => _$InviteLinkInfoDtoFromJson(json);

@override final  String token;
@override final  int groupId;
@override final  String groupName;
@override final  int memberCount;
@override final  bool valid;
@override final  String? expiresAt;
@override final  int createdBy;
@override final  String createdByUsername;
@override final  String createdByFullName;
@override final  int? maxUses;
@override@JsonKey() final  int usesCount;
@override@JsonKey() final  bool revoked;
@override final  String? groupAvatar;

/// Create a copy of InviteLinkInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinkInfoDtoCopyWith<_InviteLinkInfoDto> get copyWith => __$InviteLinkInfoDtoCopyWithImpl<_InviteLinkInfoDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteLinkInfoDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinkInfoDto&&(identical(other.token, token) || other.token == token)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdByUsername, createdByUsername) || other.createdByUsername == createdByUsername)&&(identical(other.createdByFullName, createdByFullName) || other.createdByFullName == createdByFullName)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.usesCount, usesCount) || other.usesCount == usesCount)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.groupAvatar, groupAvatar) || other.groupAvatar == groupAvatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,groupId,groupName,memberCount,valid,expiresAt,createdBy,createdByUsername,createdByFullName,maxUses,usesCount,revoked,groupAvatar);

@override
String toString() {
  return 'InviteLinkInfoDto(token: $token, groupId: $groupId, groupName: $groupName, memberCount: $memberCount, valid: $valid, expiresAt: $expiresAt, createdBy: $createdBy, createdByUsername: $createdByUsername, createdByFullName: $createdByFullName, maxUses: $maxUses, usesCount: $usesCount, revoked: $revoked, groupAvatar: $groupAvatar)';
}


}

/// @nodoc
abstract mixin class _$InviteLinkInfoDtoCopyWith<$Res> implements $InviteLinkInfoDtoCopyWith<$Res> {
  factory _$InviteLinkInfoDtoCopyWith(_InviteLinkInfoDto value, $Res Function(_InviteLinkInfoDto) _then) = __$InviteLinkInfoDtoCopyWithImpl;
@override @useResult
$Res call({
 String token, int groupId, String groupName, int memberCount, bool valid, String? expiresAt, int createdBy, String createdByUsername, String createdByFullName, int? maxUses, int usesCount, bool revoked, String? groupAvatar
});




}
/// @nodoc
class __$InviteLinkInfoDtoCopyWithImpl<$Res>
    implements _$InviteLinkInfoDtoCopyWith<$Res> {
  __$InviteLinkInfoDtoCopyWithImpl(this._self, this._then);

  final _InviteLinkInfoDto _self;
  final $Res Function(_InviteLinkInfoDto) _then;

/// Create a copy of InviteLinkInfoDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? groupId = null,Object? groupName = null,Object? memberCount = null,Object? valid = null,Object? expiresAt = freezed,Object? createdBy = null,Object? createdByUsername = null,Object? createdByFullName = null,Object? maxUses = freezed,Object? usesCount = null,Object? revoked = null,Object? groupAvatar = freezed,}) {
  return _then(_InviteLinkInfoDto(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int,groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
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
mixin _$JoinGroupResponseDto {

 bool get success; int get conversationId; String get message; String? get groupName;
/// Create a copy of JoinGroupResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinGroupResponseDtoCopyWith<JoinGroupResponseDto> get copyWith => _$JoinGroupResponseDtoCopyWithImpl<JoinGroupResponseDto>(this as JoinGroupResponseDto, _$identity);

  /// Serializes this JoinGroupResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinGroupResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.message, message) || other.message == message)&&(identical(other.groupName, groupName) || other.groupName == groupName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,conversationId,message,groupName);

@override
String toString() {
  return 'JoinGroupResponseDto(success: $success, conversationId: $conversationId, message: $message, groupName: $groupName)';
}


}

/// @nodoc
abstract mixin class $JoinGroupResponseDtoCopyWith<$Res>  {
  factory $JoinGroupResponseDtoCopyWith(JoinGroupResponseDto value, $Res Function(JoinGroupResponseDto) _then) = _$JoinGroupResponseDtoCopyWithImpl;
@useResult
$Res call({
 bool success, int conversationId, String message, String? groupName
});




}
/// @nodoc
class _$JoinGroupResponseDtoCopyWithImpl<$Res>
    implements $JoinGroupResponseDtoCopyWith<$Res> {
  _$JoinGroupResponseDtoCopyWithImpl(this._self, this._then);

  final JoinGroupResponseDto _self;
  final $Res Function(JoinGroupResponseDto) _then;

/// Create a copy of JoinGroupResponseDto
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


/// Adds pattern-matching-related methods to [JoinGroupResponseDto].
extension JoinGroupResponseDtoPatterns on JoinGroupResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinGroupResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinGroupResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinGroupResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _JoinGroupResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinGroupResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _JoinGroupResponseDto() when $default != null:
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
case _JoinGroupResponseDto() when $default != null:
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
case _JoinGroupResponseDto():
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
case _JoinGroupResponseDto() when $default != null:
return $default(_that.success,_that.conversationId,_that.message,_that.groupName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JoinGroupResponseDto implements JoinGroupResponseDto {
  const _JoinGroupResponseDto({required this.success, required this.conversationId, required this.message, this.groupName});
  factory _JoinGroupResponseDto.fromJson(Map<String, dynamic> json) => _$JoinGroupResponseDtoFromJson(json);

@override final  bool success;
@override final  int conversationId;
@override final  String message;
@override final  String? groupName;

/// Create a copy of JoinGroupResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinGroupResponseDtoCopyWith<_JoinGroupResponseDto> get copyWith => __$JoinGroupResponseDtoCopyWithImpl<_JoinGroupResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JoinGroupResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinGroupResponseDto&&(identical(other.success, success) || other.success == success)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.message, message) || other.message == message)&&(identical(other.groupName, groupName) || other.groupName == groupName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,conversationId,message,groupName);

@override
String toString() {
  return 'JoinGroupResponseDto(success: $success, conversationId: $conversationId, message: $message, groupName: $groupName)';
}


}

/// @nodoc
abstract mixin class _$JoinGroupResponseDtoCopyWith<$Res> implements $JoinGroupResponseDtoCopyWith<$Res> {
  factory _$JoinGroupResponseDtoCopyWith(_JoinGroupResponseDto value, $Res Function(_JoinGroupResponseDto) _then) = __$JoinGroupResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 bool success, int conversationId, String message, String? groupName
});




}
/// @nodoc
class __$JoinGroupResponseDtoCopyWithImpl<$Res>
    implements _$JoinGroupResponseDtoCopyWith<$Res> {
  __$JoinGroupResponseDtoCopyWithImpl(this._self, this._then);

  final _JoinGroupResponseDto _self;
  final $Res Function(_JoinGroupResponseDto) _then;

/// Create a copy of JoinGroupResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? conversationId = null,Object? message = null,Object? groupName = freezed,}) {
  return _then(_JoinGroupResponseDto(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$InviteLinkUserDto {

 int get id; String get username; String get fullName; String? get avatarUrl; String? get lastSeen;
/// Create a copy of InviteLinkUserDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinkUserDtoCopyWith<InviteLinkUserDto> get copyWith => _$InviteLinkUserDtoCopyWithImpl<InviteLinkUserDto>(this as InviteLinkUserDto, _$identity);

  /// Serializes this InviteLinkUserDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinkUserDto&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,fullName,avatarUrl,lastSeen);

@override
String toString() {
  return 'InviteLinkUserDto(id: $id, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, lastSeen: $lastSeen)';
}


}

/// @nodoc
abstract mixin class $InviteLinkUserDtoCopyWith<$Res>  {
  factory $InviteLinkUserDtoCopyWith(InviteLinkUserDto value, $Res Function(InviteLinkUserDto) _then) = _$InviteLinkUserDtoCopyWithImpl;
@useResult
$Res call({
 int id, String username, String fullName, String? avatarUrl, String? lastSeen
});




}
/// @nodoc
class _$InviteLinkUserDtoCopyWithImpl<$Res>
    implements $InviteLinkUserDtoCopyWith<$Res> {
  _$InviteLinkUserDtoCopyWithImpl(this._self, this._then);

  final InviteLinkUserDto _self;
  final $Res Function(InviteLinkUserDto) _then;

/// Create a copy of InviteLinkUserDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? lastSeen = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteLinkUserDto].
extension InviteLinkUserDtoPatterns on InviteLinkUserDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinkUserDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinkUserDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinkUserDto value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinkUserDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinkUserDto value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinkUserDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String username,  String fullName,  String? avatarUrl,  String? lastSeen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteLinkUserDto() when $default != null:
return $default(_that.id,_that.username,_that.fullName,_that.avatarUrl,_that.lastSeen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String username,  String fullName,  String? avatarUrl,  String? lastSeen)  $default,) {final _that = this;
switch (_that) {
case _InviteLinkUserDto():
return $default(_that.id,_that.username,_that.fullName,_that.avatarUrl,_that.lastSeen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String username,  String fullName,  String? avatarUrl,  String? lastSeen)?  $default,) {final _that = this;
switch (_that) {
case _InviteLinkUserDto() when $default != null:
return $default(_that.id,_that.username,_that.fullName,_that.avatarUrl,_that.lastSeen);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteLinkUserDto implements InviteLinkUserDto {
  const _InviteLinkUserDto({required this.id, required this.username, required this.fullName, this.avatarUrl, this.lastSeen});
  factory _InviteLinkUserDto.fromJson(Map<String, dynamic> json) => _$InviteLinkUserDtoFromJson(json);

@override final  int id;
@override final  String username;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  String? lastSeen;

/// Create a copy of InviteLinkUserDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinkUserDtoCopyWith<_InviteLinkUserDto> get copyWith => __$InviteLinkUserDtoCopyWithImpl<_InviteLinkUserDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteLinkUserDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinkUserDto&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,fullName,avatarUrl,lastSeen);

@override
String toString() {
  return 'InviteLinkUserDto(id: $id, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, lastSeen: $lastSeen)';
}


}

/// @nodoc
abstract mixin class _$InviteLinkUserDtoCopyWith<$Res> implements $InviteLinkUserDtoCopyWith<$Res> {
  factory _$InviteLinkUserDtoCopyWith(_InviteLinkUserDto value, $Res Function(_InviteLinkUserDto) _then) = __$InviteLinkUserDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String fullName, String? avatarUrl, String? lastSeen
});




}
/// @nodoc
class __$InviteLinkUserDtoCopyWithImpl<$Res>
    implements _$InviteLinkUserDtoCopyWith<$Res> {
  __$InviteLinkUserDtoCopyWithImpl(this._self, this._then);

  final _InviteLinkUserDto _self;
  final $Res Function(_InviteLinkUserDto) _then;

/// Create a copy of InviteLinkUserDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? lastSeen = freezed,}) {
  return _then(_InviteLinkUserDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$InviteLinkHistoryItemDto {

 String get token; String? get link;// Full URL from backend
 InviteLinkUserDto get createdBy; String get createdAt; int get maxUses; int get currentUses; bool get isActive; bool get isRevoked; bool get isExpired; String get status;
/// Create a copy of InviteLinkHistoryItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinkHistoryItemDtoCopyWith<InviteLinkHistoryItemDto> get copyWith => _$InviteLinkHistoryItemDtoCopyWithImpl<InviteLinkHistoryItemDto>(this as InviteLinkHistoryItemDto, _$identity);

  /// Serializes this InviteLinkHistoryItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinkHistoryItemDto&&(identical(other.token, token) || other.token == token)&&(identical(other.link, link) || other.link == link)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isRevoked, isRevoked) || other.isRevoked == isRevoked)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,link,createdBy,createdAt,maxUses,currentUses,isActive,isRevoked,isExpired,status);

@override
String toString() {
  return 'InviteLinkHistoryItemDto(token: $token, link: $link, createdBy: $createdBy, createdAt: $createdAt, maxUses: $maxUses, currentUses: $currentUses, isActive: $isActive, isRevoked: $isRevoked, isExpired: $isExpired, status: $status)';
}


}

/// @nodoc
abstract mixin class $InviteLinkHistoryItemDtoCopyWith<$Res>  {
  factory $InviteLinkHistoryItemDtoCopyWith(InviteLinkHistoryItemDto value, $Res Function(InviteLinkHistoryItemDto) _then) = _$InviteLinkHistoryItemDtoCopyWithImpl;
@useResult
$Res call({
 String token, String? link, InviteLinkUserDto createdBy, String createdAt, int maxUses, int currentUses, bool isActive, bool isRevoked, bool isExpired, String status
});


$InviteLinkUserDtoCopyWith<$Res> get createdBy;

}
/// @nodoc
class _$InviteLinkHistoryItemDtoCopyWithImpl<$Res>
    implements $InviteLinkHistoryItemDtoCopyWith<$Res> {
  _$InviteLinkHistoryItemDtoCopyWithImpl(this._self, this._then);

  final InviteLinkHistoryItemDto _self;
  final $Res Function(InviteLinkHistoryItemDto) _then;

/// Create a copy of InviteLinkHistoryItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? link = freezed,Object? createdBy = null,Object? createdAt = null,Object? maxUses = null,Object? currentUses = null,Object? isActive = null,Object? isRevoked = null,Object? isExpired = null,Object? status = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as InviteLinkUserDto,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,maxUses: null == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int,currentUses: null == currentUses ? _self.currentUses : currentUses // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isRevoked: null == isRevoked ? _self.isRevoked : isRevoked // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of InviteLinkHistoryItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InviteLinkUserDtoCopyWith<$Res> get createdBy {
  
  return $InviteLinkUserDtoCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [InviteLinkHistoryItemDto].
extension InviteLinkHistoryItemDtoPatterns on InviteLinkHistoryItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinkHistoryItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinkHistoryItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinkHistoryItemDto value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinkHistoryItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinkHistoryItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinkHistoryItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  String? link,  InviteLinkUserDto createdBy,  String createdAt,  int maxUses,  int currentUses,  bool isActive,  bool isRevoked,  bool isExpired,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteLinkHistoryItemDto() when $default != null:
return $default(_that.token,_that.link,_that.createdBy,_that.createdAt,_that.maxUses,_that.currentUses,_that.isActive,_that.isRevoked,_that.isExpired,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  String? link,  InviteLinkUserDto createdBy,  String createdAt,  int maxUses,  int currentUses,  bool isActive,  bool isRevoked,  bool isExpired,  String status)  $default,) {final _that = this;
switch (_that) {
case _InviteLinkHistoryItemDto():
return $default(_that.token,_that.link,_that.createdBy,_that.createdAt,_that.maxUses,_that.currentUses,_that.isActive,_that.isRevoked,_that.isExpired,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  String? link,  InviteLinkUserDto createdBy,  String createdAt,  int maxUses,  int currentUses,  bool isActive,  bool isRevoked,  bool isExpired,  String status)?  $default,) {final _that = this;
switch (_that) {
case _InviteLinkHistoryItemDto() when $default != null:
return $default(_that.token,_that.link,_that.createdBy,_that.createdAt,_that.maxUses,_that.currentUses,_that.isActive,_that.isRevoked,_that.isExpired,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteLinkHistoryItemDto implements InviteLinkHistoryItemDto {
  const _InviteLinkHistoryItemDto({required this.token, this.link, required this.createdBy, required this.createdAt, required this.maxUses, required this.currentUses, required this.isActive, required this.isRevoked, required this.isExpired, required this.status});
  factory _InviteLinkHistoryItemDto.fromJson(Map<String, dynamic> json) => _$InviteLinkHistoryItemDtoFromJson(json);

@override final  String token;
@override final  String? link;
// Full URL from backend
@override final  InviteLinkUserDto createdBy;
@override final  String createdAt;
@override final  int maxUses;
@override final  int currentUses;
@override final  bool isActive;
@override final  bool isRevoked;
@override final  bool isExpired;
@override final  String status;

/// Create a copy of InviteLinkHistoryItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinkHistoryItemDtoCopyWith<_InviteLinkHistoryItemDto> get copyWith => __$InviteLinkHistoryItemDtoCopyWithImpl<_InviteLinkHistoryItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteLinkHistoryItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinkHistoryItemDto&&(identical(other.token, token) || other.token == token)&&(identical(other.link, link) || other.link == link)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isRevoked, isRevoked) || other.isRevoked == isRevoked)&&(identical(other.isExpired, isExpired) || other.isExpired == isExpired)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,link,createdBy,createdAt,maxUses,currentUses,isActive,isRevoked,isExpired,status);

@override
String toString() {
  return 'InviteLinkHistoryItemDto(token: $token, link: $link, createdBy: $createdBy, createdAt: $createdAt, maxUses: $maxUses, currentUses: $currentUses, isActive: $isActive, isRevoked: $isRevoked, isExpired: $isExpired, status: $status)';
}


}

/// @nodoc
abstract mixin class _$InviteLinkHistoryItemDtoCopyWith<$Res> implements $InviteLinkHistoryItemDtoCopyWith<$Res> {
  factory _$InviteLinkHistoryItemDtoCopyWith(_InviteLinkHistoryItemDto value, $Res Function(_InviteLinkHistoryItemDto) _then) = __$InviteLinkHistoryItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String token, String? link, InviteLinkUserDto createdBy, String createdAt, int maxUses, int currentUses, bool isActive, bool isRevoked, bool isExpired, String status
});


@override $InviteLinkUserDtoCopyWith<$Res> get createdBy;

}
/// @nodoc
class __$InviteLinkHistoryItemDtoCopyWithImpl<$Res>
    implements _$InviteLinkHistoryItemDtoCopyWith<$Res> {
  __$InviteLinkHistoryItemDtoCopyWithImpl(this._self, this._then);

  final _InviteLinkHistoryItemDto _self;
  final $Res Function(_InviteLinkHistoryItemDto) _then;

/// Create a copy of InviteLinkHistoryItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? link = freezed,Object? createdBy = null,Object? createdAt = null,Object? maxUses = null,Object? currentUses = null,Object? isActive = null,Object? isRevoked = null,Object? isExpired = null,Object? status = null,}) {
  return _then(_InviteLinkHistoryItemDto(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as InviteLinkUserDto,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,maxUses: null == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int,currentUses: null == currentUses ? _self.currentUses : currentUses // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isRevoked: null == isRevoked ? _self.isRevoked : isRevoked // ignore: cast_nullable_to_non_nullable
as bool,isExpired: null == isExpired ? _self.isExpired : isExpired // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of InviteLinkHistoryItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InviteLinkUserDtoCopyWith<$Res> get createdBy {
  
  return $InviteLinkUserDtoCopyWith<$Res>(_self.createdBy, (value) {
    return _then(_self.copyWith(createdBy: value));
  });
}
}


/// @nodoc
mixin _$InviteLinksMetaDto {

 String? get nextCursor; bool get hasNextPage; int get itemsPerPage;
/// Create a copy of InviteLinksMetaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinksMetaDtoCopyWith<InviteLinksMetaDto> get copyWith => _$InviteLinksMetaDtoCopyWithImpl<InviteLinksMetaDto>(this as InviteLinksMetaDto, _$identity);

  /// Serializes this InviteLinksMetaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinksMetaDto&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.itemsPerPage, itemsPerPage) || other.itemsPerPage == itemsPerPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nextCursor,hasNextPage,itemsPerPage);

@override
String toString() {
  return 'InviteLinksMetaDto(nextCursor: $nextCursor, hasNextPage: $hasNextPage, itemsPerPage: $itemsPerPage)';
}


}

/// @nodoc
abstract mixin class $InviteLinksMetaDtoCopyWith<$Res>  {
  factory $InviteLinksMetaDtoCopyWith(InviteLinksMetaDto value, $Res Function(InviteLinksMetaDto) _then) = _$InviteLinksMetaDtoCopyWithImpl;
@useResult
$Res call({
 String? nextCursor, bool hasNextPage, int itemsPerPage
});




}
/// @nodoc
class _$InviteLinksMetaDtoCopyWithImpl<$Res>
    implements $InviteLinksMetaDtoCopyWith<$Res> {
  _$InviteLinksMetaDtoCopyWithImpl(this._self, this._then);

  final InviteLinksMetaDto _self;
  final $Res Function(InviteLinksMetaDto) _then;

/// Create a copy of InviteLinksMetaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nextCursor = freezed,Object? hasNextPage = null,Object? itemsPerPage = null,}) {
  return _then(_self.copyWith(
nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,itemsPerPage: null == itemsPerPage ? _self.itemsPerPage : itemsPerPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteLinksMetaDto].
extension InviteLinksMetaDtoPatterns on InviteLinksMetaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinksMetaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinksMetaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinksMetaDto value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinksMetaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinksMetaDto value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinksMetaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nextCursor,  bool hasNextPage,  int itemsPerPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteLinksMetaDto() when $default != null:
return $default(_that.nextCursor,_that.hasNextPage,_that.itemsPerPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nextCursor,  bool hasNextPage,  int itemsPerPage)  $default,) {final _that = this;
switch (_that) {
case _InviteLinksMetaDto():
return $default(_that.nextCursor,_that.hasNextPage,_that.itemsPerPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nextCursor,  bool hasNextPage,  int itemsPerPage)?  $default,) {final _that = this;
switch (_that) {
case _InviteLinksMetaDto() when $default != null:
return $default(_that.nextCursor,_that.hasNextPage,_that.itemsPerPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteLinksMetaDto implements InviteLinksMetaDto {
  const _InviteLinksMetaDto({this.nextCursor, required this.hasNextPage, required this.itemsPerPage});
  factory _InviteLinksMetaDto.fromJson(Map<String, dynamic> json) => _$InviteLinksMetaDtoFromJson(json);

@override final  String? nextCursor;
@override final  bool hasNextPage;
@override final  int itemsPerPage;

/// Create a copy of InviteLinksMetaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinksMetaDtoCopyWith<_InviteLinksMetaDto> get copyWith => __$InviteLinksMetaDtoCopyWithImpl<_InviteLinksMetaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteLinksMetaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinksMetaDto&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.itemsPerPage, itemsPerPage) || other.itemsPerPage == itemsPerPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nextCursor,hasNextPage,itemsPerPage);

@override
String toString() {
  return 'InviteLinksMetaDto(nextCursor: $nextCursor, hasNextPage: $hasNextPage, itemsPerPage: $itemsPerPage)';
}


}

/// @nodoc
abstract mixin class _$InviteLinksMetaDtoCopyWith<$Res> implements $InviteLinksMetaDtoCopyWith<$Res> {
  factory _$InviteLinksMetaDtoCopyWith(_InviteLinksMetaDto value, $Res Function(_InviteLinksMetaDto) _then) = __$InviteLinksMetaDtoCopyWithImpl;
@override @useResult
$Res call({
 String? nextCursor, bool hasNextPage, int itemsPerPage
});




}
/// @nodoc
class __$InviteLinksMetaDtoCopyWithImpl<$Res>
    implements _$InviteLinksMetaDtoCopyWith<$Res> {
  __$InviteLinksMetaDtoCopyWithImpl(this._self, this._then);

  final _InviteLinksMetaDto _self;
  final $Res Function(_InviteLinksMetaDto) _then;

/// Create a copy of InviteLinksMetaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nextCursor = freezed,Object? hasNextPage = null,Object? itemsPerPage = null,}) {
  return _then(_InviteLinksMetaDto(
nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,itemsPerPage: null == itemsPerPage ? _self.itemsPerPage : itemsPerPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$InviteLinksHistoryDto {

 List<InviteLinkHistoryItemDto> get items; InviteLinksMetaDto get meta;
/// Create a copy of InviteLinksHistoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteLinksHistoryDtoCopyWith<InviteLinksHistoryDto> get copyWith => _$InviteLinksHistoryDtoCopyWithImpl<InviteLinksHistoryDto>(this as InviteLinksHistoryDto, _$identity);

  /// Serializes this InviteLinksHistoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteLinksHistoryDto&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),meta);

@override
String toString() {
  return 'InviteLinksHistoryDto(items: $items, meta: $meta)';
}


}

/// @nodoc
abstract mixin class $InviteLinksHistoryDtoCopyWith<$Res>  {
  factory $InviteLinksHistoryDtoCopyWith(InviteLinksHistoryDto value, $Res Function(InviteLinksHistoryDto) _then) = _$InviteLinksHistoryDtoCopyWithImpl;
@useResult
$Res call({
 List<InviteLinkHistoryItemDto> items, InviteLinksMetaDto meta
});


$InviteLinksMetaDtoCopyWith<$Res> get meta;

}
/// @nodoc
class _$InviteLinksHistoryDtoCopyWithImpl<$Res>
    implements $InviteLinksHistoryDtoCopyWith<$Res> {
  _$InviteLinksHistoryDtoCopyWithImpl(this._self, this._then);

  final InviteLinksHistoryDto _self;
  final $Res Function(InviteLinksHistoryDto) _then;

/// Create a copy of InviteLinksHistoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? meta = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<InviteLinkHistoryItemDto>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as InviteLinksMetaDto,
  ));
}
/// Create a copy of InviteLinksHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InviteLinksMetaDtoCopyWith<$Res> get meta {
  
  return $InviteLinksMetaDtoCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [InviteLinksHistoryDto].
extension InviteLinksHistoryDtoPatterns on InviteLinksHistoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteLinksHistoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteLinksHistoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteLinksHistoryDto value)  $default,){
final _that = this;
switch (_that) {
case _InviteLinksHistoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteLinksHistoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _InviteLinksHistoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<InviteLinkHistoryItemDto> items,  InviteLinksMetaDto meta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteLinksHistoryDto() when $default != null:
return $default(_that.items,_that.meta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<InviteLinkHistoryItemDto> items,  InviteLinksMetaDto meta)  $default,) {final _that = this;
switch (_that) {
case _InviteLinksHistoryDto():
return $default(_that.items,_that.meta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<InviteLinkHistoryItemDto> items,  InviteLinksMetaDto meta)?  $default,) {final _that = this;
switch (_that) {
case _InviteLinksHistoryDto() when $default != null:
return $default(_that.items,_that.meta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteLinksHistoryDto implements InviteLinksHistoryDto {
  const _InviteLinksHistoryDto({required final  List<InviteLinkHistoryItemDto> items, required this.meta}): _items = items;
  factory _InviteLinksHistoryDto.fromJson(Map<String, dynamic> json) => _$InviteLinksHistoryDtoFromJson(json);

 final  List<InviteLinkHistoryItemDto> _items;
@override List<InviteLinkHistoryItemDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  InviteLinksMetaDto meta;

/// Create a copy of InviteLinksHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteLinksHistoryDtoCopyWith<_InviteLinksHistoryDto> get copyWith => __$InviteLinksHistoryDtoCopyWithImpl<_InviteLinksHistoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteLinksHistoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteLinksHistoryDto&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.meta, meta) || other.meta == meta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),meta);

@override
String toString() {
  return 'InviteLinksHistoryDto(items: $items, meta: $meta)';
}


}

/// @nodoc
abstract mixin class _$InviteLinksHistoryDtoCopyWith<$Res> implements $InviteLinksHistoryDtoCopyWith<$Res> {
  factory _$InviteLinksHistoryDtoCopyWith(_InviteLinksHistoryDto value, $Res Function(_InviteLinksHistoryDto) _then) = __$InviteLinksHistoryDtoCopyWithImpl;
@override @useResult
$Res call({
 List<InviteLinkHistoryItemDto> items, InviteLinksMetaDto meta
});


@override $InviteLinksMetaDtoCopyWith<$Res> get meta;

}
/// @nodoc
class __$InviteLinksHistoryDtoCopyWithImpl<$Res>
    implements _$InviteLinksHistoryDtoCopyWith<$Res> {
  __$InviteLinksHistoryDtoCopyWithImpl(this._self, this._then);

  final _InviteLinksHistoryDto _self;
  final $Res Function(_InviteLinksHistoryDto) _then;

/// Create a copy of InviteLinksHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? meta = null,}) {
  return _then(_InviteLinksHistoryDto(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<InviteLinkHistoryItemDto>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as InviteLinksMetaDto,
  ));
}

/// Create a copy of InviteLinksHistoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InviteLinksMetaDtoCopyWith<$Res> get meta {
  
  return $InviteLinksMetaDtoCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}

// dart format on
