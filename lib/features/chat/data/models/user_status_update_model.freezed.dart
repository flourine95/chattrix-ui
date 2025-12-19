// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_status_update_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserStatusUpdateModel {

 String get userId; String get username;@JsonKey(name: 'fullName') String get displayName;@JsonKey(name: 'online') bool get isOnline; String? get lastSeen;
/// Create a copy of UserStatusUpdateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserStatusUpdateModelCopyWith<UserStatusUpdateModel> get copyWith => _$UserStatusUpdateModelCopyWithImpl<UserStatusUpdateModel>(this as UserStatusUpdateModel, _$identity);

  /// Serializes this UserStatusUpdateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserStatusUpdateModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username,displayName,isOnline,lastSeen);

@override
String toString() {
  return 'UserStatusUpdateModel(userId: $userId, username: $username, displayName: $displayName, isOnline: $isOnline, lastSeen: $lastSeen)';
}


}

/// @nodoc
abstract mixin class $UserStatusUpdateModelCopyWith<$Res>  {
  factory $UserStatusUpdateModelCopyWith(UserStatusUpdateModel value, $Res Function(UserStatusUpdateModel) _then) = _$UserStatusUpdateModelCopyWithImpl;
@useResult
$Res call({
 String userId, String username,@JsonKey(name: 'fullName') String displayName,@JsonKey(name: 'online') bool isOnline, String? lastSeen
});




}
/// @nodoc
class _$UserStatusUpdateModelCopyWithImpl<$Res>
    implements $UserStatusUpdateModelCopyWith<$Res> {
  _$UserStatusUpdateModelCopyWithImpl(this._self, this._then);

  final UserStatusUpdateModel _self;
  final $Res Function(UserStatusUpdateModel) _then;

/// Create a copy of UserStatusUpdateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,Object? displayName = null,Object? isOnline = null,Object? lastSeen = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserStatusUpdateModel].
extension UserStatusUpdateModelPatterns on UserStatusUpdateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserStatusUpdateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserStatusUpdateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserStatusUpdateModel value)  $default,){
final _that = this;
switch (_that) {
case _UserStatusUpdateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserStatusUpdateModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserStatusUpdateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String username, @JsonKey(name: 'fullName')  String displayName, @JsonKey(name: 'online')  bool isOnline,  String? lastSeen)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserStatusUpdateModel() when $default != null:
return $default(_that.userId,_that.username,_that.displayName,_that.isOnline,_that.lastSeen);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String username, @JsonKey(name: 'fullName')  String displayName, @JsonKey(name: 'online')  bool isOnline,  String? lastSeen)  $default,) {final _that = this;
switch (_that) {
case _UserStatusUpdateModel():
return $default(_that.userId,_that.username,_that.displayName,_that.isOnline,_that.lastSeen);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String username, @JsonKey(name: 'fullName')  String displayName, @JsonKey(name: 'online')  bool isOnline,  String? lastSeen)?  $default,) {final _that = this;
switch (_that) {
case _UserStatusUpdateModel() when $default != null:
return $default(_that.userId,_that.username,_that.displayName,_that.isOnline,_that.lastSeen);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserStatusUpdateModel extends UserStatusUpdateModel {
  const _UserStatusUpdateModel({required this.userId, required this.username, @JsonKey(name: 'fullName') required this.displayName, @JsonKey(name: 'online') required this.isOnline, this.lastSeen}): super._();
  factory _UserStatusUpdateModel.fromJson(Map<String, dynamic> json) => _$UserStatusUpdateModelFromJson(json);

@override final  String userId;
@override final  String username;
@override@JsonKey(name: 'fullName') final  String displayName;
@override@JsonKey(name: 'online') final  bool isOnline;
@override final  String? lastSeen;

/// Create a copy of UserStatusUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserStatusUpdateModelCopyWith<_UserStatusUpdateModel> get copyWith => __$UserStatusUpdateModelCopyWithImpl<_UserStatusUpdateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserStatusUpdateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserStatusUpdateModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.lastSeen, lastSeen) || other.lastSeen == lastSeen));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username,displayName,isOnline,lastSeen);

@override
String toString() {
  return 'UserStatusUpdateModel(userId: $userId, username: $username, displayName: $displayName, isOnline: $isOnline, lastSeen: $lastSeen)';
}


}

/// @nodoc
abstract mixin class _$UserStatusUpdateModelCopyWith<$Res> implements $UserStatusUpdateModelCopyWith<$Res> {
  factory _$UserStatusUpdateModelCopyWith(_UserStatusUpdateModel value, $Res Function(_UserStatusUpdateModel) _then) = __$UserStatusUpdateModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String username,@JsonKey(name: 'fullName') String displayName,@JsonKey(name: 'online') bool isOnline, String? lastSeen
});




}
/// @nodoc
class __$UserStatusUpdateModelCopyWithImpl<$Res>
    implements _$UserStatusUpdateModelCopyWith<$Res> {
  __$UserStatusUpdateModelCopyWithImpl(this._self, this._then);

  final _UserStatusUpdateModel _self;
  final $Res Function(_UserStatusUpdateModel) _then;

/// Create a copy of UserStatusUpdateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? displayName = null,Object? isOnline = null,Object? lastSeen = freezed,}) {
  return _then(_UserStatusUpdateModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,lastSeen: freezed == lastSeen ? _self.lastSeen : lastSeen // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
