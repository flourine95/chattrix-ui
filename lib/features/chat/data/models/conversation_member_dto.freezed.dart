// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_member_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConversationMemberDto {

 int get id; String get fullName; String get username; String get email; String? get avatarUrl; bool get online;
/// Create a copy of ConversationMemberDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationMemberDtoCopyWith<ConversationMemberDto> get copyWith => _$ConversationMemberDtoCopyWithImpl<ConversationMemberDto>(this as ConversationMemberDto, _$identity);

  /// Serializes this ConversationMemberDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationMemberDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.online, online) || other.online == online));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,username,email,avatarUrl,online);

@override
String toString() {
  return 'ConversationMemberDto(id: $id, fullName: $fullName, username: $username, email: $email, avatarUrl: $avatarUrl, online: $online)';
}


}

/// @nodoc
abstract mixin class $ConversationMemberDtoCopyWith<$Res>  {
  factory $ConversationMemberDtoCopyWith(ConversationMemberDto value, $Res Function(ConversationMemberDto) _then) = _$ConversationMemberDtoCopyWithImpl;
@useResult
$Res call({
 int id, String fullName, String username, String email, String? avatarUrl, bool online
});




}
/// @nodoc
class _$ConversationMemberDtoCopyWithImpl<$Res>
    implements $ConversationMemberDtoCopyWith<$Res> {
  _$ConversationMemberDtoCopyWithImpl(this._self, this._then);

  final ConversationMemberDto _self;
  final $Res Function(ConversationMemberDto) _then;

/// Create a copy of ConversationMemberDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? username = null,Object? email = null,Object? avatarUrl = freezed,Object? online = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ConversationMemberDto].
extension ConversationMemberDtoPatterns on ConversationMemberDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationMemberDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationMemberDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationMemberDto value)  $default,){
final _that = this;
switch (_that) {
case _ConversationMemberDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationMemberDto value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationMemberDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String fullName,  String username,  String email,  String? avatarUrl,  bool online)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationMemberDto() when $default != null:
return $default(_that.id,_that.fullName,_that.username,_that.email,_that.avatarUrl,_that.online);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String fullName,  String username,  String email,  String? avatarUrl,  bool online)  $default,) {final _that = this;
switch (_that) {
case _ConversationMemberDto():
return $default(_that.id,_that.fullName,_that.username,_that.email,_that.avatarUrl,_that.online);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String fullName,  String username,  String email,  String? avatarUrl,  bool online)?  $default,) {final _that = this;
switch (_that) {
case _ConversationMemberDto() when $default != null:
return $default(_that.id,_that.fullName,_that.username,_that.email,_that.avatarUrl,_that.online);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConversationMemberDto implements ConversationMemberDto {
  const _ConversationMemberDto({required this.id, required this.fullName, required this.username, required this.email, this.avatarUrl, required this.online});
  factory _ConversationMemberDto.fromJson(Map<String, dynamic> json) => _$ConversationMemberDtoFromJson(json);

@override final  int id;
@override final  String fullName;
@override final  String username;
@override final  String email;
@override final  String? avatarUrl;
@override final  bool online;

/// Create a copy of ConversationMemberDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationMemberDtoCopyWith<_ConversationMemberDto> get copyWith => __$ConversationMemberDtoCopyWithImpl<_ConversationMemberDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationMemberDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationMemberDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.online, online) || other.online == online));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,username,email,avatarUrl,online);

@override
String toString() {
  return 'ConversationMemberDto(id: $id, fullName: $fullName, username: $username, email: $email, avatarUrl: $avatarUrl, online: $online)';
}


}

/// @nodoc
abstract mixin class _$ConversationMemberDtoCopyWith<$Res> implements $ConversationMemberDtoCopyWith<$Res> {
  factory _$ConversationMemberDtoCopyWith(_ConversationMemberDto value, $Res Function(_ConversationMemberDto) _then) = __$ConversationMemberDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String fullName, String username, String email, String? avatarUrl, bool online
});




}
/// @nodoc
class __$ConversationMemberDtoCopyWithImpl<$Res>
    implements _$ConversationMemberDtoCopyWith<$Res> {
  __$ConversationMemberDtoCopyWithImpl(this._self, this._then);

  final _ConversationMemberDto _self;
  final $Res Function(_ConversationMemberDto) _then;

/// Create a copy of ConversationMemberDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? username = null,Object? email = null,Object? avatarUrl = freezed,Object? online = null,}) {
  return _then(_ConversationMemberDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
