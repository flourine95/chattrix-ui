// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'birthday_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BirthdayUserDto {

 int get userId; String get username; String get fullName; String? get avatarUrl; DateTime? get dateOfBirth; int? get age; String get birthdayMessage;
/// Create a copy of BirthdayUserDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BirthdayUserDtoCopyWith<BirthdayUserDto> get copyWith => _$BirthdayUserDtoCopyWithImpl<BirthdayUserDto>(this as BirthdayUserDto, _$identity);

  /// Serializes this BirthdayUserDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BirthdayUserDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.age, age) || other.age == age)&&(identical(other.birthdayMessage, birthdayMessage) || other.birthdayMessage == birthdayMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,avatarUrl,dateOfBirth,age,birthdayMessage);

@override
String toString() {
  return 'BirthdayUserDto(userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, dateOfBirth: $dateOfBirth, age: $age, birthdayMessage: $birthdayMessage)';
}


}

/// @nodoc
abstract mixin class $BirthdayUserDtoCopyWith<$Res>  {
  factory $BirthdayUserDtoCopyWith(BirthdayUserDto value, $Res Function(BirthdayUserDto) _then) = _$BirthdayUserDtoCopyWithImpl;
@useResult
$Res call({
 int userId, String username, String fullName, String? avatarUrl, DateTime? dateOfBirth, int? age, String birthdayMessage
});




}
/// @nodoc
class _$BirthdayUserDtoCopyWithImpl<$Res>
    implements $BirthdayUserDtoCopyWith<$Res> {
  _$BirthdayUserDtoCopyWithImpl(this._self, this._then);

  final BirthdayUserDto _self;
  final $Res Function(BirthdayUserDto) _then;

/// Create a copy of BirthdayUserDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? dateOfBirth = freezed,Object? age = freezed,Object? birthdayMessage = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,birthdayMessage: null == birthdayMessage ? _self.birthdayMessage : birthdayMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BirthdayUserDto].
extension BirthdayUserDtoPatterns on BirthdayUserDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BirthdayUserDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BirthdayUserDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BirthdayUserDto value)  $default,){
final _that = this;
switch (_that) {
case _BirthdayUserDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BirthdayUserDto value)?  $default,){
final _that = this;
switch (_that) {
case _BirthdayUserDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String username,  String fullName,  String? avatarUrl,  DateTime? dateOfBirth,  int? age,  String birthdayMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BirthdayUserDto() when $default != null:
return $default(_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.dateOfBirth,_that.age,_that.birthdayMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String username,  String fullName,  String? avatarUrl,  DateTime? dateOfBirth,  int? age,  String birthdayMessage)  $default,) {final _that = this;
switch (_that) {
case _BirthdayUserDto():
return $default(_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.dateOfBirth,_that.age,_that.birthdayMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String username,  String fullName,  String? avatarUrl,  DateTime? dateOfBirth,  int? age,  String birthdayMessage)?  $default,) {final _that = this;
switch (_that) {
case _BirthdayUserDto() when $default != null:
return $default(_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.dateOfBirth,_that.age,_that.birthdayMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BirthdayUserDto implements BirthdayUserDto {
  const _BirthdayUserDto({required this.userId, required this.username, required this.fullName, this.avatarUrl, this.dateOfBirth, this.age, required this.birthdayMessage});
  factory _BirthdayUserDto.fromJson(Map<String, dynamic> json) => _$BirthdayUserDtoFromJson(json);

@override final  int userId;
@override final  String username;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  DateTime? dateOfBirth;
@override final  int? age;
@override final  String birthdayMessage;

/// Create a copy of BirthdayUserDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BirthdayUserDtoCopyWith<_BirthdayUserDto> get copyWith => __$BirthdayUserDtoCopyWithImpl<_BirthdayUserDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BirthdayUserDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BirthdayUserDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.age, age) || other.age == age)&&(identical(other.birthdayMessage, birthdayMessage) || other.birthdayMessage == birthdayMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,avatarUrl,dateOfBirth,age,birthdayMessage);

@override
String toString() {
  return 'BirthdayUserDto(userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, dateOfBirth: $dateOfBirth, age: $age, birthdayMessage: $birthdayMessage)';
}


}

/// @nodoc
abstract mixin class _$BirthdayUserDtoCopyWith<$Res> implements $BirthdayUserDtoCopyWith<$Res> {
  factory _$BirthdayUserDtoCopyWith(_BirthdayUserDto value, $Res Function(_BirthdayUserDto) _then) = __$BirthdayUserDtoCopyWithImpl;
@override @useResult
$Res call({
 int userId, String username, String fullName, String? avatarUrl, DateTime? dateOfBirth, int? age, String birthdayMessage
});




}
/// @nodoc
class __$BirthdayUserDtoCopyWithImpl<$Res>
    implements _$BirthdayUserDtoCopyWith<$Res> {
  __$BirthdayUserDtoCopyWithImpl(this._self, this._then);

  final _BirthdayUserDto _self;
  final $Res Function(_BirthdayUserDto) _then;

/// Create a copy of BirthdayUserDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? dateOfBirth = freezed,Object? age = freezed,Object? birthdayMessage = null,}) {
  return _then(_BirthdayUserDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,birthdayMessage: null == birthdayMessage ? _self.birthdayMessage : birthdayMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
