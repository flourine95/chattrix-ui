// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'birthday.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Birthday {

 int get userId; String get username; String get fullName; String? get avatarUrl; DateTime get dateOfBirth; int get age; String get birthdayMessage;
/// Create a copy of Birthday
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BirthdayCopyWith<Birthday> get copyWith => _$BirthdayCopyWithImpl<Birthday>(this as Birthday, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Birthday&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.age, age) || other.age == age)&&(identical(other.birthdayMessage, birthdayMessage) || other.birthdayMessage == birthdayMessage));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,avatarUrl,dateOfBirth,age,birthdayMessage);

@override
String toString() {
  return 'Birthday(userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, dateOfBirth: $dateOfBirth, age: $age, birthdayMessage: $birthdayMessage)';
}


}

/// @nodoc
abstract mixin class $BirthdayCopyWith<$Res>  {
  factory $BirthdayCopyWith(Birthday value, $Res Function(Birthday) _then) = _$BirthdayCopyWithImpl;
@useResult
$Res call({
 int userId, String username, String fullName, String? avatarUrl, DateTime dateOfBirth, int age, String birthdayMessage
});




}
/// @nodoc
class _$BirthdayCopyWithImpl<$Res>
    implements $BirthdayCopyWith<$Res> {
  _$BirthdayCopyWithImpl(this._self, this._then);

  final Birthday _self;
  final $Res Function(Birthday) _then;

/// Create a copy of Birthday
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? dateOfBirth = null,Object? age = null,Object? birthdayMessage = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,birthdayMessage: null == birthdayMessage ? _self.birthdayMessage : birthdayMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Birthday].
extension BirthdayPatterns on Birthday {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Birthday value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Birthday() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Birthday value)  $default,){
final _that = this;
switch (_that) {
case _Birthday():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Birthday value)?  $default,){
final _that = this;
switch (_that) {
case _Birthday() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String username,  String fullName,  String? avatarUrl,  DateTime dateOfBirth,  int age,  String birthdayMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Birthday() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String username,  String fullName,  String? avatarUrl,  DateTime dateOfBirth,  int age,  String birthdayMessage)  $default,) {final _that = this;
switch (_that) {
case _Birthday():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String username,  String fullName,  String? avatarUrl,  DateTime dateOfBirth,  int age,  String birthdayMessage)?  $default,) {final _that = this;
switch (_that) {
case _Birthday() when $default != null:
return $default(_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.dateOfBirth,_that.age,_that.birthdayMessage);case _:
  return null;

}
}

}

/// @nodoc


class _Birthday implements Birthday {
  const _Birthday({required this.userId, required this.username, required this.fullName, this.avatarUrl, required this.dateOfBirth, required this.age, required this.birthdayMessage});
  

@override final  int userId;
@override final  String username;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  DateTime dateOfBirth;
@override final  int age;
@override final  String birthdayMessage;

/// Create a copy of Birthday
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BirthdayCopyWith<_Birthday> get copyWith => __$BirthdayCopyWithImpl<_Birthday>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Birthday&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.age, age) || other.age == age)&&(identical(other.birthdayMessage, birthdayMessage) || other.birthdayMessage == birthdayMessage));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,avatarUrl,dateOfBirth,age,birthdayMessage);

@override
String toString() {
  return 'Birthday(userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, dateOfBirth: $dateOfBirth, age: $age, birthdayMessage: $birthdayMessage)';
}


}

/// @nodoc
abstract mixin class _$BirthdayCopyWith<$Res> implements $BirthdayCopyWith<$Res> {
  factory _$BirthdayCopyWith(_Birthday value, $Res Function(_Birthday) _then) = __$BirthdayCopyWithImpl;
@override @useResult
$Res call({
 int userId, String username, String fullName, String? avatarUrl, DateTime dateOfBirth, int age, String birthdayMessage
});




}
/// @nodoc
class __$BirthdayCopyWithImpl<$Res>
    implements _$BirthdayCopyWith<$Res> {
  __$BirthdayCopyWithImpl(this._self, this._then);

  final _Birthday _self;
  final $Res Function(_Birthday) _then;

/// Create a copy of Birthday
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? dateOfBirth = null,Object? age = null,Object? birthdayMessage = null,}) {
  return _then(_Birthday(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,birthdayMessage: null == birthdayMessage ? _self.birthdayMessage : birthdayMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SendBirthdayWishes {

 int get conversationCount; int get userId;
/// Create a copy of SendBirthdayWishes
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendBirthdayWishesCopyWith<SendBirthdayWishes> get copyWith => _$SendBirthdayWishesCopyWithImpl<SendBirthdayWishes>(this as SendBirthdayWishes, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendBirthdayWishes&&(identical(other.conversationCount, conversationCount) || other.conversationCount == conversationCount)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationCount,userId);

@override
String toString() {
  return 'SendBirthdayWishes(conversationCount: $conversationCount, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $SendBirthdayWishesCopyWith<$Res>  {
  factory $SendBirthdayWishesCopyWith(SendBirthdayWishes value, $Res Function(SendBirthdayWishes) _then) = _$SendBirthdayWishesCopyWithImpl;
@useResult
$Res call({
 int conversationCount, int userId
});




}
/// @nodoc
class _$SendBirthdayWishesCopyWithImpl<$Res>
    implements $SendBirthdayWishesCopyWith<$Res> {
  _$SendBirthdayWishesCopyWithImpl(this._self, this._then);

  final SendBirthdayWishes _self;
  final $Res Function(SendBirthdayWishes) _then;

/// Create a copy of SendBirthdayWishes
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationCount = null,Object? userId = null,}) {
  return _then(_self.copyWith(
conversationCount: null == conversationCount ? _self.conversationCount : conversationCount // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SendBirthdayWishes].
extension SendBirthdayWishesPatterns on SendBirthdayWishes {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendBirthdayWishes value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendBirthdayWishes() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendBirthdayWishes value)  $default,){
final _that = this;
switch (_that) {
case _SendBirthdayWishes():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendBirthdayWishes value)?  $default,){
final _that = this;
switch (_that) {
case _SendBirthdayWishes() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int conversationCount,  int userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendBirthdayWishes() when $default != null:
return $default(_that.conversationCount,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int conversationCount,  int userId)  $default,) {final _that = this;
switch (_that) {
case _SendBirthdayWishes():
return $default(_that.conversationCount,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int conversationCount,  int userId)?  $default,) {final _that = this;
switch (_that) {
case _SendBirthdayWishes() when $default != null:
return $default(_that.conversationCount,_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class _SendBirthdayWishes implements SendBirthdayWishes {
  const _SendBirthdayWishes({required this.conversationCount, required this.userId});
  

@override final  int conversationCount;
@override final  int userId;

/// Create a copy of SendBirthdayWishes
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendBirthdayWishesCopyWith<_SendBirthdayWishes> get copyWith => __$SendBirthdayWishesCopyWithImpl<_SendBirthdayWishes>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendBirthdayWishes&&(identical(other.conversationCount, conversationCount) || other.conversationCount == conversationCount)&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationCount,userId);

@override
String toString() {
  return 'SendBirthdayWishes(conversationCount: $conversationCount, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$SendBirthdayWishesCopyWith<$Res> implements $SendBirthdayWishesCopyWith<$Res> {
  factory _$SendBirthdayWishesCopyWith(_SendBirthdayWishes value, $Res Function(_SendBirthdayWishes) _then) = __$SendBirthdayWishesCopyWithImpl;
@override @useResult
$Res call({
 int conversationCount, int userId
});




}
/// @nodoc
class __$SendBirthdayWishesCopyWithImpl<$Res>
    implements _$SendBirthdayWishesCopyWith<$Res> {
  __$SendBirthdayWishesCopyWithImpl(this._self, this._then);

  final _SendBirthdayWishes _self;
  final $Res Function(_SendBirthdayWishes) _then;

/// Create a copy of SendBirthdayWishes
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationCount = null,Object? userId = null,}) {
  return _then(_SendBirthdayWishes(
conversationCount: null == conversationCount ? _self.conversationCount : conversationCount // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
