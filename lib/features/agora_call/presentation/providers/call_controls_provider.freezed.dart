// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_controls_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallControlsState implements DiagnosticableTreeMixin {

/// Whether the microphone is muted
 bool get isMuted;/// Whether the video is enabled (for video calls)
 bool get isVideoEnabled;/// Whether the speaker is on (true) or earpiece (false)
 bool get isSpeakerOn;
/// Create a copy of CallControlsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallControlsStateCopyWith<CallControlsState> get copyWith => _$CallControlsStateCopyWithImpl<CallControlsState>(this as CallControlsState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CallControlsState'))
    ..add(DiagnosticsProperty('isMuted', isMuted))..add(DiagnosticsProperty('isVideoEnabled', isVideoEnabled))..add(DiagnosticsProperty('isSpeakerOn', isSpeakerOn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallControlsState&&(identical(other.isMuted, isMuted) || other.isMuted == isMuted)&&(identical(other.isVideoEnabled, isVideoEnabled) || other.isVideoEnabled == isVideoEnabled)&&(identical(other.isSpeakerOn, isSpeakerOn) || other.isSpeakerOn == isSpeakerOn));
}


@override
int get hashCode => Object.hash(runtimeType,isMuted,isVideoEnabled,isSpeakerOn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CallControlsState(isMuted: $isMuted, isVideoEnabled: $isVideoEnabled, isSpeakerOn: $isSpeakerOn)';
}


}

/// @nodoc
abstract mixin class $CallControlsStateCopyWith<$Res>  {
  factory $CallControlsStateCopyWith(CallControlsState value, $Res Function(CallControlsState) _then) = _$CallControlsStateCopyWithImpl;
@useResult
$Res call({
 bool isMuted, bool isVideoEnabled, bool isSpeakerOn
});




}
/// @nodoc
class _$CallControlsStateCopyWithImpl<$Res>
    implements $CallControlsStateCopyWith<$Res> {
  _$CallControlsStateCopyWithImpl(this._self, this._then);

  final CallControlsState _self;
  final $Res Function(CallControlsState) _then;

/// Create a copy of CallControlsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isMuted = null,Object? isVideoEnabled = null,Object? isSpeakerOn = null,}) {
  return _then(_self.copyWith(
isMuted: null == isMuted ? _self.isMuted : isMuted // ignore: cast_nullable_to_non_nullable
as bool,isVideoEnabled: null == isVideoEnabled ? _self.isVideoEnabled : isVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,isSpeakerOn: null == isSpeakerOn ? _self.isSpeakerOn : isSpeakerOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CallControlsState].
extension CallControlsStatePatterns on CallControlsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallControlsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallControlsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallControlsState value)  $default,){
final _that = this;
switch (_that) {
case _CallControlsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallControlsState value)?  $default,){
final _that = this;
switch (_that) {
case _CallControlsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isMuted,  bool isVideoEnabled,  bool isSpeakerOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallControlsState() when $default != null:
return $default(_that.isMuted,_that.isVideoEnabled,_that.isSpeakerOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isMuted,  bool isVideoEnabled,  bool isSpeakerOn)  $default,) {final _that = this;
switch (_that) {
case _CallControlsState():
return $default(_that.isMuted,_that.isVideoEnabled,_that.isSpeakerOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isMuted,  bool isVideoEnabled,  bool isSpeakerOn)?  $default,) {final _that = this;
switch (_that) {
case _CallControlsState() when $default != null:
return $default(_that.isMuted,_that.isVideoEnabled,_that.isSpeakerOn);case _:
  return null;

}
}

}

/// @nodoc


class _CallControlsState with DiagnosticableTreeMixin implements CallControlsState {
  const _CallControlsState({this.isMuted = false, this.isVideoEnabled = true, this.isSpeakerOn = true});
  

/// Whether the microphone is muted
@override@JsonKey() final  bool isMuted;
/// Whether the video is enabled (for video calls)
@override@JsonKey() final  bool isVideoEnabled;
/// Whether the speaker is on (true) or earpiece (false)
@override@JsonKey() final  bool isSpeakerOn;

/// Create a copy of CallControlsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallControlsStateCopyWith<_CallControlsState> get copyWith => __$CallControlsStateCopyWithImpl<_CallControlsState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'CallControlsState'))
    ..add(DiagnosticsProperty('isMuted', isMuted))..add(DiagnosticsProperty('isVideoEnabled', isVideoEnabled))..add(DiagnosticsProperty('isSpeakerOn', isSpeakerOn));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallControlsState&&(identical(other.isMuted, isMuted) || other.isMuted == isMuted)&&(identical(other.isVideoEnabled, isVideoEnabled) || other.isVideoEnabled == isVideoEnabled)&&(identical(other.isSpeakerOn, isSpeakerOn) || other.isSpeakerOn == isSpeakerOn));
}


@override
int get hashCode => Object.hash(runtimeType,isMuted,isVideoEnabled,isSpeakerOn);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'CallControlsState(isMuted: $isMuted, isVideoEnabled: $isVideoEnabled, isSpeakerOn: $isSpeakerOn)';
}


}

/// @nodoc
abstract mixin class _$CallControlsStateCopyWith<$Res> implements $CallControlsStateCopyWith<$Res> {
  factory _$CallControlsStateCopyWith(_CallControlsState value, $Res Function(_CallControlsState) _then) = __$CallControlsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isMuted, bool isVideoEnabled, bool isSpeakerOn
});




}
/// @nodoc
class __$CallControlsStateCopyWithImpl<$Res>
    implements _$CallControlsStateCopyWith<$Res> {
  __$CallControlsStateCopyWithImpl(this._self, this._then);

  final _CallControlsState _self;
  final $Res Function(_CallControlsState) _then;

/// Create a copy of CallControlsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isMuted = null,Object? isVideoEnabled = null,Object? isSpeakerOn = null,}) {
  return _then(_CallControlsState(
isMuted: null == isMuted ? _self.isMuted : isMuted // ignore: cast_nullable_to_non_nullable
as bool,isVideoEnabled: null == isVideoEnabled ? _self.isVideoEnabled : isVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,isSpeakerOn: null == isSpeakerOn ? _self.isSpeakerOn : isSpeakerOn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
