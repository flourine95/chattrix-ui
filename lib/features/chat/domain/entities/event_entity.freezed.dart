// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventEntity {

 int get id; int get conversationId; User get creator; String get title; String? get description; DateTime get startTime; DateTime get endTime; String? get location; DateTime get createdAt; DateTime get updatedAt; int get goingCount; int get maybeCount; int get notGoingCount; String? get currentUserRsvpStatus; List<EventRsvp> get rsvps;
/// Create a copy of EventEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventEntityCopyWith<EventEntity> get copyWith => _$EventEntityCopyWithImpl<EventEntity>(this as EventEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.goingCount, goingCount) || other.goingCount == goingCount)&&(identical(other.maybeCount, maybeCount) || other.maybeCount == maybeCount)&&(identical(other.notGoingCount, notGoingCount) || other.notGoingCount == notGoingCount)&&(identical(other.currentUserRsvpStatus, currentUserRsvpStatus) || other.currentUserRsvpStatus == currentUserRsvpStatus)&&const DeepCollectionEquality().equals(other.rsvps, rsvps));
}


@override
int get hashCode => Object.hash(runtimeType,id,conversationId,creator,title,description,startTime,endTime,location,createdAt,updatedAt,goingCount,maybeCount,notGoingCount,currentUserRsvpStatus,const DeepCollectionEquality().hash(rsvps));

@override
String toString() {
  return 'EventEntity(id: $id, conversationId: $conversationId, creator: $creator, title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, goingCount: $goingCount, maybeCount: $maybeCount, notGoingCount: $notGoingCount, currentUserRsvpStatus: $currentUserRsvpStatus, rsvps: $rsvps)';
}


}

/// @nodoc
abstract mixin class $EventEntityCopyWith<$Res>  {
  factory $EventEntityCopyWith(EventEntity value, $Res Function(EventEntity) _then) = _$EventEntityCopyWithImpl;
@useResult
$Res call({
 int id, int conversationId, User creator, String title, String? description, DateTime startTime, DateTime endTime, String? location, DateTime createdAt, DateTime updatedAt, int goingCount, int maybeCount, int notGoingCount, String? currentUserRsvpStatus, List<EventRsvp> rsvps
});


$UserCopyWith<$Res> get creator;

}
/// @nodoc
class _$EventEntityCopyWithImpl<$Res>
    implements $EventEntityCopyWith<$Res> {
  _$EventEntityCopyWithImpl(this._self, this._then);

  final EventEntity _self;
  final $Res Function(EventEntity) _then;

/// Create a copy of EventEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? creator = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,Object? createdAt = null,Object? updatedAt = null,Object? goingCount = null,Object? maybeCount = null,Object? notGoingCount = null,Object? currentUserRsvpStatus = freezed,Object? rsvps = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as User,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
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
as List<EventRsvp>,
  ));
}
/// Create a copy of EventEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get creator {
  
  return $UserCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventEntity].
extension EventEntityPatterns on EventEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventEntity value)  $default,){
final _that = this;
switch (_that) {
case _EventEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventEntity value)?  $default,){
final _that = this;
switch (_that) {
case _EventEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int conversationId,  User creator,  String title,  String? description,  DateTime startTime,  DateTime endTime,  String? location,  DateTime createdAt,  DateTime updatedAt,  int goingCount,  int maybeCount,  int notGoingCount,  String? currentUserRsvpStatus,  List<EventRsvp> rsvps)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int conversationId,  User creator,  String title,  String? description,  DateTime startTime,  DateTime endTime,  String? location,  DateTime createdAt,  DateTime updatedAt,  int goingCount,  int maybeCount,  int notGoingCount,  String? currentUserRsvpStatus,  List<EventRsvp> rsvps)  $default,) {final _that = this;
switch (_that) {
case _EventEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int conversationId,  User creator,  String title,  String? description,  DateTime startTime,  DateTime endTime,  String? location,  DateTime createdAt,  DateTime updatedAt,  int goingCount,  int maybeCount,  int notGoingCount,  String? currentUserRsvpStatus,  List<EventRsvp> rsvps)?  $default,) {final _that = this;
switch (_that) {
case _EventEntity() when $default != null:
return $default(_that.id,_that.conversationId,_that.creator,_that.title,_that.description,_that.startTime,_that.endTime,_that.location,_that.createdAt,_that.updatedAt,_that.goingCount,_that.maybeCount,_that.notGoingCount,_that.currentUserRsvpStatus,_that.rsvps);case _:
  return null;

}
}

}

/// @nodoc


class _EventEntity implements EventEntity {
  const _EventEntity({required this.id, required this.conversationId, required this.creator, required this.title, this.description, required this.startTime, required this.endTime, this.location, required this.createdAt, required this.updatedAt, required this.goingCount, required this.maybeCount, required this.notGoingCount, this.currentUserRsvpStatus, required final  List<EventRsvp> rsvps}): _rsvps = rsvps;
  

@override final  int id;
@override final  int conversationId;
@override final  User creator;
@override final  String title;
@override final  String? description;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  String? location;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  int goingCount;
@override final  int maybeCount;
@override final  int notGoingCount;
@override final  String? currentUserRsvpStatus;
 final  List<EventRsvp> _rsvps;
@override List<EventRsvp> get rsvps {
  if (_rsvps is EqualUnmodifiableListView) return _rsvps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rsvps);
}


/// Create a copy of EventEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventEntityCopyWith<_EventEntity> get copyWith => __$EventEntityCopyWithImpl<_EventEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.creator, creator) || other.creator == creator)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.location, location) || other.location == location)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.goingCount, goingCount) || other.goingCount == goingCount)&&(identical(other.maybeCount, maybeCount) || other.maybeCount == maybeCount)&&(identical(other.notGoingCount, notGoingCount) || other.notGoingCount == notGoingCount)&&(identical(other.currentUserRsvpStatus, currentUserRsvpStatus) || other.currentUserRsvpStatus == currentUserRsvpStatus)&&const DeepCollectionEquality().equals(other._rsvps, _rsvps));
}


@override
int get hashCode => Object.hash(runtimeType,id,conversationId,creator,title,description,startTime,endTime,location,createdAt,updatedAt,goingCount,maybeCount,notGoingCount,currentUserRsvpStatus,const DeepCollectionEquality().hash(_rsvps));

@override
String toString() {
  return 'EventEntity(id: $id, conversationId: $conversationId, creator: $creator, title: $title, description: $description, startTime: $startTime, endTime: $endTime, location: $location, createdAt: $createdAt, updatedAt: $updatedAt, goingCount: $goingCount, maybeCount: $maybeCount, notGoingCount: $notGoingCount, currentUserRsvpStatus: $currentUserRsvpStatus, rsvps: $rsvps)';
}


}

/// @nodoc
abstract mixin class _$EventEntityCopyWith<$Res> implements $EventEntityCopyWith<$Res> {
  factory _$EventEntityCopyWith(_EventEntity value, $Res Function(_EventEntity) _then) = __$EventEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, int conversationId, User creator, String title, String? description, DateTime startTime, DateTime endTime, String? location, DateTime createdAt, DateTime updatedAt, int goingCount, int maybeCount, int notGoingCount, String? currentUserRsvpStatus, List<EventRsvp> rsvps
});


@override $UserCopyWith<$Res> get creator;

}
/// @nodoc
class __$EventEntityCopyWithImpl<$Res>
    implements _$EventEntityCopyWith<$Res> {
  __$EventEntityCopyWithImpl(this._self, this._then);

  final _EventEntity _self;
  final $Res Function(_EventEntity) _then;

/// Create a copy of EventEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? creator = null,Object? title = null,Object? description = freezed,Object? startTime = null,Object? endTime = null,Object? location = freezed,Object? createdAt = null,Object? updatedAt = null,Object? goingCount = null,Object? maybeCount = null,Object? notGoingCount = null,Object? currentUserRsvpStatus = freezed,Object? rsvps = null,}) {
  return _then(_EventEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,creator: null == creator ? _self.creator : creator // ignore: cast_nullable_to_non_nullable
as User,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
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
as List<EventRsvp>,
  ));
}

/// Create a copy of EventEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get creator {
  
  return $UserCopyWith<$Res>(_self.creator, (value) {
    return _then(_self.copyWith(creator: value));
  });
}
}

/// @nodoc
mixin _$EventRsvp {

 int get id; User get user; String get status;// GOING, MAYBE, NOT_GOING
 DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of EventRsvp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventRsvpCopyWith<EventRsvp> get copyWith => _$EventRsvpCopyWithImpl<EventRsvp>(this as EventRsvp, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventRsvp&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,user,status,createdAt,updatedAt);

@override
String toString() {
  return 'EventRsvp(id: $id, user: $user, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EventRsvpCopyWith<$Res>  {
  factory $EventRsvpCopyWith(EventRsvp value, $Res Function(EventRsvp) _then) = _$EventRsvpCopyWithImpl;
@useResult
$Res call({
 int id, User user, String status, DateTime createdAt, DateTime updatedAt
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class _$EventRsvpCopyWithImpl<$Res>
    implements $EventRsvpCopyWith<$Res> {
  _$EventRsvpCopyWithImpl(this._self, this._then);

  final EventRsvp _self;
  final $Res Function(EventRsvp) _then;

/// Create a copy of EventRsvp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? user = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of EventRsvp
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventRsvp].
extension EventRsvpPatterns on EventRsvp {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventRsvp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventRsvp() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventRsvp value)  $default,){
final _that = this;
switch (_that) {
case _EventRsvp():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventRsvp value)?  $default,){
final _that = this;
switch (_that) {
case _EventRsvp() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  User user,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventRsvp() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  User user,  String status,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _EventRsvp():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  User user,  String status,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _EventRsvp() when $default != null:
return $default(_that.id,_that.user,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _EventRsvp implements EventRsvp {
  const _EventRsvp({required this.id, required this.user, required this.status, required this.createdAt, required this.updatedAt});
  

@override final  int id;
@override final  User user;
@override final  String status;
// GOING, MAYBE, NOT_GOING
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of EventRsvp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventRsvpCopyWith<_EventRsvp> get copyWith => __$EventRsvpCopyWithImpl<_EventRsvp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventRsvp&&(identical(other.id, id) || other.id == id)&&(identical(other.user, user) || other.user == user)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,user,status,createdAt,updatedAt);

@override
String toString() {
  return 'EventRsvp(id: $id, user: $user, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EventRsvpCopyWith<$Res> implements $EventRsvpCopyWith<$Res> {
  factory _$EventRsvpCopyWith(_EventRsvp value, $Res Function(_EventRsvp) _then) = __$EventRsvpCopyWithImpl;
@override @useResult
$Res call({
 int id, User user, String status, DateTime createdAt, DateTime updatedAt
});


@override $UserCopyWith<$Res> get user;

}
/// @nodoc
class __$EventRsvpCopyWithImpl<$Res>
    implements _$EventRsvpCopyWith<$Res> {
  __$EventRsvpCopyWithImpl(this._self, this._then);

  final _EventRsvp _self;
  final $Res Function(_EventRsvp) _then;

/// Create a copy of EventRsvp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? user = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_EventRsvp(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of EventRsvp
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
