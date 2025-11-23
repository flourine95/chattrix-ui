// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_quality_warning_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallQualityWarningMessage {

 String get type; CallQualityWarningData get data; DateTime get timestamp;
/// Create a copy of CallQualityWarningMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallQualityWarningMessageCopyWith<CallQualityWarningMessage> get copyWith => _$CallQualityWarningMessageCopyWithImpl<CallQualityWarningMessage>(this as CallQualityWarningMessage, _$identity);

  /// Serializes this CallQualityWarningMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallQualityWarningMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,timestamp);

@override
String toString() {
  return 'CallQualityWarningMessage(type: $type, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $CallQualityWarningMessageCopyWith<$Res>  {
  factory $CallQualityWarningMessageCopyWith(CallQualityWarningMessage value, $Res Function(CallQualityWarningMessage) _then) = _$CallQualityWarningMessageCopyWithImpl;
@useResult
$Res call({
 String type, CallQualityWarningData data, DateTime timestamp
});


$CallQualityWarningDataCopyWith<$Res> get data;

}
/// @nodoc
class _$CallQualityWarningMessageCopyWithImpl<$Res>
    implements $CallQualityWarningMessageCopyWith<$Res> {
  _$CallQualityWarningMessageCopyWithImpl(this._self, this._then);

  final CallQualityWarningMessage _self;
  final $Res Function(CallQualityWarningMessage) _then;

/// Create a copy of CallQualityWarningMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? data = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CallQualityWarningData,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of CallQualityWarningMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallQualityWarningDataCopyWith<$Res> get data {
  
  return $CallQualityWarningDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CallQualityWarningMessage].
extension CallQualityWarningMessagePatterns on CallQualityWarningMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallQualityWarningMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallQualityWarningMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallQualityWarningMessage value)  $default,){
final _that = this;
switch (_that) {
case _CallQualityWarningMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallQualityWarningMessage value)?  $default,){
final _that = this;
switch (_that) {
case _CallQualityWarningMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  CallQualityWarningData data,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallQualityWarningMessage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  CallQualityWarningData data,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _CallQualityWarningMessage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  CallQualityWarningData data,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _CallQualityWarningMessage() when $default != null:
return $default(_that.type,_that.data,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallQualityWarningMessage implements CallQualityWarningMessage {
  const _CallQualityWarningMessage({required this.type, required this.data, required this.timestamp});
  factory _CallQualityWarningMessage.fromJson(Map<String, dynamic> json) => _$CallQualityWarningMessageFromJson(json);

@override final  String type;
@override final  CallQualityWarningData data;
@override final  DateTime timestamp;

/// Create a copy of CallQualityWarningMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallQualityWarningMessageCopyWith<_CallQualityWarningMessage> get copyWith => __$CallQualityWarningMessageCopyWithImpl<_CallQualityWarningMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallQualityWarningMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallQualityWarningMessage&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,timestamp);

@override
String toString() {
  return 'CallQualityWarningMessage(type: $type, data: $data, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$CallQualityWarningMessageCopyWith<$Res> implements $CallQualityWarningMessageCopyWith<$Res> {
  factory _$CallQualityWarningMessageCopyWith(_CallQualityWarningMessage value, $Res Function(_CallQualityWarningMessage) _then) = __$CallQualityWarningMessageCopyWithImpl;
@override @useResult
$Res call({
 String type, CallQualityWarningData data, DateTime timestamp
});


@override $CallQualityWarningDataCopyWith<$Res> get data;

}
/// @nodoc
class __$CallQualityWarningMessageCopyWithImpl<$Res>
    implements _$CallQualityWarningMessageCopyWith<$Res> {
  __$CallQualityWarningMessageCopyWithImpl(this._self, this._then);

  final _CallQualityWarningMessage _self;
  final $Res Function(_CallQualityWarningMessage) _then;

/// Create a copy of CallQualityWarningMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? data = null,Object? timestamp = null,}) {
  return _then(_CallQualityWarningMessage(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CallQualityWarningData,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of CallQualityWarningMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallQualityWarningDataCopyWith<$Res> get data {
  
  return $CallQualityWarningDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
