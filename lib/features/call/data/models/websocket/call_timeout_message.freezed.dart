// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_timeout_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallTimeoutMessage {

 String get type; CallTimeoutData get data; DateTime get timestamp;
/// Create a copy of CallTimeoutMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallTimeoutMessageCopyWith<CallTimeoutMessage> get copyWith => _$CallTimeoutMessageCopyWithImpl<CallTimeoutMessage>(this as CallTimeoutMessage, _$identity);

  /// Serializes this CallTimeoutMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallTimeoutMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,timestamp);

@override
String toString() {
  return 'CallTimeoutMessage(type: $type, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $CallTimeoutMessageCopyWith<$Res>  {
  factory $CallTimeoutMessageCopyWith(CallTimeoutMessage value, $Res Function(CallTimeoutMessage) _then) = _$CallTimeoutMessageCopyWithImpl;
@useResult
$Res call({
 String type, CallTimeoutData data, DateTime timestamp
});


$CallTimeoutDataCopyWith<$Res> get data;

}
/// @nodoc
class _$CallTimeoutMessageCopyWithImpl<$Res>
    implements $CallTimeoutMessageCopyWith<$Res> {
  _$CallTimeoutMessageCopyWithImpl(this._self, this._then);

  final CallTimeoutMessage _self;
  final $Res Function(CallTimeoutMessage) _then;

/// Create a copy of CallTimeoutMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? data = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CallTimeoutData,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of CallTimeoutMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallTimeoutDataCopyWith<$Res> get data {
  
  return $CallTimeoutDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallTimeoutMessage].
extension CallTimeoutMessagePatterns on CallTimeoutMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallTimeoutMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallTimeoutMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallTimeoutMessage value)  $default,){
final _that = this;
switch (_that) {
case _CallTimeoutMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallTimeoutMessage value)?  $default,){
final _that = this;
switch (_that) {
case _CallTimeoutMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  CallTimeoutData data,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallTimeoutMessage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  CallTimeoutData data,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _CallTimeoutMessage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  CallTimeoutData data,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _CallTimeoutMessage() when $default != null:
return $default(_that.type,_that.data,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallTimeoutMessage implements CallTimeoutMessage {
  const _CallTimeoutMessage({required this.type, required this.data, required this.timestamp});
  factory _CallTimeoutMessage.fromJson(Map<String, dynamic> json) => _$CallTimeoutMessageFromJson(json);

@override final  String type;
@override final  CallTimeoutData data;
@override final  DateTime timestamp;

/// Create a copy of CallTimeoutMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallTimeoutMessageCopyWith<_CallTimeoutMessage> get copyWith => __$CallTimeoutMessageCopyWithImpl<_CallTimeoutMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallTimeoutMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallTimeoutMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,timestamp);

@override
String toString() {
  return 'CallTimeoutMessage(type: $type, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$CallTimeoutMessageCopyWith<$Res> implements $CallTimeoutMessageCopyWith<$Res> {
  factory _$CallTimeoutMessageCopyWith(_CallTimeoutMessage value, $Res Function(_CallTimeoutMessage) _then) = __$CallTimeoutMessageCopyWithImpl;
@override @useResult
$Res call({
 String type, CallTimeoutData data, DateTime timestamp
});


@override $CallTimeoutDataCopyWith<$Res> get data;

}
/// @nodoc
class __$CallTimeoutMessageCopyWithImpl<$Res>
    implements _$CallTimeoutMessageCopyWith<$Res> {
  __$CallTimeoutMessageCopyWithImpl(this._self, this._then);

  final _CallTimeoutMessage _self;
  final $Res Function(_CallTimeoutMessage) _then;

/// Create a copy of CallTimeoutMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? data = null,Object? timestamp = null,}) {
  return _then(_CallTimeoutMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CallTimeoutData,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of CallTimeoutMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallTimeoutDataCopyWith<$Res> get data {
  
  return $CallTimeoutDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
