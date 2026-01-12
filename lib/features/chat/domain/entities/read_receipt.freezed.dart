// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'read_receipt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReadReceipt {

 int get userId; String get username; String get fullName; String? get avatarUrl; DateTime get readAt;
/// Create a copy of ReadReceipt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadReceiptCopyWith<ReadReceipt> get copyWith => _$ReadReceiptCopyWithImpl<ReadReceipt>(this as ReadReceipt, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadReceipt&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.readAt, readAt) || other.readAt == readAt));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,avatarUrl,readAt);

@override
String toString() {
  return 'ReadReceipt(userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, readAt: $readAt)';
}


}

/// @nodoc
abstract mixin class $ReadReceiptCopyWith<$Res>  {
  factory $ReadReceiptCopyWith(ReadReceipt value, $Res Function(ReadReceipt) _then) = _$ReadReceiptCopyWithImpl;
@useResult
$Res call({
 int userId, String username, String fullName, String? avatarUrl, DateTime readAt
});




}
/// @nodoc
class _$ReadReceiptCopyWithImpl<$Res>
    implements $ReadReceiptCopyWith<$Res> {
  _$ReadReceiptCopyWithImpl(this._self, this._then);

  final ReadReceipt _self;
  final $Res Function(ReadReceipt) _then;

/// Create a copy of ReadReceipt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? readAt = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,readAt: null == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadReceipt].
extension ReadReceiptPatterns on ReadReceipt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadReceipt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadReceipt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadReceipt value)  $default,){
final _that = this;
switch (_that) {
case _ReadReceipt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadReceipt value)?  $default,){
final _that = this;
switch (_that) {
case _ReadReceipt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String username,  String fullName,  String? avatarUrl,  DateTime readAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadReceipt() when $default != null:
return $default(_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.readAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String username,  String fullName,  String? avatarUrl,  DateTime readAt)  $default,) {final _that = this;
switch (_that) {
case _ReadReceipt():
return $default(_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.readAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String username,  String fullName,  String? avatarUrl,  DateTime readAt)?  $default,) {final _that = this;
switch (_that) {
case _ReadReceipt() when $default != null:
return $default(_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.readAt);case _:
  return null;

}
}

}

/// @nodoc


class _ReadReceipt implements ReadReceipt {
  const _ReadReceipt({required this.userId, required this.username, required this.fullName, this.avatarUrl, required this.readAt});
  

@override final  int userId;
@override final  String username;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  DateTime readAt;

/// Create a copy of ReadReceipt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadReceiptCopyWith<_ReadReceipt> get copyWith => __$ReadReceiptCopyWithImpl<_ReadReceipt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadReceipt&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.readAt, readAt) || other.readAt == readAt));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,avatarUrl,readAt);

@override
String toString() {
  return 'ReadReceipt(userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, readAt: $readAt)';
}


}

/// @nodoc
abstract mixin class _$ReadReceiptCopyWith<$Res> implements $ReadReceiptCopyWith<$Res> {
  factory _$ReadReceiptCopyWith(_ReadReceipt value, $Res Function(_ReadReceipt) _then) = __$ReadReceiptCopyWithImpl;
@override @useResult
$Res call({
 int userId, String username, String fullName, String? avatarUrl, DateTime readAt
});




}
/// @nodoc
class __$ReadReceiptCopyWithImpl<$Res>
    implements _$ReadReceiptCopyWith<$Res> {
  __$ReadReceiptCopyWithImpl(this._self, this._then);

  final _ReadReceipt _self;
  final $Res Function(_ReadReceipt) _then;

/// Create a copy of ReadReceipt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? readAt = null,}) {
  return _then(_ReadReceipt(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,readAt: null == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
