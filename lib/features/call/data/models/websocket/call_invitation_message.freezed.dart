// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_invitation_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallInvitationMessage {

 String get type; CallInvitationData get data; DateTime get timestamp;
/// Create a copy of CallInvitationMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallInvitationMessageCopyWith<CallInvitationMessage> get copyWith => _$CallInvitationMessageCopyWithImpl<CallInvitationMessage>(this as CallInvitationMessage, _$identity);

  /// Serializes this CallInvitationMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallInvitationMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,timestamp);

@override
String toString() {
  return 'CallInvitationMessage(type: $type, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $CallInvitationMessageCopyWith<$Res>  {
  factory $CallInvitationMessageCopyWith(CallInvitationMessage value, $Res Function(CallInvitationMessage) _then) = _$CallInvitationMessageCopyWithImpl;
@useResult
$Res call({
 String type, CallInvitationData data, DateTime timestamp
});


$CallInvitationDataCopyWith<$Res> get data;

}
/// @nodoc
class _$CallInvitationMessageCopyWithImpl<$Res>
    implements $CallInvitationMessageCopyWith<$Res> {
  _$CallInvitationMessageCopyWithImpl(this._self, this._then);

  final CallInvitationMessage _self;
  final $Res Function(CallInvitationMessage) _then;

/// Create a copy of CallInvitationMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? data = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CallInvitationData,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of CallInvitationMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallInvitationDataCopyWith<$Res> get data {
  
  return $CallInvitationDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallInvitationMessage].
extension CallInvitationMessagePatterns on CallInvitationMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallInvitationMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallInvitationMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallInvitationMessage value)  $default,){
final _that = this;
switch (_that) {
case _CallInvitationMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallInvitationMessage value)?  $default,){
final _that = this;
switch (_that) {
case _CallInvitationMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  CallInvitationData data,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallInvitationMessage() when $default != null:
return $default(_that.type,_that.data,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  CallInvitationData data,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _CallInvitationMessage():
return $default(_that.type,_that.data,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  CallInvitationData data,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _CallInvitationMessage() when $default != null:
return $default(_that.type,_that.data,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallInvitationMessage implements CallInvitationMessage {
  const _CallInvitationMessage({required this.type, required this.data, required this.timestamp});
  factory _CallInvitationMessage.fromJson(Map<String, dynamic> json) => _$CallInvitationMessageFromJson(json);

@override final  String type;
@override final  CallInvitationData data;
@override final  DateTime timestamp;

/// Create a copy of CallInvitationMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallInvitationMessageCopyWith<_CallInvitationMessage> get copyWith => __$CallInvitationMessageCopyWithImpl<_CallInvitationMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallInvitationMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallInvitationMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,timestamp);

@override
String toString() {
  return 'CallInvitationMessage(type: $type, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$CallInvitationMessageCopyWith<$Res> implements $CallInvitationMessageCopyWith<$Res> {
  factory _$CallInvitationMessageCopyWith(_CallInvitationMessage value, $Res Function(_CallInvitationMessage) _then) = __$CallInvitationMessageCopyWithImpl;
@override @useResult
$Res call({
 String type, CallInvitationData data, DateTime timestamp
});


@override $CallInvitationDataCopyWith<$Res> get data;

}
/// @nodoc
class __$CallInvitationMessageCopyWithImpl<$Res>
    implements _$CallInvitationMessageCopyWith<$Res> {
  __$CallInvitationMessageCopyWithImpl(this._self, this._then);

  final _CallInvitationMessage _self;
  final $Res Function(_CallInvitationMessage) _then;

/// Create a copy of CallInvitationMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? data = null,Object? timestamp = null,}) {
  return _then(_CallInvitationMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CallInvitationData,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of CallInvitationMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallInvitationDataCopyWith<$Res> get data {
  
  return $CallInvitationDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
