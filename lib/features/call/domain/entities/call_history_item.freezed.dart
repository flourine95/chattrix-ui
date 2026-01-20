// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallHistoryItem {

 String get callId; int get conversationId; String get participantName; String? get participantAvatar; CallHistoryType get type; CallType get callType; DateTime get timestamp; Duration? get duration; bool get isMissed;
/// Create a copy of CallHistoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallHistoryItemCopyWith<CallHistoryItem> get copyWith => _$CallHistoryItemCopyWithImpl<CallHistoryItem>(this as CallHistoryItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallHistoryItem&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.participantName, participantName) || other.participantName == participantName)&&(identical(other.participantAvatar, participantAvatar) || other.participantAvatar == participantAvatar)&&(identical(other.type, type) || other.type == type)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isMissed, isMissed) || other.isMissed == isMissed));
}


@override
int get hashCode => Object.hash(runtimeType,callId,conversationId,participantName,participantAvatar,type,callType,timestamp,duration,isMissed);

@override
String toString() {
  return 'CallHistoryItem(callId: $callId, conversationId: $conversationId, participantName: $participantName, participantAvatar: $participantAvatar, type: $type, callType: $callType, timestamp: $timestamp, duration: $duration, isMissed: $isMissed)';
}


}

/// @nodoc
abstract mixin class $CallHistoryItemCopyWith<$Res>  {
  factory $CallHistoryItemCopyWith(CallHistoryItem value, $Res Function(CallHistoryItem) _then) = _$CallHistoryItemCopyWithImpl;
@useResult
$Res call({
 String callId, int conversationId, String participantName, String? participantAvatar, CallHistoryType type, CallType callType, DateTime timestamp, Duration? duration, bool isMissed
});




}
/// @nodoc
class _$CallHistoryItemCopyWithImpl<$Res>
    implements $CallHistoryItemCopyWith<$Res> {
  _$CallHistoryItemCopyWithImpl(this._self, this._then);

  final CallHistoryItem _self;
  final $Res Function(CallHistoryItem) _then;

/// Create a copy of CallHistoryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? conversationId = null,Object? participantName = null,Object? participantAvatar = freezed,Object? type = null,Object? callType = null,Object? timestamp = null,Object? duration = freezed,Object? isMissed = null,}) {
  return _then(_self.copyWith(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,participantName: null == participantName ? _self.participantName : participantName // ignore: cast_nullable_to_non_nullable
as String,participantAvatar: freezed == participantAvatar ? _self.participantAvatar : participantAvatar // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CallHistoryType,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,isMissed: null == isMissed ? _self.isMissed : isMissed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CallHistoryItem].
extension CallHistoryItemPatterns on CallHistoryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallHistoryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallHistoryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallHistoryItem value)  $default,){
final _that = this;
switch (_that) {
case _CallHistoryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallHistoryItem value)?  $default,){
final _that = this;
switch (_that) {
case _CallHistoryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String callId,  int conversationId,  String participantName,  String? participantAvatar,  CallHistoryType type,  CallType callType,  DateTime timestamp,  Duration? duration,  bool isMissed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallHistoryItem() when $default != null:
return $default(_that.callId,_that.conversationId,_that.participantName,_that.participantAvatar,_that.type,_that.callType,_that.timestamp,_that.duration,_that.isMissed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String callId,  int conversationId,  String participantName,  String? participantAvatar,  CallHistoryType type,  CallType callType,  DateTime timestamp,  Duration? duration,  bool isMissed)  $default,) {final _that = this;
switch (_that) {
case _CallHistoryItem():
return $default(_that.callId,_that.conversationId,_that.participantName,_that.participantAvatar,_that.type,_that.callType,_that.timestamp,_that.duration,_that.isMissed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String callId,  int conversationId,  String participantName,  String? participantAvatar,  CallHistoryType type,  CallType callType,  DateTime timestamp,  Duration? duration,  bool isMissed)?  $default,) {final _that = this;
switch (_that) {
case _CallHistoryItem() when $default != null:
return $default(_that.callId,_that.conversationId,_that.participantName,_that.participantAvatar,_that.type,_that.callType,_that.timestamp,_that.duration,_that.isMissed);case _:
  return null;

}
}

}

/// @nodoc


class _CallHistoryItem implements CallHistoryItem {
  const _CallHistoryItem({required this.callId, required this.conversationId, required this.participantName, this.participantAvatar, required this.type, required this.callType, required this.timestamp, this.duration, required this.isMissed});
  

@override final  String callId;
@override final  int conversationId;
@override final  String participantName;
@override final  String? participantAvatar;
@override final  CallHistoryType type;
@override final  CallType callType;
@override final  DateTime timestamp;
@override final  Duration? duration;
@override final  bool isMissed;

/// Create a copy of CallHistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallHistoryItemCopyWith<_CallHistoryItem> get copyWith => __$CallHistoryItemCopyWithImpl<_CallHistoryItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallHistoryItem&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.participantName, participantName) || other.participantName == participantName)&&(identical(other.participantAvatar, participantAvatar) || other.participantAvatar == participantAvatar)&&(identical(other.type, type) || other.type == type)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.isMissed, isMissed) || other.isMissed == isMissed));
}


@override
int get hashCode => Object.hash(runtimeType,callId,conversationId,participantName,participantAvatar,type,callType,timestamp,duration,isMissed);

@override
String toString() {
  return 'CallHistoryItem(callId: $callId, conversationId: $conversationId, participantName: $participantName, participantAvatar: $participantAvatar, type: $type, callType: $callType, timestamp: $timestamp, duration: $duration, isMissed: $isMissed)';
}


}

/// @nodoc
abstract mixin class _$CallHistoryItemCopyWith<$Res> implements $CallHistoryItemCopyWith<$Res> {
  factory _$CallHistoryItemCopyWith(_CallHistoryItem value, $Res Function(_CallHistoryItem) _then) = __$CallHistoryItemCopyWithImpl;
@override @useResult
$Res call({
 String callId, int conversationId, String participantName, String? participantAvatar, CallHistoryType type, CallType callType, DateTime timestamp, Duration? duration, bool isMissed
});




}
/// @nodoc
class __$CallHistoryItemCopyWithImpl<$Res>
    implements _$CallHistoryItemCopyWith<$Res> {
  __$CallHistoryItemCopyWithImpl(this._self, this._then);

  final _CallHistoryItem _self;
  final $Res Function(_CallHistoryItem) _then;

/// Create a copy of CallHistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? callId = null,Object? conversationId = null,Object? participantName = null,Object? participantAvatar = freezed,Object? type = null,Object? callType = null,Object? timestamp = null,Object? duration = freezed,Object? isMissed = null,}) {
  return _then(_CallHistoryItem(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,participantName: null == participantName ? _self.participantName : participantName // ignore: cast_nullable_to_non_nullable
as String,participantAvatar: freezed == participantAvatar ? _self.participantAvatar : participantAvatar // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CallHistoryType,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,isMissed: null == isMissed ? _self.isMissed : isMissed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
