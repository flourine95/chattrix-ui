// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_accepted_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallAcceptedMessage {

 String get type; CallAcceptedData get data; DateTime get timestamp;
/// Create a copy of CallAcceptedMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallAcceptedMessageCopyWith<CallAcceptedMessage> get copyWith => _$CallAcceptedMessageCopyWithImpl<CallAcceptedMessage>(this as CallAcceptedMessage, _$identity);

  /// Serializes this CallAcceptedMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallAcceptedMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,timestamp);

@override
String toString() {
  return 'CallAcceptedMessage(type: $type, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $CallAcceptedMessageCopyWith<$Res>  {
  factory $CallAcceptedMessageCopyWith(CallAcceptedMessage value, $Res Function(CallAcceptedMessage) _then) = _$CallAcceptedMessageCopyWithImpl;
@useResult
$Res call({
 String type, CallAcceptedData data, DateTime timestamp
});


$CallAcceptedDataCopyWith<$Res> get data;

}
/// @nodoc
class _$CallAcceptedMessageCopyWithImpl<$Res>
    implements $CallAcceptedMessageCopyWith<$Res> {
  _$CallAcceptedMessageCopyWithImpl(this._self, this._then);

  final CallAcceptedMessage _self;
  final $Res Function(CallAcceptedMessage) _then;

/// Create a copy of CallAcceptedMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? data = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CallAcceptedData,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of CallAcceptedMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallAcceptedDataCopyWith<$Res> get data {
  
  return $CallAcceptedDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallAcceptedMessage].
extension CallAcceptedMessagePatterns on CallAcceptedMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallAcceptedMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallAcceptedMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallAcceptedMessage value)  $default,){
final _that = this;
switch (_that) {
case _CallAcceptedMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallAcceptedMessage value)?  $default,){
final _that = this;
switch (_that) {
case _CallAcceptedMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  CallAcceptedData data,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallAcceptedMessage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  CallAcceptedData data,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _CallAcceptedMessage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  CallAcceptedData data,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _CallAcceptedMessage() when $default != null:
return $default(_that.type,_that.data,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallAcceptedMessage implements CallAcceptedMessage {
  const _CallAcceptedMessage({required this.type, required this.data, required this.timestamp});
  factory _CallAcceptedMessage.fromJson(Map<String, dynamic> json) => _$CallAcceptedMessageFromJson(json);

@override final  String type;
@override final  CallAcceptedData data;
@override final  DateTime timestamp;

/// Create a copy of CallAcceptedMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallAcceptedMessageCopyWith<_CallAcceptedMessage> get copyWith => __$CallAcceptedMessageCopyWithImpl<_CallAcceptedMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallAcceptedMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallAcceptedMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,timestamp);

@override
String toString() {
  return 'CallAcceptedMessage(type: $type, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$CallAcceptedMessageCopyWith<$Res> implements $CallAcceptedMessageCopyWith<$Res> {
  factory _$CallAcceptedMessageCopyWith(_CallAcceptedMessage value, $Res Function(_CallAcceptedMessage) _then) = __$CallAcceptedMessageCopyWithImpl;
@override @useResult
$Res call({
 String type, CallAcceptedData data, DateTime timestamp
});


@override $CallAcceptedDataCopyWith<$Res> get data;

}
/// @nodoc
class __$CallAcceptedMessageCopyWithImpl<$Res>
    implements _$CallAcceptedMessageCopyWith<$Res> {
  __$CallAcceptedMessageCopyWithImpl(this._self, this._then);

  final _CallAcceptedMessage _self;
  final $Res Function(_CallAcceptedMessage) _then;

/// Create a copy of CallAcceptedMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? data = null,Object? timestamp = null,}) {
  return _then(_CallAcceptedMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CallAcceptedData,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of CallAcceptedMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallAcceptedDataCopyWith<$Res> get data {
  
  return $CallAcceptedDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
