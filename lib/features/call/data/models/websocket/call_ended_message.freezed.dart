// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_ended_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallEndedMessage {

 String get type; CallEndedData get data; DateTime get timestamp;
/// Create a copy of CallEndedMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallEndedMessageCopyWith<CallEndedMessage> get copyWith => _$CallEndedMessageCopyWithImpl<CallEndedMessage>(this as CallEndedMessage, _$identity);

  /// Serializes this CallEndedMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallEndedMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,timestamp);

@override
String toString() {
  return 'CallEndedMessage(type: $type, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $CallEndedMessageCopyWith<$Res>  {
  factory $CallEndedMessageCopyWith(CallEndedMessage value, $Res Function(CallEndedMessage) _then) = _$CallEndedMessageCopyWithImpl;
@useResult
$Res call({
 String type, CallEndedData data, DateTime timestamp
});


$CallEndedDataCopyWith<$Res> get data;

}
/// @nodoc
class _$CallEndedMessageCopyWithImpl<$Res>
    implements $CallEndedMessageCopyWith<$Res> {
  _$CallEndedMessageCopyWithImpl(this._self, this._then);

  final CallEndedMessage _self;
  final $Res Function(CallEndedMessage) _then;

/// Create a copy of CallEndedMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? data = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CallEndedData,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of CallEndedMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallEndedDataCopyWith<$Res> get data {
  
  return $CallEndedDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallEndedMessage].
extension CallEndedMessagePatterns on CallEndedMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallEndedMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallEndedMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallEndedMessage value)  $default,){
final _that = this;
switch (_that) {
case _CallEndedMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallEndedMessage value)?  $default,){
final _that = this;
switch (_that) {
case _CallEndedMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  CallEndedData data,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallEndedMessage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  CallEndedData data,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _CallEndedMessage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  CallEndedData data,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _CallEndedMessage() when $default != null:
return $default(_that.type,_that.data,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallEndedMessage implements CallEndedMessage {
  const _CallEndedMessage({required this.type, required this.data, required this.timestamp});
  factory _CallEndedMessage.fromJson(Map<String, dynamic> json) => _$CallEndedMessageFromJson(json);

@override final  String type;
@override final  CallEndedData data;
@override final  DateTime timestamp;

/// Create a copy of CallEndedMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallEndedMessageCopyWith<_CallEndedMessage> get copyWith => __$CallEndedMessageCopyWithImpl<_CallEndedMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallEndedMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallEndedMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,timestamp);

@override
String toString() {
  return 'CallEndedMessage(type: $type, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$CallEndedMessageCopyWith<$Res> implements $CallEndedMessageCopyWith<$Res> {
  factory _$CallEndedMessageCopyWith(_CallEndedMessage value, $Res Function(_CallEndedMessage) _then) = __$CallEndedMessageCopyWithImpl;
@override @useResult
$Res call({
 String type, CallEndedData data, DateTime timestamp
});


@override $CallEndedDataCopyWith<$Res> get data;

}
/// @nodoc
class __$CallEndedMessageCopyWithImpl<$Res>
    implements _$CallEndedMessageCopyWith<$Res> {
  __$CallEndedMessageCopyWithImpl(this._self, this._then);

  final _CallEndedMessage _self;
  final $Res Function(_CallEndedMessage) _then;

/// Create a copy of CallEndedMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? data = null,Object? timestamp = null,}) {
  return _then(_CallEndedMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CallEndedData,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of CallEndedMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallEndedDataCopyWith<$Res> get data {
  
  return $CallEndedDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
