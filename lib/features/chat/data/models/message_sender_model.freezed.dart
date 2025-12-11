// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_sender_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageSenderModel {

 int get id; String get username; String get fullName; String? get avatarUrl;
/// Create a copy of MessageSenderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageSenderModelCopyWith<MessageSenderModel> get copyWith => _$MessageSenderModelCopyWithImpl<MessageSenderModel>(this as MessageSenderModel, _$identity);

  /// Serializes this MessageSenderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageSenderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,fullName,avatarUrl);

@override
String toString() {
  return 'MessageSenderModel(id: $id, username: $username, fullName: $fullName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $MessageSenderModelCopyWith<$Res>  {
  factory $MessageSenderModelCopyWith(MessageSenderModel value, $Res Function(MessageSenderModel) _then) = _$MessageSenderModelCopyWithImpl;
@useResult
$Res call({
 int id, String username, String fullName, String? avatarUrl
});




}
/// @nodoc
class _$MessageSenderModelCopyWithImpl<$Res>
    implements $MessageSenderModelCopyWith<$Res> {
  _$MessageSenderModelCopyWithImpl(this._self, this._then);

  final MessageSenderModel _self;
  final $Res Function(MessageSenderModel) _then;

/// Create a copy of MessageSenderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageSenderModel].
extension MessageSenderModelPatterns on MessageSenderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageSenderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageSenderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageSenderModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageSenderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageSenderModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageSenderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String username,  String fullName,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageSenderModel() when $default != null:
return $default(_that.id,_that.username,_that.fullName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String username,  String fullName,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _MessageSenderModel():
return $default(_that.id,_that.username,_that.fullName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String username,  String fullName,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _MessageSenderModel() when $default != null:
return $default(_that.id,_that.username,_that.fullName,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageSenderModel extends MessageSenderModel {
  const _MessageSenderModel({required this.id, required this.username, required this.fullName, this.avatarUrl}): super._();
  factory _MessageSenderModel.fromJson(Map<String, dynamic> json) => _$MessageSenderModelFromJson(json);

@override final  int id;
@override final  String username;
@override final  String fullName;
@override final  String? avatarUrl;

/// Create a copy of MessageSenderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageSenderModelCopyWith<_MessageSenderModel> get copyWith => __$MessageSenderModelCopyWithImpl<_MessageSenderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageSenderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageSenderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,fullName,avatarUrl);

@override
String toString() {
  return 'MessageSenderModel(id: $id, username: $username, fullName: $fullName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$MessageSenderModelCopyWith<$Res> implements $MessageSenderModelCopyWith<$Res> {
  factory _$MessageSenderModelCopyWith(_MessageSenderModel value, $Res Function(_MessageSenderModel) _then) = __$MessageSenderModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String fullName, String? avatarUrl
});




}
/// @nodoc
class __$MessageSenderModelCopyWithImpl<$Res>
    implements _$MessageSenderModelCopyWith<$Res> {
  __$MessageSenderModelCopyWithImpl(this._self, this._then);

  final _MessageSenderModel _self;
  final $Res Function(_MessageSenderModel) _then;

/// Create a copy of MessageSenderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,}) {
  return _then(_MessageSenderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
