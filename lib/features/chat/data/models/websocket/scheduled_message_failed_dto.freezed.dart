// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduled_message_failed_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScheduledMessageFailedDto {

 int get scheduledMessageId; int get conversationId; String get failedReason; DateTime get failedAt;
/// Create a copy of ScheduledMessageFailedDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduledMessageFailedDtoCopyWith<ScheduledMessageFailedDto> get copyWith => _$ScheduledMessageFailedDtoCopyWithImpl<ScheduledMessageFailedDto>(this as ScheduledMessageFailedDto, _$identity);

  /// Serializes this ScheduledMessageFailedDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduledMessageFailedDto&&(identical(other.scheduledMessageId, scheduledMessageId) || other.scheduledMessageId == scheduledMessageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.failedReason, failedReason) || other.failedReason == failedReason)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scheduledMessageId,conversationId,failedReason,failedAt);

@override
String toString() {
  return 'ScheduledMessageFailedDto(scheduledMessageId: $scheduledMessageId, conversationId: $conversationId, failedReason: $failedReason, failedAt: $failedAt)';
}


}

/// @nodoc
abstract mixin class $ScheduledMessageFailedDtoCopyWith<$Res>  {
  factory $ScheduledMessageFailedDtoCopyWith(ScheduledMessageFailedDto value, $Res Function(ScheduledMessageFailedDto) _then) = _$ScheduledMessageFailedDtoCopyWithImpl;
@useResult
$Res call({
 int scheduledMessageId, int conversationId, String failedReason, DateTime failedAt
});




}
/// @nodoc
class _$ScheduledMessageFailedDtoCopyWithImpl<$Res>
    implements $ScheduledMessageFailedDtoCopyWith<$Res> {
  _$ScheduledMessageFailedDtoCopyWithImpl(this._self, this._then);

  final ScheduledMessageFailedDto _self;
  final $Res Function(ScheduledMessageFailedDto) _then;

/// Create a copy of ScheduledMessageFailedDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scheduledMessageId = null,Object? conversationId = null,Object? failedReason = null,Object? failedAt = null,}) {
  return _then(_self.copyWith(
scheduledMessageId: null == scheduledMessageId ? _self.scheduledMessageId : scheduledMessageId // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,failedReason: null == failedReason ? _self.failedReason : failedReason // ignore: cast_nullable_to_non_nullable
as String,failedAt: null == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduledMessageFailedDto].
extension ScheduledMessageFailedDtoPatterns on ScheduledMessageFailedDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduledMessageFailedDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduledMessageFailedDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduledMessageFailedDto value)  $default,){
final _that = this;
switch (_that) {
case _ScheduledMessageFailedDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduledMessageFailedDto value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduledMessageFailedDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int scheduledMessageId,  int conversationId,  String failedReason,  DateTime failedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduledMessageFailedDto() when $default != null:
return $default(_that.scheduledMessageId,_that.conversationId,_that.failedReason,_that.failedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int scheduledMessageId,  int conversationId,  String failedReason,  DateTime failedAt)  $default,) {final _that = this;
switch (_that) {
case _ScheduledMessageFailedDto():
return $default(_that.scheduledMessageId,_that.conversationId,_that.failedReason,_that.failedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int scheduledMessageId,  int conversationId,  String failedReason,  DateTime failedAt)?  $default,) {final _that = this;
switch (_that) {
case _ScheduledMessageFailedDto() when $default != null:
return $default(_that.scheduledMessageId,_that.conversationId,_that.failedReason,_that.failedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduledMessageFailedDto implements ScheduledMessageFailedDto {
  const _ScheduledMessageFailedDto({required this.scheduledMessageId, required this.conversationId, required this.failedReason, required this.failedAt});
  factory _ScheduledMessageFailedDto.fromJson(Map<String, dynamic> json) => _$ScheduledMessageFailedDtoFromJson(json);

@override final  int scheduledMessageId;
@override final  int conversationId;
@override final  String failedReason;
@override final  DateTime failedAt;

/// Create a copy of ScheduledMessageFailedDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduledMessageFailedDtoCopyWith<_ScheduledMessageFailedDto> get copyWith => __$ScheduledMessageFailedDtoCopyWithImpl<_ScheduledMessageFailedDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduledMessageFailedDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduledMessageFailedDto&&(identical(other.scheduledMessageId, scheduledMessageId) || other.scheduledMessageId == scheduledMessageId)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.failedReason, failedReason) || other.failedReason == failedReason)&&(identical(other.failedAt, failedAt) || other.failedAt == failedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scheduledMessageId,conversationId,failedReason,failedAt);

@override
String toString() {
  return 'ScheduledMessageFailedDto(scheduledMessageId: $scheduledMessageId, conversationId: $conversationId, failedReason: $failedReason, failedAt: $failedAt)';
}


}

/// @nodoc
abstract mixin class _$ScheduledMessageFailedDtoCopyWith<$Res> implements $ScheduledMessageFailedDtoCopyWith<$Res> {
  factory _$ScheduledMessageFailedDtoCopyWith(_ScheduledMessageFailedDto value, $Res Function(_ScheduledMessageFailedDto) _then) = __$ScheduledMessageFailedDtoCopyWithImpl;
@override @useResult
$Res call({
 int scheduledMessageId, int conversationId, String failedReason, DateTime failedAt
});




}
/// @nodoc
class __$ScheduledMessageFailedDtoCopyWithImpl<$Res>
    implements _$ScheduledMessageFailedDtoCopyWith<$Res> {
  __$ScheduledMessageFailedDtoCopyWithImpl(this._self, this._then);

  final _ScheduledMessageFailedDto _self;
  final $Res Function(_ScheduledMessageFailedDto) _then;

/// Create a copy of ScheduledMessageFailedDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scheduledMessageId = null,Object? conversationId = null,Object? failedReason = null,Object? failedAt = null,}) {
  return _then(_ScheduledMessageFailedDto(
scheduledMessageId: null == scheduledMessageId ? _self.scheduledMessageId : scheduledMessageId // ignore: cast_nullable_to_non_nullable
as int,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,failedReason: null == failedReason ? _self.failedReason : failedReason // ignore: cast_nullable_to_non_nullable
as String,failedAt: null == failedAt ? _self.failedAt : failedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
