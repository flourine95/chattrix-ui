// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'typing_indicator_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TypingIndicatorModel {

@JsonKey(fromJson: _conversationIdFromJson) String get conversationId; List<TypingUserModel> get typingUsers;
/// Create a copy of TypingIndicatorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypingIndicatorModelCopyWith<TypingIndicatorModel> get copyWith => _$TypingIndicatorModelCopyWithImpl<TypingIndicatorModel>(this as TypingIndicatorModel, _$identity);

  /// Serializes this TypingIndicatorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypingIndicatorModel&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&const DeepCollectionEquality().equals(other.typingUsers, typingUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationId,const DeepCollectionEquality().hash(typingUsers));

@override
String toString() {
  return 'TypingIndicatorModel(conversationId: $conversationId, typingUsers: $typingUsers)';
}


}

/// @nodoc
abstract mixin class $TypingIndicatorModelCopyWith<$Res>  {
  factory $TypingIndicatorModelCopyWith(TypingIndicatorModel value, $Res Function(TypingIndicatorModel) _then) = _$TypingIndicatorModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _conversationIdFromJson) String conversationId, List<TypingUserModel> typingUsers
});




}
/// @nodoc
class _$TypingIndicatorModelCopyWithImpl<$Res>
    implements $TypingIndicatorModelCopyWith<$Res> {
  _$TypingIndicatorModelCopyWithImpl(this._self, this._then);

  final TypingIndicatorModel _self;
  final $Res Function(TypingIndicatorModel) _then;

/// Create a copy of TypingIndicatorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,Object? typingUsers = null,}) {
  return _then(_self.copyWith(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,typingUsers: null == typingUsers ? _self.typingUsers : typingUsers // ignore: cast_nullable_to_non_nullable
as List<TypingUserModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [TypingIndicatorModel].
extension TypingIndicatorModelPatterns on TypingIndicatorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TypingIndicatorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TypingIndicatorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TypingIndicatorModel value)  $default,){
final _that = this;
switch (_that) {
case _TypingIndicatorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TypingIndicatorModel value)?  $default,){
final _that = this;
switch (_that) {
case _TypingIndicatorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _conversationIdFromJson)  String conversationId,  List<TypingUserModel> typingUsers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TypingIndicatorModel() when $default != null:
return $default(_that.conversationId,_that.typingUsers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _conversationIdFromJson)  String conversationId,  List<TypingUserModel> typingUsers)  $default,) {final _that = this;
switch (_that) {
case _TypingIndicatorModel():
return $default(_that.conversationId,_that.typingUsers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _conversationIdFromJson)  String conversationId,  List<TypingUserModel> typingUsers)?  $default,) {final _that = this;
switch (_that) {
case _TypingIndicatorModel() when $default != null:
return $default(_that.conversationId,_that.typingUsers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TypingIndicatorModel extends TypingIndicatorModel {
  const _TypingIndicatorModel({@JsonKey(fromJson: _conversationIdFromJson) required this.conversationId, required final  List<TypingUserModel> typingUsers}): _typingUsers = typingUsers,super._();
  factory _TypingIndicatorModel.fromJson(Map<String, dynamic> json) => _$TypingIndicatorModelFromJson(json);

@override@JsonKey(fromJson: _conversationIdFromJson) final  String conversationId;
 final  List<TypingUserModel> _typingUsers;
@override List<TypingUserModel> get typingUsers {
  if (_typingUsers is EqualUnmodifiableListView) return _typingUsers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_typingUsers);
}


/// Create a copy of TypingIndicatorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TypingIndicatorModelCopyWith<_TypingIndicatorModel> get copyWith => __$TypingIndicatorModelCopyWithImpl<_TypingIndicatorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TypingIndicatorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypingIndicatorModel&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&const DeepCollectionEquality().equals(other._typingUsers, _typingUsers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationId,const DeepCollectionEquality().hash(_typingUsers));

@override
String toString() {
  return 'TypingIndicatorModel(conversationId: $conversationId, typingUsers: $typingUsers)';
}


}

/// @nodoc
abstract mixin class _$TypingIndicatorModelCopyWith<$Res> implements $TypingIndicatorModelCopyWith<$Res> {
  factory _$TypingIndicatorModelCopyWith(_TypingIndicatorModel value, $Res Function(_TypingIndicatorModel) _then) = __$TypingIndicatorModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _conversationIdFromJson) String conversationId, List<TypingUserModel> typingUsers
});




}
/// @nodoc
class __$TypingIndicatorModelCopyWithImpl<$Res>
    implements _$TypingIndicatorModelCopyWith<$Res> {
  __$TypingIndicatorModelCopyWithImpl(this._self, this._then);

  final _TypingIndicatorModel _self;
  final $Res Function(_TypingIndicatorModel) _then;

/// Create a copy of TypingIndicatorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? typingUsers = null,}) {
  return _then(_TypingIndicatorModel(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,typingUsers: null == typingUsers ? _self._typingUsers : typingUsers // ignore: cast_nullable_to_non_nullable
as List<TypingUserModel>,
  ));
}


}


/// @nodoc
mixin _$TypingUserModel {

@JsonKey(name: 'userId', fromJson: _userIdFromJson) String get id; String get username; String get fullName;
/// Create a copy of TypingUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypingUserModelCopyWith<TypingUserModel> get copyWith => _$TypingUserModelCopyWithImpl<TypingUserModel>(this as TypingUserModel, _$identity);

  /// Serializes this TypingUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypingUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,fullName);

@override
String toString() {
  return 'TypingUserModel(id: $id, username: $username, fullName: $fullName)';
}


}

/// @nodoc
abstract mixin class $TypingUserModelCopyWith<$Res>  {
  factory $TypingUserModelCopyWith(TypingUserModel value, $Res Function(TypingUserModel) _then) = _$TypingUserModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'userId', fromJson: _userIdFromJson) String id, String username, String fullName
});




}
/// @nodoc
class _$TypingUserModelCopyWithImpl<$Res>
    implements $TypingUserModelCopyWith<$Res> {
  _$TypingUserModelCopyWithImpl(this._self, this._then);

  final TypingUserModel _self;
  final $Res Function(TypingUserModel) _then;

/// Create a copy of TypingUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? fullName = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TypingUserModel].
extension TypingUserModelPatterns on TypingUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TypingUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TypingUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TypingUserModel value)  $default,){
final _that = this;
switch (_that) {
case _TypingUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TypingUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _TypingUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'userId', fromJson: _userIdFromJson)  String id,  String username,  String fullName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TypingUserModel() when $default != null:
return $default(_that.id,_that.username,_that.fullName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'userId', fromJson: _userIdFromJson)  String id,  String username,  String fullName)  $default,) {final _that = this;
switch (_that) {
case _TypingUserModel():
return $default(_that.id,_that.username,_that.fullName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'userId', fromJson: _userIdFromJson)  String id,  String username,  String fullName)?  $default,) {final _that = this;
switch (_that) {
case _TypingUserModel() when $default != null:
return $default(_that.id,_that.username,_that.fullName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TypingUserModel extends TypingUserModel {
  const _TypingUserModel({@JsonKey(name: 'userId', fromJson: _userIdFromJson) required this.id, required this.username, required this.fullName}): super._();
  factory _TypingUserModel.fromJson(Map<String, dynamic> json) => _$TypingUserModelFromJson(json);

@override@JsonKey(name: 'userId', fromJson: _userIdFromJson) final  String id;
@override final  String username;
@override final  String fullName;

/// Create a copy of TypingUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TypingUserModelCopyWith<_TypingUserModel> get copyWith => __$TypingUserModelCopyWithImpl<_TypingUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TypingUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypingUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,fullName);

@override
String toString() {
  return 'TypingUserModel(id: $id, username: $username, fullName: $fullName)';
}


}

/// @nodoc
abstract mixin class _$TypingUserModelCopyWith<$Res> implements $TypingUserModelCopyWith<$Res> {
  factory _$TypingUserModelCopyWith(_TypingUserModel value, $Res Function(_TypingUserModel) _then) = __$TypingUserModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'userId', fromJson: _userIdFromJson) String id, String username, String fullName
});




}
/// @nodoc
class __$TypingUserModelCopyWithImpl<$Res>
    implements _$TypingUserModelCopyWith<$Res> {
  __$TypingUserModelCopyWithImpl(this._self, this._then);

  final _TypingUserModel _self;
  final $Res Function(_TypingUserModel) _then;

/// Create a copy of TypingUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? fullName = null,}) {
  return _then(_TypingUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
