// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'birthday_user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BirthdayUserEntity {

 int get userId; String get username; String get fullName; String? get avatarUrl; DateTime? get dateOfBirth; int? get age; String get birthdayMessage;
/// Create a copy of BirthdayUserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BirthdayUserEntityCopyWith<BirthdayUserEntity> get copyWith => _$BirthdayUserEntityCopyWithImpl<BirthdayUserEntity>(this as BirthdayUserEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BirthdayUserEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.age, age) || other.age == age)&&(identical(other.birthdayMessage, birthdayMessage) || other.birthdayMessage == birthdayMessage));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,avatarUrl,dateOfBirth,age,birthdayMessage);

@override
String toString() {
  return 'BirthdayUserEntity(userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, dateOfBirth: $dateOfBirth, age: $age, birthdayMessage: $birthdayMessage)';
}


}

/// @nodoc
abstract mixin class $BirthdayUserEntityCopyWith<$Res>  {
  factory $BirthdayUserEntityCopyWith(BirthdayUserEntity value, $Res Function(BirthdayUserEntity) _then) = _$BirthdayUserEntityCopyWithImpl;
@useResult
$Res call({
 int userId, String username, String fullName, String? avatarUrl, DateTime? dateOfBirth, int? age, String birthdayMessage
});




}
/// @nodoc
class _$BirthdayUserEntityCopyWithImpl<$Res>
    implements $BirthdayUserEntityCopyWith<$Res> {
  _$BirthdayUserEntityCopyWithImpl(this._self, this._then);

  final BirthdayUserEntity _self;
  final $Res Function(BirthdayUserEntity) _then;

/// Create a copy of BirthdayUserEntity
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


/// Adds pattern-matching-related methods to [BirthdayUserEntity].
extension BirthdayUserEntityPatterns on BirthdayUserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BirthdayUserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BirthdayUserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BirthdayUserEntity value)  $default,){
final _that = this;
switch (_that) {
case _BirthdayUserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BirthdayUserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BirthdayUserEntity() when $default != null:
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
case _BirthdayUserEntity() when $default != null:
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
case _BirthdayUserEntity():
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
case _BirthdayUserEntity() when $default != null:
return $default(_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.dateOfBirth,_that.age,_that.birthdayMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BirthdayUserEntity implements BirthdayUserEntity {
  const _BirthdayUserEntity({required this.userId, required this.username, required this.fullName, this.avatarUrl, this.dateOfBirth, this.age, required this.birthdayMessage});
  

@override final  int userId;
@override final  String username;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  DateTime? dateOfBirth;
@override final  int? age;
@override final  String birthdayMessage;

/// Create a copy of BirthdayUserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BirthdayUserEntityCopyWith<_BirthdayUserEntity> get copyWith => __$BirthdayUserEntityCopyWithImpl<_BirthdayUserEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BirthdayUserEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.age, age) || other.age == age)&&(identical(other.birthdayMessage, birthdayMessage) || other.birthdayMessage == birthdayMessage));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,avatarUrl,dateOfBirth,age,birthdayMessage);

@override
String toString() {
  return 'BirthdayUserEntity(userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, dateOfBirth: $dateOfBirth, age: $age, birthdayMessage: $birthdayMessage)';
}


}

/// @nodoc
abstract mixin class _$BirthdayUserEntityCopyWith<$Res> implements $BirthdayUserEntityCopyWith<$Res> {
  factory _$BirthdayUserEntityCopyWith(_BirthdayUserEntity value, $Res Function(_BirthdayUserEntity) _then) = __$BirthdayUserEntityCopyWithImpl;
@override @useResult
$Res call({
 int userId, String username, String fullName, String? avatarUrl, DateTime? dateOfBirth, int? age, String birthdayMessage
});




}
/// @nodoc
class __$BirthdayUserEntityCopyWithImpl<$Res>
    implements _$BirthdayUserEntityCopyWith<$Res> {
  __$BirthdayUserEntityCopyWithImpl(this._self, this._then);

  final _BirthdayUserEntity _self;
  final $Res Function(_BirthdayUserEntity) _then;

/// Create a copy of BirthdayUserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? dateOfBirth = freezed,Object? age = freezed,Object? birthdayMessage = null,}) {
  return _then(_BirthdayUserEntity(
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
