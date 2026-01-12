// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventDto {

 int get id; int get conversationId; UserDto get creator; String get title; String? get description; String get startTime; String get endTime; String? get location; String get createdAt; String get updatedAt; int get goingCount; int get maybeCount; int get notGoingCount; String? get currentUserRsvpStatus; List<EventRsvpDto> get rsvps;
/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDtoCopyWith<EventDto> get copyWith => _$EventDtoCopyWithImpl<EventDto>(this as EventDto, _$identity);

  /// Serializes this EventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.goingCount, goingCount) || other.goingCount == goingCount)&&(identical(other.maybeCount, maybeCount) || other.maybeCount == maybeCount)&&(identical(other.notGoingCount, notGoingCount) || other.notGoingCount == notGoingCount)&&(identical(other.currentUserRsvpStatus, currentUserRsvpStatus) || other.currentUserRsvpStatus == currentUserRsvpStatus)&&const DeepCollectionEquality().equals(other.rsvps, rsvps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,creator,title,description,startTime,endTime,location,createdAt,updatedAt,goingCount,maybeCount,notGoingCount,currentUserRsvpStatus,const DeepCollectionEquality().hash(rsvps));

@override
String toString() {
  return 'EventDto(id: $id, conversationId: $conversationId, creator: $creator, title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, goingCount: $goingCount, maybeCount: $maybeCount, notGoingCount: $notGoingCount, currentUserRsvpStatus: $currentUserRsvpStatus, rsvps: $rsvps)';
}


}

/// @nodoc
abstract mixin class $EventDtoCopyWith<$Res>  {
  factory $EventDtoCopyWith(EventDto value, $Res Function(EventDto) _then) = _$EventDtoCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, UserDto creator, String title, String? description, String startTime, String endTime, String? location, String createdAt, String updatedAt, int goingCount, int maybeCount, int notGoingCount, String? currentUserRsvpStatus, List<EventRsvpDto> rsvps
});


$UserDtoCopyWith<$Res> get creator;

}
/// @nodoc
class _$EventDtoCopyWithImpl<$Res>
    implements $EventDtoCopyWith<$Res> {
  _$EventDtoCopyWithImpl(this._self, this._then);

  final EventDto _self;
  final $Res Function(EventDto) _then;

/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? creator = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,Object? createdAt = null,Object? updatedAt = null,Object? goingCount = null,Object? maybeCount = null,Object? notGoingCount = null,Object? currentUserRsvpStatus = freezed,Object? rsvps = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserDto,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,goingCount: null == goingCount ? _self.goingCount : goingCount // ignore: cast_nullable_to_non_nullable
as int,maybeCount: null == maybeCount ? _self.maybeCount : maybeCount // ignore: cast_nullable_to_non_nullable
as int,notGoingCount: null == notGoingCount ? _self.notGoingCount : notGoingCount // ignore: cast_nullable_to_non_nullable
as int,currentUserRsvpStatus: freezed == currentUserRsvpStatus ? _self.currentUserRsvpStatus : currentUserRsvpStatus // ignore: cast_nullable_to_non_nullable
as String?,rsvps: null == rsvps ? _self.rsvps : rsvps // ignore: cast_nullable_to_non_nullable
as List<EventRsvpDto>,
  ));
}
/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get creator {
  
  return $UserDtoCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventDto].
extension EventDtoPatterns on EventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDto value)  $default,){
final _that = this;
switch (_that) {
case _EventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  UserDto creator,  String title,  String? description,  String startTime,  String endTime,  String? location,  String createdAt,  String updatedAt,  int goingCount,  int maybeCount,  int notGoingCount,  String? currentUserRsvpStatus,  List<EventRsvpDto> rsvps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  UserDto creator,  String title,  String? description,  String startTime,  String endTime,  String? location,  String createdAt,  String updatedAt,  int goingCount,  int maybeCount,  int notGoingCount,  String? currentUserRsvpStatus,  List<EventRsvpDto> rsvps)  $default,) {final _that = this;
switch (_that) {
case _EventDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  UserDto creator,  String title,  String? description,  String startTime,  String endTime,  String? location,  String createdAt,  String updatedAt,  int goingCount,  int maybeCount,  int notGoingCount,  String? currentUserRsvpStatus,  List<EventRsvpDto> rsvps)?  $default,) {final _that = this;
switch (_that) {
case _EventDto() when $default != null:
return $default(_that.id,_that.conversationId,_that.creator,_that.title,_that.description,_that.startTime,_that.endTime,_that.location,_that.createdAt,_that.updatedAt,_that.goingCount,_that.maybeCount,_that.notGoingCount,_that.currentUserRsvpStatus,_that.rsvps);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDto implements EventDto {
  const _EventDto({required this.id, required this.conversationId, required this.creator, required this.title, this.description, required this.startTime, required this.endTime, this.location, required this.createdAt, required this.updatedAt, required this.goingCount, required this.maybeCount, required this.notGoingCount, this.currentUserRsvpStatus, required final  List<EventRsvpDto> rsvps}): _rsvps = rsvps;
  factory _EventDto.fromJson(Map<String, dynamic> json) => _$EventDtoFromJson(json);

@override final  int id;
@override final  int conversationId;
@override final  UserDto creator;
@override final  String title;
@override final  String? description;
@override final  String startTime;
@override final  String endTime;
@override final  String? location;
@override final  String createdAt;
@override final  String updatedAt;
@override final  int goingCount;
@override final  int maybeCount;
@override final  int notGoingCount;
@override final  String? currentUserRsvpStatus;
 final  List<EventRsvpDto> _rsvps;
@override List<EventRsvpDto> get rsvps {
  if (_rsvps is EqualUnmodifiableListView) return _rsvps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rsvps);
}


/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDtoCopyWith<_EventDto> get copyWith => __$EventDtoCopyWithImpl<_EventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.goingCount, goingCount) || other.goingCount == goingCount)&&(identical(other.maybeCount, maybeCount) || other.maybeCount == maybeCount)&&(identical(other.notGoingCount, notGoingCount) || other.notGoingCount == notGoingCount)&&(identical(other.currentUserRsvpStatus, currentUserRsvpStatus) || other.currentUserRsvpStatus == currentUserRsvpStatus)&&const DeepCollectionEquality().equals(other._rsvps, _rsvps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,creator,title,description,startTime,endTime,location,createdAt,updatedAt,goingCount,maybeCount,notGoingCount,currentUserRsvpStatus,const DeepCollectionEquality().hash(_rsvps));

@override
String toString() {
  return 'EventDto(id: $id, conversationId: $conversationId, creator: $creator, title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, goingCount: $goingCount, maybeCount: $maybeCount, notGoingCount: $notGoingCount, currentUserRsvpStatus: $currentUserRsvpStatus, rsvps: $rsvps)';
}


}

/// @nodoc
abstract mixin class _$EventDtoCopyWith<$Res> implements $EventDtoCopyWith<$Res> {
  factory _$EventDtoCopyWith(_EventDto value, $Res Function(_EventDto) _then) = __$EventDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, UserDto creator, String title, String? description, String startTime, String endTime, String? location, String createdAt, String updatedAt, int goingCount, int maybeCount, int notGoingCount, String? currentUserRsvpStatus, List<EventRsvpDto> rsvps
});


@override $UserDtoCopyWith<$Res> get creator;

}
/// @nodoc
class __$EventDtoCopyWithImpl<$Res>
    implements _$EventDtoCopyWith<$Res> {
  __$EventDtoCopyWithImpl(this._self, this._then);

  final _EventDto _self;
  final $Res Function(_EventDto) _then;

/// Create a copy of EventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? creator = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,Object? createdAt = null,Object? updatedAt = null,Object? goingCount = null,Object? maybeCount = null,Object? notGoingCount = null,Object? currentUserRsvpStatus = freezed,Object? rsvps = null,}) {
  return _then(_EventDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as UserDto,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,goingCount: null == goingCount ? _self.goingCount : goingCount // ignore: cast_nullable_to_non_nullable
as int,maybeCount: null == maybeCount ? _self.maybeCount : maybeCount // ignore: cast_nullable_to_non_nullable
as int,notGoingCount: null == notGoingCount ? _self.notGoingCount : notGoingCount // ignore: cast_nullable_to_non_nullable
as int,currentUserRsvpStatus: freezed == currentUserRsvpStatus ? _self.currentUserRsvpStatus : currentUserRsvpStatus // ignore: cast_nullable_to_non_nullable
as String?,rsvps: null == rsvps ? _self._rsvps : rsvps // ignore: cast_nullable_to_non_nullable
as List<EventRsvpDto>,
  ));
}

/// Create a copy of EventDto
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
mixin _$EventRsvpDto {

 int get id; UserDto get user; String get status; String get createdAt; String get updatedAt;
/// Create a copy of EventRsvpDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventRsvpDtoCopyWith<EventRsvpDto> get copyWith => _$EventRsvpDtoCopyWithImpl<EventRsvpDto>(this as EventRsvpDto, _$identity);

  /// Serializes this EventRsvpDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventRsvpDto&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user,status,createdAt,updatedAt);

@override
String toString() {
  return 'EventRsvpDto(id: $id, user: $user, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EventRsvpDtoCopyWith<$Res>  {
  factory $EventRsvpDtoCopyWith(EventRsvpDto value, $Res Function(EventRsvpDto) _then) = _$EventRsvpDtoCopyWithImpl;
@useResult
$Res call({
 int id, UserDto user, String status, String createdAt, String updatedAt
});


$UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class _$EventRsvpDtoCopyWithImpl<$Res>
    implements $EventRsvpDtoCopyWith<$Res> {
  _$EventRsvpDtoCopyWithImpl(this._self, this._then);

  final EventRsvpDto _self;
  final $Res Function(EventRsvpDto) _then;

/// Create a copy of EventRsvpDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of EventRsvpDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventRsvpDto].
extension EventRsvpDtoPatterns on EventRsvpDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventRsvpDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventRsvpDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventRsvpDto value)  $default,){
final _that = this;
switch (_that) {
case _EventRsvpDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventRsvpDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventRsvpDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  UserDto user,  String status,  String createdAt,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventRsvpDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  UserDto user,  String status,  String createdAt,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _EventRsvpDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  UserDto user,  String status,  String createdAt,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _EventRsvpDto() when $default != null:
return $default(_that.id,_that.user,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventRsvpDto implements EventRsvpDto {
  const _EventRsvpDto({required this.id, required this.user, required this.status, required this.createdAt, required this.updatedAt});
  factory _EventRsvpDto.fromJson(Map<String, dynamic> json) => _$EventRsvpDtoFromJson(json);

@override final  int id;
@override final  UserDto user;
@override final  String status;
@override final  String createdAt;
@override final  String updatedAt;

/// Create a copy of EventRsvpDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventRsvpDtoCopyWith<_EventRsvpDto> get copyWith => __$EventRsvpDtoCopyWithImpl<_EventRsvpDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventRsvpDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventRsvpDto&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,user,status,createdAt,updatedAt);

@override
String toString() {
  return 'EventRsvpDto(id: $id, user: $user, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EventRsvpDtoCopyWith<$Res> implements $EventRsvpDtoCopyWith<$Res> {
  factory _$EventRsvpDtoCopyWith(_EventRsvpDto value, $Res Function(_EventRsvpDto) _then) = __$EventRsvpDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, UserDto user, String status, String createdAt, String updatedAt
});


@override $UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class __$EventRsvpDtoCopyWithImpl<$Res>
    implements _$EventRsvpDtoCopyWith<$Res> {
  __$EventRsvpDtoCopyWithImpl(this._self, this._then);

  final _EventRsvpDto _self;
  final $Res Function(_EventRsvpDto) _then;

/// Create a copy of EventRsvpDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_EventRsvpDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of EventRsvpDto
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
mixin _$CreateEventRequestDto {

 String get title; String? get description; String get startTime; String get endTime; String? get location;
/// Create a copy of CreateEventRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateEventRequestDtoCopyWith<CreateEventRequestDto> get copyWith => _$CreateEventRequestDtoCopyWithImpl<CreateEventRequestDto>(this as CreateEventRequestDto, _$identity);

  /// Serializes this CreateEventRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateEventRequestDto&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,startTime,endTime,location);

@override
String toString() {
  return 'CreateEventRequestDto(title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location)';
}


}

/// @nodoc
abstract mixin class $CreateEventRequestDtoCopyWith<$Res>  {
  factory $CreateEventRequestDtoCopyWith(CreateEventRequestDto value, $Res Function(CreateEventRequestDto) _then) = _$CreateEventRequestDtoCopyWithImpl;
@useResult
$Res call({
 String title, String? description, String startTime, String endTime, String? location
});




}
/// @nodoc
class _$CreateEventRequestDtoCopyWithImpl<$Res>
    implements $CreateEventRequestDtoCopyWith<$Res> {
  _$CreateEventRequestDtoCopyWithImpl(this._self, this._then);

  final CreateEventRequestDto _self;
  final $Res Function(CreateEventRequestDto) _then;

/// Create a copy of CreateEventRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateEventRequestDto].
extension CreateEventRequestDtoPatterns on CreateEventRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateEventRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateEventRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateEventRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CreateEventRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateEventRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreateEventRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? description,  String startTime,  String endTime,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateEventRequestDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? description,  String startTime,  String endTime,  String? location)  $default,) {final _that = this;
switch (_that) {
case _CreateEventRequestDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? description,  String startTime,  String endTime,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _CreateEventRequestDto() when $default != null:
return $default(_that.title,_that.description,_that.startTime,_that.endTime,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateEventRequestDto implements CreateEventRequestDto {
  const _CreateEventRequestDto({required this.title, this.description, required this.startTime, required this.endTime, this.location});
  factory _CreateEventRequestDto.fromJson(Map<String, dynamic> json) => _$CreateEventRequestDtoFromJson(json);

@override final  String title;
@override final  String? description;
@override final  String startTime;
@override final  String endTime;
@override final  String? location;

/// Create a copy of CreateEventRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateEventRequestDtoCopyWith<_CreateEventRequestDto> get copyWith => __$CreateEventRequestDtoCopyWithImpl<_CreateEventRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateEventRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateEventRequestDto&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,startTime,endTime,location);

@override
String toString() {
  return 'CreateEventRequestDto(title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location)';
}


}

/// @nodoc
abstract mixin class _$CreateEventRequestDtoCopyWith<$Res> implements $CreateEventRequestDtoCopyWith<$Res> {
  factory _$CreateEventRequestDtoCopyWith(_CreateEventRequestDto value, $Res Function(_CreateEventRequestDto) _then) = __$CreateEventRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String title, String? description, String startTime, String endTime, String? location
});




}
/// @nodoc
class __$CreateEventRequestDtoCopyWithImpl<$Res>
    implements _$CreateEventRequestDtoCopyWith<$Res> {
  __$CreateEventRequestDtoCopyWithImpl(this._self, this._then);

  final _CreateEventRequestDto _self;
  final $Res Function(_CreateEventRequestDto) _then;

/// Create a copy of CreateEventRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,}) {
  return _then(_CreateEventRequestDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpdateEventRequestDto {

 String? get title; String? get description; String? get startTime; String? get endTime; String? get location;
/// Create a copy of UpdateEventRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateEventRequestDtoCopyWith<UpdateEventRequestDto> get copyWith => _$UpdateEventRequestDtoCopyWithImpl<UpdateEventRequestDto>(this as UpdateEventRequestDto, _$identity);

  /// Serializes this UpdateEventRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateEventRequestDto&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,startTime,endTime,location);

@override
String toString() {
  return 'UpdateEventRequestDto(title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location)';
}


}

/// @nodoc
abstract mixin class $UpdateEventRequestDtoCopyWith<$Res>  {
  factory $UpdateEventRequestDtoCopyWith(UpdateEventRequestDto value, $Res Function(UpdateEventRequestDto) _then) = _$UpdateEventRequestDtoCopyWithImpl;
@useResult
$Res call({
 String? title, String? description, String? startTime, String? endTime, String? location
});




}
/// @nodoc
class _$UpdateEventRequestDtoCopyWithImpl<$Res>
    implements $UpdateEventRequestDtoCopyWith<$Res> {
  _$UpdateEventRequestDtoCopyWithImpl(this._self, this._then);

  final UpdateEventRequestDto _self;
  final $Res Function(UpdateEventRequestDto) _then;

/// Create a copy of UpdateEventRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? location = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateEventRequestDto].
extension UpdateEventRequestDtoPatterns on UpdateEventRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateEventRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateEventRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateEventRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _UpdateEventRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateEventRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateEventRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? description,  String? startTime,  String? endTime,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateEventRequestDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? description,  String? startTime,  String? endTime,  String? location)  $default,) {final _that = this;
switch (_that) {
case _UpdateEventRequestDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? description,  String? startTime,  String? endTime,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _UpdateEventRequestDto() when $default != null:
return $default(_that.title,_that.description,_that.startTime,_that.endTime,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateEventRequestDto implements UpdateEventRequestDto {
  const _UpdateEventRequestDto({this.title, this.description, this.startTime, this.endTime, this.location});
  factory _UpdateEventRequestDto.fromJson(Map<String, dynamic> json) => _$UpdateEventRequestDtoFromJson(json);

@override final  String? title;
@override final  String? description;
@override final  String? startTime;
@override final  String? endTime;
@override final  String? location;

/// Create a copy of UpdateEventRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateEventRequestDtoCopyWith<_UpdateEventRequestDto> get copyWith => __$UpdateEventRequestDtoCopyWithImpl<_UpdateEventRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateEventRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateEventRequestDto&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,startTime,endTime,location);

@override
String toString() {
  return 'UpdateEventRequestDto(title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location)';
}


}

/// @nodoc
abstract mixin class _$UpdateEventRequestDtoCopyWith<$Res> implements $UpdateEventRequestDtoCopyWith<$Res> {
  factory _$UpdateEventRequestDtoCopyWith(_UpdateEventRequestDto value, $Res Function(_UpdateEventRequestDto) _then) = __$UpdateEventRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? description, String? startTime, String? endTime, String? location
});




}
/// @nodoc
class __$UpdateEventRequestDtoCopyWithImpl<$Res>
    implements _$UpdateEventRequestDtoCopyWith<$Res> {
  __$UpdateEventRequestDtoCopyWithImpl(this._self, this._then);

  final _UpdateEventRequestDto _self;
  final $Res Function(_UpdateEventRequestDto) _then;

/// Create a copy of UpdateEventRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? description = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? location = freezed,}) {
  return _then(_UpdateEventRequestDto(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RsvpRequestDto {

 String get status;
/// Create a copy of RsvpRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RsvpRequestDtoCopyWith<RsvpRequestDto> get copyWith => _$RsvpRequestDtoCopyWithImpl<RsvpRequestDto>(this as RsvpRequestDto, _$identity);

  /// Serializes this RsvpRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RsvpRequestDto&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'RsvpRequestDto(status: $status)';
}


}

/// @nodoc
abstract mixin class $RsvpRequestDtoCopyWith<$Res>  {
  factory $RsvpRequestDtoCopyWith(RsvpRequestDto value, $Res Function(RsvpRequestDto) _then) = _$RsvpRequestDtoCopyWithImpl;
@useResult
$Res call({
 String status
});




}
/// @nodoc
class _$RsvpRequestDtoCopyWithImpl<$Res>
    implements $RsvpRequestDtoCopyWith<$Res> {
  _$RsvpRequestDtoCopyWithImpl(this._self, this._then);

  final RsvpRequestDto _self;
  final $Res Function(RsvpRequestDto) _then;

/// Create a copy of RsvpRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RsvpRequestDto].
extension RsvpRequestDtoPatterns on RsvpRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RsvpRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RsvpRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RsvpRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _RsvpRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RsvpRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _RsvpRequestDto() when $default != null:
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
case _RsvpRequestDto() when $default != null:
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
case _RsvpRequestDto():
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
case _RsvpRequestDto() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RsvpRequestDto implements RsvpRequestDto {
  const _RsvpRequestDto({required this.status});
  factory _RsvpRequestDto.fromJson(Map<String, dynamic> json) => _$RsvpRequestDtoFromJson(json);

@override final  String status;

/// Create a copy of RsvpRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RsvpRequestDtoCopyWith<_RsvpRequestDto> get copyWith => __$RsvpRequestDtoCopyWithImpl<_RsvpRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RsvpRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RsvpRequestDto&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'RsvpRequestDto(status: $status)';
}


}

/// @nodoc
abstract mixin class _$RsvpRequestDtoCopyWith<$Res> implements $RsvpRequestDtoCopyWith<$Res> {
  factory _$RsvpRequestDtoCopyWith(_RsvpRequestDto value, $Res Function(_RsvpRequestDto) _then) = __$RsvpRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String status
});




}
/// @nodoc
class __$RsvpRequestDtoCopyWithImpl<$Res>
    implements _$RsvpRequestDtoCopyWith<$Res> {
  __$RsvpRequestDtoCopyWithImpl(this._self, this._then);

  final _RsvpRequestDto _self;
  final $Res Function(_RsvpRequestDto) _then;

/// Create a copy of RsvpRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_RsvpRequestDto(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
