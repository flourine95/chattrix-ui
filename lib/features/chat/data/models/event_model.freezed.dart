// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventModel {

 int get id; int get conversationId; UserDto get creator; String get title; String? get description; DateTime get startTime; DateTime get endTime; String? get location; DateTime get createdAt; DateTime get updatedAt; int get goingCount; int get maybeCount; int get notGoingCount; String? get currentUserRsvpStatus; List<EventRsvpModel> get rsvps;
/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventModelCopyWith<EventModel> get copyWith => _$EventModelCopyWithImpl<EventModel>(this as EventModel, _$identity);

  /// Serializes this EventModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.goingCount, goingCount) || other.goingCount == goingCount)&&(identical(other.maybeCount, maybeCount) || other.maybeCount == maybeCount)&&(identical(other.notGoingCount, notGoingCount) || other.notGoingCount == notGoingCount)&&(identical(other.currentUserRsvpStatus, currentUserRsvpStatus) || other.currentUserRsvpStatus == currentUserRsvpStatus)&&const DeepCollectionEquality().equals(other.rsvps, rsvps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,creator,title,description,startTime,endTime,location,createdAt,updatedAt,goingCount,maybeCount,notGoingCount,currentUserRsvpStatus,const DeepCollectionEquality().hash(rsvps));

@override
String toString() {
  return 'EventModel(id: $id, conversationId: $conversationId, creator: $creator, title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, goingCount: $goingCount, maybeCount: $maybeCount, notGoingCount: $notGoingCount, currentUserRsvpStatus: $currentUserRsvpStatus, rsvps: $rsvps)';
}


}

/// @nodoc
abstract mixin class $EventModelCopyWith<$Res>  {
  factory $EventModelCopyWith(EventModel value, $Res Function(EventModel) _then) = _$EventModelCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, UserDto creator, String title, String? description, DateTime startTime, DateTime endTime, String? location, DateTime createdAt, DateTime updatedAt, int goingCount, int maybeCount, int notGoingCount, String? currentUserRsvpStatus, List<EventRsvpModel> rsvps
});


$UserDtoCopyWith<$Res> get creator;

}
/// @nodoc
class _$EventModelCopyWithImpl<$Res>
    implements $EventModelCopyWith<$Res> {
  _$EventModelCopyWithImpl(this._self, this._then);

  final EventModel _self;
  final $Res Function(EventModel) _then;

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? creator = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,Object? createdAt = null,Object? updatedAt = null,Object? goingCount = null,Object? maybeCount = null,Object? notGoingCount = null,Object? currentUserRsvpStatus = freezed,Object? rsvps = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserDto,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,goingCount: null == goingCount ? _self.goingCount : goingCount // ignore: cast_nullable_to_non_nullable
as int,maybeCount: null == maybeCount ? _self.maybeCount : maybeCount // ignore: cast_nullable_to_non_nullable
as int,notGoingCount: null == notGoingCount ? _self.notGoingCount : notGoingCount // ignore: cast_nullable_to_non_nullable
as int,currentUserRsvpStatus: freezed == currentUserRsvpStatus ? _self.currentUserRsvpStatus : currentUserRsvpStatus // ignore: cast_nullable_to_non_nullable
as String?,rsvps: null == rsvps ? _self.rsvps : rsvps // ignore: cast_nullable_to_non_nullable
as List<EventRsvpModel>,
  ));
}
/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get creator {
  
  return $UserDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventModel].
extension EventModelPatterns on EventModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventModel value)  $default,){
final _that = this;
switch (_that) {
case _EventModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventModel value)?  $default,){
final _that = this;
switch (_that) {
case _EventModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  UserDto creator,  String title,  String? description,  DateTime startTime,  DateTime endTime,  String? location,  DateTime createdAt,  DateTime updatedAt,  int goingCount,  int maybeCount,  int notGoingCount,  String? currentUserRsvpStatus,  List<EventRsvpModel> rsvps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.creator,_that.title,_that.description,_that.startTime,_that.endTime,_that.location,_that.createdAt,_that.updatedAt,_that.goingCount,_that.maybeCount,_that.notGoingCount,_that.currentUserRsvpStatus,_that.rsvps);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  UserDto creator,  String title,  String? description,  DateTime startTime,  DateTime endTime,  String? location,  DateTime createdAt,  DateTime updatedAt,  int goingCount,  int maybeCount,  int notGoingCount,  String? currentUserRsvpStatus,  List<EventRsvpModel> rsvps)  $default,) {final _that = this;
switch (_that) {
case _EventModel():
return $default(_that.id,_that.conversationId,_that.creator,_that.title,_that.description,_that.startTime,_that.endTime,_that.location,_that.createdAt,_that.updatedAt,_that.goingCount,_that.maybeCount,_that.notGoingCount,_that.currentUserRsvpStatus,_that.rsvps);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  UserDto creator,  String title,  String? description,  DateTime startTime,  DateTime endTime,  String? location,  DateTime createdAt,  DateTime updatedAt,  int goingCount,  int maybeCount,  int notGoingCount,  String? currentUserRsvpStatus,  List<EventRsvpModel> rsvps)?  $default,) {final _that = this;
switch (_that) {
case _EventModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.creator,_that.title,_that.description,_that.startTime,_that.endTime,_that.location,_that.createdAt,_that.updatedAt,_that.goingCount,_that.maybeCount,_that.notGoingCount,_that.currentUserRsvpStatus,_that.rsvps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventModel implements EventModel {
  const _EventModel({required this.id, required this.conversationId, required this.creator, required this.title, this.description, required this.startTime, required this.endTime, this.location, required this.createdAt, required this.updatedAt, this.goingCount = 0, this.maybeCount = 0, this.notGoingCount = 0, this.currentUserRsvpStatus, final  List<EventRsvpModel> rsvps = const []}): _rsvps = rsvps;
  factory _EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

@override final  int id;
@override final  int conversationId;
@override final  UserDto creator;
@override final  String title;
@override final  String? description;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  String? location;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  int goingCount;
@override@JsonKey() final  int maybeCount;
@override@JsonKey() final  int notGoingCount;
@override final  String? currentUserRsvpStatus;
 final  List<EventRsvpModel> _rsvps;
@override@JsonKey() List<EventRsvpModel> get rsvps {
  if (_rsvps is EqualUnmodifiableListView) return _rsvps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rsvps);
}


/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventModelCopyWith<_EventModel> get copyWith => __$EventModelCopyWithImpl<_EventModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.goingCount, goingCount) || other.goingCount == goingCount)&&(identical(other.maybeCount, maybeCount) || other.maybeCount == maybeCount)&&(identical(other.notGoingCount, notGoingCount) || other.notGoingCount == notGoingCount)&&(identical(other.currentUserRsvpStatus, currentUserRsvpStatus) || other.currentUserRsvpStatus == currentUserRsvpStatus)&&const DeepCollectionEquality().equals(other._rsvps, _rsvps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,creator,title,description,startTime,endTime,location,createdAt,updatedAt,goingCount,maybeCount,notGoingCount,currentUserRsvpStatus,const DeepCollectionEquality().hash(_rsvps));

@override
String toString() {
  return 'EventModel(id: $id, conversationId: $conversationId, creator: $creator, title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, goingCount: $goingCount, maybeCount: $maybeCount, notGoingCount: $notGoingCount, currentUserRsvpStatus: $currentUserRsvpStatus, rsvps: $rsvps)';
}


}

/// @nodoc
abstract mixin class _$EventModelCopyWith<$Res> implements $EventModelCopyWith<$Res> {
  factory _$EventModelCopyWith(_EventModel value, $Res Function(_EventModel) _then) = __$EventModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, UserDto creator, String title, String? description, DateTime startTime, DateTime endTime, String? location, DateTime createdAt, DateTime updatedAt, int goingCount, int maybeCount, int notGoingCount, String? currentUserRsvpStatus, List<EventRsvpModel> rsvps
});


@override $UserDtoCopyWith<$Res> get creator;

}
/// @nodoc
class __$EventModelCopyWithImpl<$Res>
    implements _$EventModelCopyWith<$Res> {
  __$EventModelCopyWithImpl(this._self, this._then);

  final _EventModel _self;
  final $Res Function(_EventModel) _then;

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? creator = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,Object? createdAt = null,Object? updatedAt = null,Object? goingCount = null,Object? maybeCount = null,Object? notGoingCount = null,Object? currentUserRsvpStatus = freezed,Object? rsvps = null,}) {
  return _then(_EventModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserDto,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,goingCount: null == goingCount ? _self.goingCount : goingCount // ignore: cast_nullable_to_non_nullable
as int,maybeCount: null == maybeCount ? _self.maybeCount : maybeCount // ignore: cast_nullable_to_non_nullable
as int,notGoingCount: null == notGoingCount ? _self.notGoingCount : notGoingCount // ignore: cast_nullable_to_non_nullable
as int,currentUserRsvpStatus: freezed == currentUserRsvpStatus ? _self.currentUserRsvpStatus : currentUserRsvpStatus // ignore: cast_nullable_to_non_nullable
as String?,rsvps: null == rsvps ? _self._rsvps : rsvps // ignore: cast_nullable_to_non_nullable
as List<EventRsvpModel>,
  ));
}

/// Create a copy of EventModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get creator {
  
  return $UserDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// @nodoc
mixin _$EventRsvpModel {

 int get id; UserDto get user; String get status; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of EventRsvpModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventRsvpModelCopyWith<EventRsvpModel> get copyWith => _$EventRsvpModelCopyWithImpl<EventRsvpModel>(this as EventRsvpModel, _$identity);

  /// Serializes this EventRsvpModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventRsvpModel&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user,status,createdAt,updatedAt);

@override
String toString() {
  return 'EventRsvpModel(id: $id, user: $user, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EventRsvpModelCopyWith<$Res>  {
  factory $EventRsvpModelCopyWith(EventRsvpModel value, $Res Function(EventRsvpModel) _then) = _$EventRsvpModelCopyWithImpl;
@useResult
$Res call({
 int id, UserDto user, String status, DateTime createdAt, DateTime updatedAt
});


$UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class _$EventRsvpModelCopyWithImpl<$Res>
    implements $EventRsvpModelCopyWith<$Res> {
  _$EventRsvpModelCopyWithImpl(this._self, this._then);

  final EventRsvpModel _self;
  final $Res Function(EventRsvpModel) _then;

/// Create a copy of EventRsvpModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of EventRsvpModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventRsvpModel].
extension EventRsvpModelPatterns on EventRsvpModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventRsvpModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventRsvpModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventRsvpModel value)  $default,){
final _that = this;
switch (_that) {
case _EventRsvpModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventRsvpModel value)?  $default,){
final _that = this;
switch (_that) {
case _EventRsvpModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  UserDto user,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventRsvpModel() when $default != null:
return $default(_that.id,_that.user,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  UserDto user,  String status,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _EventRsvpModel():
return $default(_that.id,_that.user,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  UserDto user,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _EventRsvpModel() when $default != null:
return $default(_that.id,_that.user,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventRsvpModel implements EventRsvpModel {
  const _EventRsvpModel({required this.id, required this.user, required this.status, required this.createdAt, required this.updatedAt});
  factory _EventRsvpModel.fromJson(Map<String, dynamic> json) => _$EventRsvpModelFromJson(json);

@override final  int id;
@override final  UserDto user;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of EventRsvpModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventRsvpModelCopyWith<_EventRsvpModel> get copyWith => __$EventRsvpModelCopyWithImpl<_EventRsvpModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventRsvpModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventRsvpModel&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user,status,createdAt,updatedAt);

@override
String toString() {
  return 'EventRsvpModel(id: $id, user: $user, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EventRsvpModelCopyWith<$Res> implements $EventRsvpModelCopyWith<$Res> {
  factory _$EventRsvpModelCopyWith(_EventRsvpModel value, $Res Function(_EventRsvpModel) _then) = __$EventRsvpModelCopyWithImpl;
@override @useResult
$Res call({
 int id, UserDto user, String status, DateTime createdAt, DateTime updatedAt
});


@override $UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class __$EventRsvpModelCopyWithImpl<$Res>
    implements _$EventRsvpModelCopyWith<$Res> {
  __$EventRsvpModelCopyWithImpl(this._self, this._then);

  final _EventRsvpModel _self;
  final $Res Function(_EventRsvpModel) _then;

/// Create a copy of EventRsvpModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_EventRsvpModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of EventRsvpModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$CreateEventRequest {

 String get title; String? get description; DateTime get startTime; DateTime get endTime; String? get location;
/// Create a copy of CreateEventRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateEventRequestCopyWith<CreateEventRequest> get copyWith => _$CreateEventRequestCopyWithImpl<CreateEventRequest>(this as CreateEventRequest, _$identity);

  /// Serializes this CreateEventRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateEventRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,startTime,endTime,location);

@override
String toString() {
  return 'CreateEventRequest(title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location)';
}


}

/// @nodoc
abstract mixin class $CreateEventRequestCopyWith<$Res>  {
  factory $CreateEventRequestCopyWith(CreateEventRequest value, $Res Function(CreateEventRequest) _then) = _$CreateEventRequestCopyWithImpl;
@useResult
$Res call({
 String title, String? description, DateTime startTime, DateTime endTime, String? location
});




}
/// @nodoc
class _$CreateEventRequestCopyWithImpl<$Res>
    implements $CreateEventRequestCopyWith<$Res> {
  _$CreateEventRequestCopyWithImpl(this._self, this._then);

  final CreateEventRequest _self;
  final $Res Function(CreateEventRequest) _then;

/// Create a copy of CreateEventRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateEventRequest].
extension CreateEventRequestPatterns on CreateEventRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateEventRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateEventRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateEventRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateEventRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateEventRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateEventRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? description,  DateTime startTime,  DateTime endTime,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateEventRequest() when $default != null:
return $default(_that.title,_that.description,_that.startTime,_that.endTime,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? description,  DateTime startTime,  DateTime endTime,  String? location)  $default,) {final _that = this;
switch (_that) {
case _CreateEventRequest():
return $default(_that.title,_that.description,_that.startTime,_that.endTime,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? description,  DateTime startTime,  DateTime endTime,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _CreateEventRequest() when $default != null:
return $default(_that.title,_that.description,_that.startTime,_that.endTime,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateEventRequest implements CreateEventRequest {
  const _CreateEventRequest({required this.title, this.description, required this.startTime, required this.endTime, this.location});
  factory _CreateEventRequest.fromJson(Map<String, dynamic> json) => _$CreateEventRequestFromJson(json);

@override final  String title;
@override final  String? description;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  String? location;

/// Create a copy of CreateEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateEventRequestCopyWith<_CreateEventRequest> get copyWith => __$CreateEventRequestCopyWithImpl<_CreateEventRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateEventRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateEventRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,startTime,endTime,location);

@override
String toString() {
  return 'CreateEventRequest(title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location)';
}


}

/// @nodoc
abstract mixin class _$CreateEventRequestCopyWith<$Res> implements $CreateEventRequestCopyWith<$Res> {
  factory _$CreateEventRequestCopyWith(_CreateEventRequest value, $Res Function(_CreateEventRequest) _then) = __$CreateEventRequestCopyWithImpl;
@override @useResult
$Res call({
 String title, String? description, DateTime startTime, DateTime endTime, String? location
});




}
/// @nodoc
class __$CreateEventRequestCopyWithImpl<$Res>
    implements _$CreateEventRequestCopyWith<$Res> {
  __$CreateEventRequestCopyWithImpl(this._self, this._then);

  final _CreateEventRequest _self;
  final $Res Function(_CreateEventRequest) _then;

/// Create a copy of CreateEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,}) {
  return _then(_CreateEventRequest(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpdateEventRequest {

 String? get title; String? get description; DateTime? get startTime; DateTime? get endTime; String? get location;
/// Create a copy of UpdateEventRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateEventRequestCopyWith<UpdateEventRequest> get copyWith => _$UpdateEventRequestCopyWithImpl<UpdateEventRequest>(this as UpdateEventRequest, _$identity);

  /// Serializes this UpdateEventRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateEventRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,startTime,endTime,location);

@override
String toString() {
  return 'UpdateEventRequest(title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location)';
}


}

/// @nodoc
abstract mixin class $UpdateEventRequestCopyWith<$Res>  {
  factory $UpdateEventRequestCopyWith(UpdateEventRequest value, $Res Function(UpdateEventRequest) _then) = _$UpdateEventRequestCopyWithImpl;
@useResult
$Res call({
 String? title, String? description, DateTime? startTime, DateTime? endTime, String? location
});




}
/// @nodoc
class _$UpdateEventRequestCopyWithImpl<$Res>
    implements $UpdateEventRequestCopyWith<$Res> {
  _$UpdateEventRequestCopyWithImpl(this._self, this._then);

  final UpdateEventRequest _self;
  final $Res Function(UpdateEventRequest) _then;

/// Create a copy of UpdateEventRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? location = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateEventRequest].
extension UpdateEventRequestPatterns on UpdateEventRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateEventRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateEventRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateEventRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateEventRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateEventRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateEventRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? description,  DateTime? startTime,  DateTime? endTime,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateEventRequest() when $default != null:
return $default(_that.title,_that.description,_that.startTime,_that.endTime,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? description,  DateTime? startTime,  DateTime? endTime,  String? location)  $default,) {final _that = this;
switch (_that) {
case _UpdateEventRequest():
return $default(_that.title,_that.description,_that.startTime,_that.endTime,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? description,  DateTime? startTime,  DateTime? endTime,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _UpdateEventRequest() when $default != null:
return $default(_that.title,_that.description,_that.startTime,_that.endTime,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateEventRequest implements UpdateEventRequest {
  const _UpdateEventRequest({this.title, this.description, this.startTime, this.endTime, this.location});
  factory _UpdateEventRequest.fromJson(Map<String, dynamic> json) => _$UpdateEventRequestFromJson(json);

@override final  String? title;
@override final  String? description;
@override final  DateTime? startTime;
@override final  DateTime? endTime;
@override final  String? location;

/// Create a copy of UpdateEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateEventRequestCopyWith<_UpdateEventRequest> get copyWith => __$UpdateEventRequestCopyWithImpl<_UpdateEventRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateEventRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateEventRequest&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,startTime,endTime,location);

@override
String toString() {
  return 'UpdateEventRequest(title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location)';
}


}

/// @nodoc
abstract mixin class _$UpdateEventRequestCopyWith<$Res> implements $UpdateEventRequestCopyWith<$Res> {
  factory _$UpdateEventRequestCopyWith(_UpdateEventRequest value, $Res Function(_UpdateEventRequest) _then) = __$UpdateEventRequestCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? description, DateTime? startTime, DateTime? endTime, String? location
});




}
/// @nodoc
class __$UpdateEventRequestCopyWithImpl<$Res>
    implements _$UpdateEventRequestCopyWith<$Res> {
  __$UpdateEventRequestCopyWithImpl(this._self, this._then);

  final _UpdateEventRequest _self;
  final $Res Function(_UpdateEventRequest) _then;

/// Create a copy of UpdateEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? description = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? location = freezed,}) {
  return _then(_UpdateEventRequest(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RsvpEventRequest {

 String get status;
/// Create a copy of RsvpEventRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RsvpEventRequestCopyWith<RsvpEventRequest> get copyWith => _$RsvpEventRequestCopyWithImpl<RsvpEventRequest>(this as RsvpEventRequest, _$identity);

  /// Serializes this RsvpEventRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RsvpEventRequest&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'RsvpEventRequest(status: $status)';
}


}

/// @nodoc
abstract mixin class $RsvpEventRequestCopyWith<$Res>  {
  factory $RsvpEventRequestCopyWith(RsvpEventRequest value, $Res Function(RsvpEventRequest) _then) = _$RsvpEventRequestCopyWithImpl;
@useResult
$Res call({
 String status
});




}
/// @nodoc
class _$RsvpEventRequestCopyWithImpl<$Res>
    implements $RsvpEventRequestCopyWith<$Res> {
  _$RsvpEventRequestCopyWithImpl(this._self, this._then);

  final RsvpEventRequest _self;
  final $Res Function(RsvpEventRequest) _then;

/// Create a copy of RsvpEventRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RsvpEventRequest].
extension RsvpEventRequestPatterns on RsvpEventRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RsvpEventRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RsvpEventRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RsvpEventRequest value)  $default,){
final _that = this;
switch (_that) {
case _RsvpEventRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RsvpEventRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RsvpEventRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RsvpEventRequest() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status)  $default,) {final _that = this;
switch (_that) {
case _RsvpEventRequest():
return $default(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status)?  $default,) {final _that = this;
switch (_that) {
case _RsvpEventRequest() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RsvpEventRequest implements RsvpEventRequest {
  const _RsvpEventRequest({required this.status});
  factory _RsvpEventRequest.fromJson(Map<String, dynamic> json) => _$RsvpEventRequestFromJson(json);

@override final  String status;

/// Create a copy of RsvpEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RsvpEventRequestCopyWith<_RsvpEventRequest> get copyWith => __$RsvpEventRequestCopyWithImpl<_RsvpEventRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RsvpEventRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RsvpEventRequest&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'RsvpEventRequest(status: $status)';
}


}

/// @nodoc
abstract mixin class _$RsvpEventRequestCopyWith<$Res> implements $RsvpEventRequestCopyWith<$Res> {
  factory _$RsvpEventRequestCopyWith(_RsvpEventRequest value, $Res Function(_RsvpEventRequest) _then) = __$RsvpEventRequestCopyWithImpl;
@override @useResult
$Res call({
 String status
});




}
/// @nodoc
class __$RsvpEventRequestCopyWithImpl<$Res>
    implements _$RsvpEventRequestCopyWith<$Res> {
  __$RsvpEventRequestCopyWithImpl(this._self, this._then);

  final _RsvpEventRequest _self;
  final $Res Function(_RsvpEventRequest) _then;

/// Create a copy of RsvpEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_RsvpEventRequest(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
