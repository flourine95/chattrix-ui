// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendRequestModel {

 int get id; int get userId; String get username; String get fullName; String? get avatarUrl; String? get nickname; FriendRequestStatus get status; DateTime get requestedAt; DateTime? get acceptedAt; DateTime? get rejectedAt; bool get online;
/// Create a copy of FriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestModelCopyWith<FriendRequestModel> get copyWith => _$FriendRequestModelCopyWithImpl<FriendRequestModel>(this as FriendRequestModel, _$identity);

  /// Serializes this FriendRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.acceptedAt, acceptedAt) || other.acceptedAt == acceptedAt)&&(identical(other.rejectedAt, rejectedAt) || other.rejectedAt == rejectedAt)&&(identical(other.online, online) || other.online == online));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,username,fullName,avatarUrl,nickname,status,requestedAt,acceptedAt,rejectedAt,online);

@override
String toString() {
  return 'FriendRequestModel(id: $id, userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, nickname: $nickname, status: $status, requestedAt: $requestedAt, acceptedAt: $acceptedAt, rejectedAt: $rejectedAt, online: $online)';
}


}

/// @nodoc
abstract mixin class $FriendRequestModelCopyWith<$Res>  {
  factory $FriendRequestModelCopyWith(FriendRequestModel value, $Res Function(FriendRequestModel) _then) = _$FriendRequestModelCopyWithImpl;
@useResult
$Res call({
 int id, int userId, String username, String fullName, String? avatarUrl, String? nickname, FriendRequestStatus status, DateTime requestedAt, DateTime? acceptedAt, DateTime? rejectedAt, bool online
});




}
/// @nodoc
class _$FriendRequestModelCopyWithImpl<$Res>
    implements $FriendRequestModelCopyWith<$Res> {
  _$FriendRequestModelCopyWithImpl(this._self, this._then);

  final FriendRequestModel _self;
  final $Res Function(FriendRequestModel) _then;

/// Create a copy of FriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? nickname = freezed,Object? status = null,Object? requestedAt = null,Object? acceptedAt = freezed,Object? rejectedAt = freezed,Object? online = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendRequestStatus,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,acceptedAt: freezed == acceptedAt ? _self.acceptedAt : acceptedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectedAt: freezed == rejectedAt ? _self.rejectedAt : rejectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendRequestModel].
extension FriendRequestModelPatterns on FriendRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _FriendRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _FriendRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int userId,  String username,  String fullName,  String? avatarUrl,  String? nickname,  FriendRequestStatus status,  DateTime requestedAt,  DateTime? acceptedAt,  DateTime? rejectedAt,  bool online)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendRequestModel() when $default != null:
return $default(_that.id,_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.nickname,_that.status,_that.requestedAt,_that.acceptedAt,_that.rejectedAt,_that.online);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int userId,  String username,  String fullName,  String? avatarUrl,  String? nickname,  FriendRequestStatus status,  DateTime requestedAt,  DateTime? acceptedAt,  DateTime? rejectedAt,  bool online)  $default,) {final _that = this;
switch (_that) {
case _FriendRequestModel():
return $default(_that.id,_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.nickname,_that.status,_that.requestedAt,_that.acceptedAt,_that.rejectedAt,_that.online);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int userId,  String username,  String fullName,  String? avatarUrl,  String? nickname,  FriendRequestStatus status,  DateTime requestedAt,  DateTime? acceptedAt,  DateTime? rejectedAt,  bool online)?  $default,) {final _that = this;
switch (_that) {
case _FriendRequestModel() when $default != null:
return $default(_that.id,_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.nickname,_that.status,_that.requestedAt,_that.acceptedAt,_that.rejectedAt,_that.online);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendRequestModel extends FriendRequestModel {
  const _FriendRequestModel({required this.id, required this.userId, required this.username, required this.fullName, this.avatarUrl, this.nickname, required this.status, required this.requestedAt, this.acceptedAt, this.rejectedAt, this.online = false}): super._();
  factory _FriendRequestModel.fromJson(Map<String, dynamic> json) => _$FriendRequestModelFromJson(json);

@override final  int id;
@override final  int userId;
@override final  String username;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  String? nickname;
@override final  FriendRequestStatus status;
@override final  DateTime requestedAt;
@override final  DateTime? acceptedAt;
@override final  DateTime? rejectedAt;
@override@JsonKey() final  bool online;

/// Create a copy of FriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendRequestModelCopyWith<_FriendRequestModel> get copyWith => __$FriendRequestModelCopyWithImpl<_FriendRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt)&&(identical(other.acceptedAt, acceptedAt) || other.acceptedAt == acceptedAt)&&(identical(other.rejectedAt, rejectedAt) || other.rejectedAt == rejectedAt)&&(identical(other.online, online) || other.online == online));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,username,fullName,avatarUrl,nickname,status,requestedAt,acceptedAt,rejectedAt,online);

@override
String toString() {
  return 'FriendRequestModel(id: $id, userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, nickname: $nickname, status: $status, requestedAt: $requestedAt, acceptedAt: $acceptedAt, rejectedAt: $rejectedAt, online: $online)';
}


}

/// @nodoc
abstract mixin class _$FriendRequestModelCopyWith<$Res> implements $FriendRequestModelCopyWith<$Res> {
  factory _$FriendRequestModelCopyWith(_FriendRequestModel value, $Res Function(_FriendRequestModel) _then) = __$FriendRequestModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int userId, String username, String fullName, String? avatarUrl, String? nickname, FriendRequestStatus status, DateTime requestedAt, DateTime? acceptedAt, DateTime? rejectedAt, bool online
});




}
/// @nodoc
class __$FriendRequestModelCopyWithImpl<$Res>
    implements _$FriendRequestModelCopyWith<$Res> {
  __$FriendRequestModelCopyWithImpl(this._self, this._then);

  final _FriendRequestModel _self;
  final $Res Function(_FriendRequestModel) _then;

/// Create a copy of FriendRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? nickname = freezed,Object? status = null,Object? requestedAt = null,Object? acceptedAt = freezed,Object? rejectedAt = freezed,Object? online = null,}) {
  return _then(_FriendRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendRequestStatus,requestedAt: null == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime,acceptedAt: freezed == acceptedAt ? _self.acceptedAt : acceptedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectedAt: freezed == rejectedAt ? _self.rejectedAt : rejectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,online: null == online ? _self.online : online // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
