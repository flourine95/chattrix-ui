// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FriendRequest {

 int get id; int get senderUserId; int get receiverUserId; String get senderUsername; String get senderFullName; String? get senderAvatarUrl; String get receiverUsername; String get receiverFullName; String? get receiverAvatarUrl; String? get nickname; FriendRequestStatus get status; DateTime get createdAt; DateTime? get respondedAt;
/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestCopyWith<FriendRequest> get copyWith => _$FriendRequestCopyWithImpl<FriendRequest>(this as FriendRequest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.senderUserId, senderUserId) || other.senderUserId == senderUserId)&&(identical(other.receiverUserId, receiverUserId) || other.receiverUserId == receiverUserId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.senderAvatarUrl, senderAvatarUrl) || other.senderAvatarUrl == senderAvatarUrl)&&(identical(other.receiverUsername, receiverUsername) || other.receiverUsername == receiverUsername)&&(identical(other.receiverFullName, receiverFullName) || other.receiverFullName == receiverFullName)&&(identical(other.receiverAvatarUrl, receiverAvatarUrl) || other.receiverAvatarUrl == receiverAvatarUrl)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,senderUserId,receiverUserId,senderUsername,senderFullName,senderAvatarUrl,receiverUsername,receiverFullName,receiverAvatarUrl,nickname,status,createdAt,respondedAt);

@override
String toString() {
  return 'FriendRequest(id: $id, senderUserId: $senderUserId, receiverUserId: $receiverUserId, senderUsername: $senderUsername, senderFullName: $senderFullName, senderAvatarUrl: $senderAvatarUrl, receiverUsername: $receiverUsername, receiverFullName: $receiverFullName, receiverAvatarUrl: $receiverAvatarUrl, nickname: $nickname, status: $status, createdAt: $createdAt, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class $FriendRequestCopyWith<$Res>  {
  factory $FriendRequestCopyWith(FriendRequest value, $Res Function(FriendRequest) _then) = _$FriendRequestCopyWithImpl;
@useResult
$Res call({
 int id, int senderUserId, int receiverUserId, String senderUsername, String senderFullName, String? senderAvatarUrl, String receiverUsername, String receiverFullName, String? receiverAvatarUrl, String? nickname, FriendRequestStatus status, DateTime createdAt, DateTime? respondedAt
});




}
/// @nodoc
class _$FriendRequestCopyWithImpl<$Res>
    implements $FriendRequestCopyWith<$Res> {
  _$FriendRequestCopyWithImpl(this._self, this._then);

  final FriendRequest _self;
  final $Res Function(FriendRequest) _then;

/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderUserId = null,Object? receiverUserId = null,Object? senderUsername = null,Object? senderFullName = null,Object? senderAvatarUrl = freezed,Object? receiverUsername = null,Object? receiverFullName = null,Object? receiverAvatarUrl = freezed,Object? nickname = freezed,Object? status = null,Object? createdAt = null,Object? respondedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,senderUserId: null == senderUserId ? _self.senderUserId : senderUserId // ignore: cast_nullable_to_non_nullable
as int,receiverUserId: null == receiverUserId ? _self.receiverUserId : receiverUserId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: null == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String,senderFullName: null == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String,senderAvatarUrl: freezed == senderAvatarUrl ? _self.senderAvatarUrl : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,receiverUsername: null == receiverUsername ? _self.receiverUsername : receiverUsername // ignore: cast_nullable_to_non_nullable
as String,receiverFullName: null == receiverFullName ? _self.receiverFullName : receiverFullName // ignore: cast_nullable_to_non_nullable
as String,receiverAvatarUrl: freezed == receiverAvatarUrl ? _self.receiverAvatarUrl : receiverAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendRequestStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendRequest].
extension FriendRequestPatterns on FriendRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendRequest value)  $default,){
final _that = this;
switch (_that) {
case _FriendRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendRequest value)?  $default,){
final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int senderUserId,  int receiverUserId,  String senderUsername,  String senderFullName,  String? senderAvatarUrl,  String receiverUsername,  String receiverFullName,  String? receiverAvatarUrl,  String? nickname,  FriendRequestStatus status,  DateTime createdAt,  DateTime? respondedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
return $default(_that.id,_that.senderUserId,_that.receiverUserId,_that.senderUsername,_that.senderFullName,_that.senderAvatarUrl,_that.receiverUsername,_that.receiverFullName,_that.receiverAvatarUrl,_that.nickname,_that.status,_that.createdAt,_that.respondedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int senderUserId,  int receiverUserId,  String senderUsername,  String senderFullName,  String? senderAvatarUrl,  String receiverUsername,  String receiverFullName,  String? receiverAvatarUrl,  String? nickname,  FriendRequestStatus status,  DateTime createdAt,  DateTime? respondedAt)  $default,) {final _that = this;
switch (_that) {
case _FriendRequest():
return $default(_that.id,_that.senderUserId,_that.receiverUserId,_that.senderUsername,_that.senderFullName,_that.senderAvatarUrl,_that.receiverUsername,_that.receiverFullName,_that.receiverAvatarUrl,_that.nickname,_that.status,_that.createdAt,_that.respondedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int senderUserId,  int receiverUserId,  String senderUsername,  String senderFullName,  String? senderAvatarUrl,  String receiverUsername,  String receiverFullName,  String? receiverAvatarUrl,  String? nickname,  FriendRequestStatus status,  DateTime createdAt,  DateTime? respondedAt)?  $default,) {final _that = this;
switch (_that) {
case _FriendRequest() when $default != null:
return $default(_that.id,_that.senderUserId,_that.receiverUserId,_that.senderUsername,_that.senderFullName,_that.senderAvatarUrl,_that.receiverUsername,_that.receiverFullName,_that.receiverAvatarUrl,_that.nickname,_that.status,_that.createdAt,_that.respondedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FriendRequest implements FriendRequest {
  const _FriendRequest({required this.id, required this.senderUserId, required this.receiverUserId, required this.senderUsername, required this.senderFullName, this.senderAvatarUrl, required this.receiverUsername, required this.receiverFullName, this.receiverAvatarUrl, this.nickname, required this.status, required this.createdAt, this.respondedAt});
  

@override final  int id;
@override final  int senderUserId;
@override final  int receiverUserId;
@override final  String senderUsername;
@override final  String senderFullName;
@override final  String? senderAvatarUrl;
@override final  String receiverUsername;
@override final  String receiverFullName;
@override final  String? receiverAvatarUrl;
@override final  String? nickname;
@override final  FriendRequestStatus status;
@override final  DateTime createdAt;
@override final  DateTime? respondedAt;

/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendRequestCopyWith<_FriendRequest> get copyWith => __$FriendRequestCopyWithImpl<_FriendRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.senderUserId, senderUserId) || other.senderUserId == senderUserId)&&(identical(other.receiverUserId, receiverUserId) || other.receiverUserId == receiverUserId)&&(identical(other.senderUsername, senderUsername) || other.senderUsername == senderUsername)&&(identical(other.senderFullName, senderFullName) || other.senderFullName == senderFullName)&&(identical(other.senderAvatarUrl, senderAvatarUrl) || other.senderAvatarUrl == senderAvatarUrl)&&(identical(other.receiverUsername, receiverUsername) || other.receiverUsername == receiverUsername)&&(identical(other.receiverFullName, receiverFullName) || other.receiverFullName == receiverFullName)&&(identical(other.receiverAvatarUrl, receiverAvatarUrl) || other.receiverAvatarUrl == receiverAvatarUrl)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,senderUserId,receiverUserId,senderUsername,senderFullName,senderAvatarUrl,receiverUsername,receiverFullName,receiverAvatarUrl,nickname,status,createdAt,respondedAt);

@override
String toString() {
  return 'FriendRequest(id: $id, senderUserId: $senderUserId, receiverUserId: $receiverUserId, senderUsername: $senderUsername, senderFullName: $senderFullName, senderAvatarUrl: $senderAvatarUrl, receiverUsername: $receiverUsername, receiverFullName: $receiverFullName, receiverAvatarUrl: $receiverAvatarUrl, nickname: $nickname, status: $status, createdAt: $createdAt, respondedAt: $respondedAt)';
}


}

/// @nodoc
abstract mixin class _$FriendRequestCopyWith<$Res> implements $FriendRequestCopyWith<$Res> {
  factory _$FriendRequestCopyWith(_FriendRequest value, $Res Function(_FriendRequest) _then) = __$FriendRequestCopyWithImpl;
@override @useResult
$Res call({
 int id, int senderUserId, int receiverUserId, String senderUsername, String senderFullName, String? senderAvatarUrl, String receiverUsername, String receiverFullName, String? receiverAvatarUrl, String? nickname, FriendRequestStatus status, DateTime createdAt, DateTime? respondedAt
});




}
/// @nodoc
class __$FriendRequestCopyWithImpl<$Res>
    implements _$FriendRequestCopyWith<$Res> {
  __$FriendRequestCopyWithImpl(this._self, this._then);

  final _FriendRequest _self;
  final $Res Function(_FriendRequest) _then;

/// Create a copy of FriendRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderUserId = null,Object? receiverUserId = null,Object? senderUsername = null,Object? senderFullName = null,Object? senderAvatarUrl = freezed,Object? receiverUsername = null,Object? receiverFullName = null,Object? receiverAvatarUrl = freezed,Object? nickname = freezed,Object? status = null,Object? createdAt = null,Object? respondedAt = freezed,}) {
  return _then(_FriendRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,senderUserId: null == senderUserId ? _self.senderUserId : senderUserId // ignore: cast_nullable_to_non_nullable
as int,receiverUserId: null == receiverUserId ? _self.receiverUserId : receiverUserId // ignore: cast_nullable_to_non_nullable
as int,senderUsername: null == senderUsername ? _self.senderUsername : senderUsername // ignore: cast_nullable_to_non_nullable
as String,senderFullName: null == senderFullName ? _self.senderFullName : senderFullName // ignore: cast_nullable_to_non_nullable
as String,senderAvatarUrl: freezed == senderAvatarUrl ? _self.senderAvatarUrl : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,receiverUsername: null == receiverUsername ? _self.receiverUsername : receiverUsername // ignore: cast_nullable_to_non_nullable
as String,receiverFullName: null == receiverFullName ? _self.receiverFullName : receiverFullName // ignore: cast_nullable_to_non_nullable
as String,receiverAvatarUrl: freezed == receiverAvatarUrl ? _self.receiverAvatarUrl : receiverAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendRequestStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
