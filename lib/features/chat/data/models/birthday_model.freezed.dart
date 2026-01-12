// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'birthday_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BirthdayModel {

 int get userId; String get username; String get fullName; String? get avatarUrl; DateTime get dateOfBirth; int get age; String get birthdayMessage;
/// Create a copy of BirthdayModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BirthdayModelCopyWith<BirthdayModel> get copyWith => _$BirthdayModelCopyWithImpl<BirthdayModel>(this as BirthdayModel, _$identity);

  /// Serializes this BirthdayModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BirthdayModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.age, age) || other.age == age)&&(identical(other.birthdayMessage, birthdayMessage) || other.birthdayMessage == birthdayMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,avatarUrl,dateOfBirth,age,birthdayMessage);

@override
String toString() {
  return 'BirthdayModel(userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, dateOfBirth: $dateOfBirth, age: $age, birthdayMessage: $birthdayMessage)';
}


}

/// @nodoc
abstract mixin class $BirthdayModelCopyWith<$Res>  {
  factory $BirthdayModelCopyWith(BirthdayModel value, $Res Function(BirthdayModel) _then) = _$BirthdayModelCopyWithImpl;
@useResult
$Res call({
 int userId, String username, String fullName, String? avatarUrl, DateTime dateOfBirth, int age, String birthdayMessage
});




}
/// @nodoc
class _$BirthdayModelCopyWithImpl<$Res>
    implements $BirthdayModelCopyWith<$Res> {
  _$BirthdayModelCopyWithImpl(this._self, this._then);

  final BirthdayModel _self;
  final $Res Function(BirthdayModel) _then;

/// Create a copy of BirthdayModel
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


/// Adds pattern-matching-related methods to [BirthdayModel].
extension BirthdayModelPatterns on BirthdayModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BirthdayModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BirthdayModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BirthdayModel value)  $default,){
final _that = this;
switch (_that) {
case _BirthdayModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BirthdayModel value)?  $default,){
final _that = this;
switch (_that) {
case _BirthdayModel() when $default != null:
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
case _BirthdayModel() when $default != null:
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
case _BirthdayModel():
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
case _BirthdayModel() when $default != null:
return $default(_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.dateOfBirth,_that.age,_that.birthdayMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BirthdayModel implements BirthdayModel {
  const _BirthdayModel({required this.userId, required this.username, required this.fullName, this.avatarUrl, required this.dateOfBirth, required this.age, required this.birthdayMessage});
  factory _BirthdayModel.fromJson(Map<String, dynamic> json) => _$BirthdayModelFromJson(json);

@override final  int userId;
@override final  String username;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  DateTime dateOfBirth;
@override final  int age;
@override final  String birthdayMessage;

/// Create a copy of BirthdayModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BirthdayModelCopyWith<_BirthdayModel> get copyWith => __$BirthdayModelCopyWithImpl<_BirthdayModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BirthdayModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BirthdayModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.age, age) || other.age == age)&&(identical(other.birthdayMessage, birthdayMessage) || other.birthdayMessage == birthdayMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,avatarUrl,dateOfBirth,age,birthdayMessage);

@override
String toString() {
  return 'BirthdayModel(userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, dateOfBirth: $dateOfBirth, age: $age, birthdayMessage: $birthdayMessage)';
}


}

/// @nodoc
abstract mixin class _$BirthdayModelCopyWith<$Res> implements $BirthdayModelCopyWith<$Res> {
  factory _$BirthdayModelCopyWith(_BirthdayModel value, $Res Function(_BirthdayModel) _then) = __$BirthdayModelCopyWithImpl;
@override @useResult
$Res call({
 int userId, String username, String fullName, String? avatarUrl, DateTime dateOfBirth, int age, String birthdayMessage
});




}
/// @nodoc
class __$BirthdayModelCopyWithImpl<$Res>
    implements _$BirthdayModelCopyWith<$Res> {
  __$BirthdayModelCopyWithImpl(this._self, this._then);

  final _BirthdayModel _self;
  final $Res Function(_BirthdayModel) _then;

/// Create a copy of BirthdayModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? dateOfBirth = null,Object? age = null,Object? birthdayMessage = null,}) {
  return _then(_BirthdayModel(
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
mixin _$SendBirthdayWishesRequest {

 int get userId; List<int> get conversationIds; String? get customMessage;
/// Create a copy of SendBirthdayWishesRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendBirthdayWishesRequestCopyWith<SendBirthdayWishesRequest> get copyWith => _$SendBirthdayWishesRequestCopyWithImpl<SendBirthdayWishesRequest>(this as SendBirthdayWishesRequest, _$identity);

  /// Serializes this SendBirthdayWishesRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendBirthdayWishesRequest&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.conversationIds, conversationIds)&&(identical(other.customMessage, customMessage) || other.customMessage == customMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(conversationIds),customMessage);

@override
String toString() {
  return 'SendBirthdayWishesRequest(userId: $userId, conversationIds: $conversationIds, customMessage: $customMessage)';
}


}

/// @nodoc
abstract mixin class $SendBirthdayWishesRequestCopyWith<$Res>  {
  factory $SendBirthdayWishesRequestCopyWith(SendBirthdayWishesRequest value, $Res Function(SendBirthdayWishesRequest) _then) = _$SendBirthdayWishesRequestCopyWithImpl;
@useResult
$Res call({
 int userId, List<int> conversationIds, String? customMessage
});




}
/// @nodoc
class _$SendBirthdayWishesRequestCopyWithImpl<$Res>
    implements $SendBirthdayWishesRequestCopyWith<$Res> {
  _$SendBirthdayWishesRequestCopyWithImpl(this._self, this._then);

  final SendBirthdayWishesRequest _self;
  final $Res Function(SendBirthdayWishesRequest) _then;

/// Create a copy of SendBirthdayWishesRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? conversationIds = null,Object? customMessage = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,conversationIds: null == conversationIds ? _self.conversationIds : conversationIds // ignore: cast_nullable_to_non_nullable
as List<int>,customMessage: freezed == customMessage ? _self.customMessage : customMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SendBirthdayWishesRequest].
extension SendBirthdayWishesRequestPatterns on SendBirthdayWishesRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendBirthdayWishesRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendBirthdayWishesRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendBirthdayWishesRequest value)  $default,){
final _that = this;
switch (_that) {
case _SendBirthdayWishesRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendBirthdayWishesRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SendBirthdayWishesRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  List<int> conversationIds,  String? customMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendBirthdayWishesRequest() when $default != null:
return $default(_that.userId,_that.conversationIds,_that.customMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  List<int> conversationIds,  String? customMessage)  $default,) {final _that = this;
switch (_that) {
case _SendBirthdayWishesRequest():
return $default(_that.userId,_that.conversationIds,_that.customMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  List<int> conversationIds,  String? customMessage)?  $default,) {final _that = this;
switch (_that) {
case _SendBirthdayWishesRequest() when $default != null:
return $default(_that.userId,_that.conversationIds,_that.customMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendBirthdayWishesRequest implements SendBirthdayWishesRequest {
  const _SendBirthdayWishesRequest({required this.userId, required final  List<int> conversationIds, this.customMessage}): _conversationIds = conversationIds;
  factory _SendBirthdayWishesRequest.fromJson(Map<String, dynamic> json) => _$SendBirthdayWishesRequestFromJson(json);

@override final  int userId;
 final  List<int> _conversationIds;
@override List<int> get conversationIds {
  if (_conversationIds is EqualUnmodifiableListView) return _conversationIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversationIds);
}

@override final  String? customMessage;

/// Create a copy of SendBirthdayWishesRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendBirthdayWishesRequestCopyWith<_SendBirthdayWishesRequest> get copyWith => __$SendBirthdayWishesRequestCopyWithImpl<_SendBirthdayWishesRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendBirthdayWishesRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendBirthdayWishesRequest&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._conversationIds, _conversationIds)&&(identical(other.customMessage, customMessage) || other.customMessage == customMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(_conversationIds),customMessage);

@override
String toString() {
  return 'SendBirthdayWishesRequest(userId: $userId, conversationIds: $conversationIds, customMessage: $customMessage)';
}


}

/// @nodoc
abstract mixin class _$SendBirthdayWishesRequestCopyWith<$Res> implements $SendBirthdayWishesRequestCopyWith<$Res> {
  factory _$SendBirthdayWishesRequestCopyWith(_SendBirthdayWishesRequest value, $Res Function(_SendBirthdayWishesRequest) _then) = __$SendBirthdayWishesRequestCopyWithImpl;
@override @useResult
$Res call({
 int userId, List<int> conversationIds, String? customMessage
});




}
/// @nodoc
class __$SendBirthdayWishesRequestCopyWithImpl<$Res>
    implements _$SendBirthdayWishesRequestCopyWith<$Res> {
  __$SendBirthdayWishesRequestCopyWithImpl(this._self, this._then);

  final _SendBirthdayWishesRequest _self;
  final $Res Function(_SendBirthdayWishesRequest) _then;

/// Create a copy of SendBirthdayWishesRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? conversationIds = null,Object? customMessage = freezed,}) {
  return _then(_SendBirthdayWishesRequest(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,conversationIds: null == conversationIds ? _self._conversationIds : conversationIds // ignore: cast_nullable_to_non_nullable
as List<int>,customMessage: freezed == customMessage ? _self.customMessage : customMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SendBirthdayWishesResponse {

 int get conversationCount; int get userId;
/// Create a copy of SendBirthdayWishesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendBirthdayWishesResponseCopyWith<SendBirthdayWishesResponse> get copyWith => _$SendBirthdayWishesResponseCopyWithImpl<SendBirthdayWishesResponse>(this as SendBirthdayWishesResponse, _$identity);

  /// Serializes this SendBirthdayWishesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendBirthdayWishesResponse&&(identical(other.conversationCount, conversationCount) || other.conversationCount == conversationCount)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationCount,userId);

@override
String toString() {
  return 'SendBirthdayWishesResponse(conversationCount: $conversationCount, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $SendBirthdayWishesResponseCopyWith<$Res>  {
  factory $SendBirthdayWishesResponseCopyWith(SendBirthdayWishesResponse value, $Res Function(SendBirthdayWishesResponse) _then) = _$SendBirthdayWishesResponseCopyWithImpl;
@useResult
$Res call({
 int conversationCount, int userId
});




}
/// @nodoc
class _$SendBirthdayWishesResponseCopyWithImpl<$Res>
    implements $SendBirthdayWishesResponseCopyWith<$Res> {
  _$SendBirthdayWishesResponseCopyWithImpl(this._self, this._then);

  final SendBirthdayWishesResponse _self;
  final $Res Function(SendBirthdayWishesResponse) _then;

/// Create a copy of SendBirthdayWishesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationCount = null,Object? userId = null,}) {
  return _then(_self.copyWith(
conversationCount: null == conversationCount ? _self.conversationCount : conversationCount // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SendBirthdayWishesResponse].
extension SendBirthdayWishesResponsePatterns on SendBirthdayWishesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendBirthdayWishesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendBirthdayWishesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendBirthdayWishesResponse value)  $default,){
final _that = this;
switch (_that) {
case _SendBirthdayWishesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendBirthdayWishesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SendBirthdayWishesResponse() when $default != null:
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
case _SendBirthdayWishesResponse() when $default != null:
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
case _SendBirthdayWishesResponse():
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
case _SendBirthdayWishesResponse() when $default != null:
return $default(_that.conversationCount,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendBirthdayWishesResponse implements SendBirthdayWishesResponse {
  const _SendBirthdayWishesResponse({required this.conversationCount, required this.userId});
  factory _SendBirthdayWishesResponse.fromJson(Map<String, dynamic> json) => _$SendBirthdayWishesResponseFromJson(json);

@override final  int conversationCount;
@override final  int userId;

/// Create a copy of SendBirthdayWishesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendBirthdayWishesResponseCopyWith<_SendBirthdayWishesResponse> get copyWith => __$SendBirthdayWishesResponseCopyWithImpl<_SendBirthdayWishesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendBirthdayWishesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendBirthdayWishesResponse&&(identical(other.conversationCount, conversationCount) || other.conversationCount == conversationCount)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationCount,userId);

@override
String toString() {
  return 'SendBirthdayWishesResponse(conversationCount: $conversationCount, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$SendBirthdayWishesResponseCopyWith<$Res> implements $SendBirthdayWishesResponseCopyWith<$Res> {
  factory _$SendBirthdayWishesResponseCopyWith(_SendBirthdayWishesResponse value, $Res Function(_SendBirthdayWishesResponse) _then) = __$SendBirthdayWishesResponseCopyWithImpl;
@override @useResult
$Res call({
 int conversationCount, int userId
});




}
/// @nodoc
class __$SendBirthdayWishesResponseCopyWithImpl<$Res>
    implements _$SendBirthdayWishesResponseCopyWith<$Res> {
  __$SendBirthdayWishesResponseCopyWithImpl(this._self, this._then);

  final _SendBirthdayWishesResponse _self;
  final $Res Function(_SendBirthdayWishesResponse) _then;

/// Create a copy of SendBirthdayWishesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationCount = null,Object? userId = null,}) {
  return _then(_SendBirthdayWishesResponse(
conversationCount: null == conversationCount ? _self.conversationCount : conversationCount // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
