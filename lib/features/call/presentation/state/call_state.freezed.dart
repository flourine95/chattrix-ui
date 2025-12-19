// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallState()';
}


}

/// @nodoc
class $CallStateCopyWith<$Res>  {
$CallStateCopyWith(CallState _, $Res Function(CallState) __);
}


/// Adds pattern-matching-related methods to [CallState].
extension CallStatePatterns on CallState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Idle value)?  idle,TResult Function( _Initiating value)?  initiating,TResult Function( _Ringing value)?  ringing,TResult Function( _Connecting value)?  connecting,TResult Function( _Connected value)?  connected,TResult Function( _Ended value)?  ended,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Initiating() when initiating != null:
return initiating(_that);case _Ringing() when ringing != null:
return ringing(_that);case _Connecting() when connecting != null:
return connecting(_that);case _Connected() when connected != null:
return connected(_that);case _Ended() when ended != null:
return ended(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Idle value)  idle,required TResult Function( _Initiating value)  initiating,required TResult Function( _Ringing value)  ringing,required TResult Function( _Connecting value)  connecting,required TResult Function( _Connected value)  connected,required TResult Function( _Ended value)  ended,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Idle():
return idle(_that);case _Initiating():
return initiating(_that);case _Ringing():
return ringing(_that);case _Connecting():
return connecting(_that);case _Connected():
return connected(_that);case _Ended():
return ended(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Idle value)?  idle,TResult? Function( _Initiating value)?  initiating,TResult? Function( _Ringing value)?  ringing,TResult? Function( _Connecting value)?  connecting,TResult? Function( _Connected value)?  connected,TResult? Function( _Ended value)?  ended,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle(_that);case _Initiating() when initiating != null:
return initiating(_that);case _Ringing() when ringing != null:
return ringing(_that);case _Connecting() when connecting != null:
return connecting(_that);case _Connected() when connected != null:
return connected(_that);case _Ended() when ended != null:
return ended(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( int calleeId,  CallType callType,  String? calleeName,  String? calleeAvatar)?  initiating,TResult Function( CallInvitation invitation)?  ringing,TResult Function( CallConnection connection,  CallType callType,  bool isOutgoing)?  connecting,TResult Function( CallConnection connection,  CallType callType,  bool isOutgoing,  bool isMuted,  bool isVideoEnabled,  bool isSpeakerEnabled,  bool isFrontCamera,  int? remoteUid,  bool remoteIsMuted,  bool remoteIsVideoEnabled)?  connected,TResult Function( String? reason)?  ended,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Initiating() when initiating != null:
return initiating(_that.calleeId,_that.callType,_that.calleeName,_that.calleeAvatar);case _Ringing() when ringing != null:
return ringing(_that.invitation);case _Connecting() when connecting != null:
return connecting(_that.connection,_that.callType,_that.isOutgoing);case _Connected() when connected != null:
return connected(_that.connection,_that.callType,_that.isOutgoing,_that.isMuted,_that.isVideoEnabled,_that.isSpeakerEnabled,_that.isFrontCamera,_that.remoteUid,_that.remoteIsMuted,_that.remoteIsVideoEnabled);case _Ended() when ended != null:
return ended(_that.reason);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( int calleeId,  CallType callType,  String? calleeName,  String? calleeAvatar)  initiating,required TResult Function( CallInvitation invitation)  ringing,required TResult Function( CallConnection connection,  CallType callType,  bool isOutgoing)  connecting,required TResult Function( CallConnection connection,  CallType callType,  bool isOutgoing,  bool isMuted,  bool isVideoEnabled,  bool isSpeakerEnabled,  bool isFrontCamera,  int? remoteUid,  bool remoteIsMuted,  bool remoteIsVideoEnabled)  connected,required TResult Function( String? reason)  ended,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Idle():
return idle();case _Initiating():
return initiating(_that.calleeId,_that.callType,_that.calleeName,_that.calleeAvatar);case _Ringing():
return ringing(_that.invitation);case _Connecting():
return connecting(_that.connection,_that.callType,_that.isOutgoing);case _Connected():
return connected(_that.connection,_that.callType,_that.isOutgoing,_that.isMuted,_that.isVideoEnabled,_that.isSpeakerEnabled,_that.isFrontCamera,_that.remoteUid,_that.remoteIsMuted,_that.remoteIsVideoEnabled);case _Ended():
return ended(_that.reason);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( int calleeId,  CallType callType,  String? calleeName,  String? calleeAvatar)?  initiating,TResult? Function( CallInvitation invitation)?  ringing,TResult? Function( CallConnection connection,  CallType callType,  bool isOutgoing)?  connecting,TResult? Function( CallConnection connection,  CallType callType,  bool isOutgoing,  bool isMuted,  bool isVideoEnabled,  bool isSpeakerEnabled,  bool isFrontCamera,  int? remoteUid,  bool remoteIsMuted,  bool remoteIsVideoEnabled)?  connected,TResult? Function( String? reason)?  ended,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Idle() when idle != null:
return idle();case _Initiating() when initiating != null:
return initiating(_that.calleeId,_that.callType,_that.calleeName,_that.calleeAvatar);case _Ringing() when ringing != null:
return ringing(_that.invitation);case _Connecting() when connecting != null:
return connecting(_that.connection,_that.callType,_that.isOutgoing);case _Connected() when connected != null:
return connected(_that.connection,_that.callType,_that.isOutgoing,_that.isMuted,_that.isVideoEnabled,_that.isSpeakerEnabled,_that.isFrontCamera,_that.remoteUid,_that.remoteIsMuted,_that.remoteIsVideoEnabled);case _Ended() when ended != null:
return ended(_that.reason);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Idle extends CallState {
  const _Idle(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Idle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallState.idle()';
}


}




/// @nodoc


class _Initiating extends CallState {
  const _Initiating({required this.calleeId, required this.callType, this.calleeName, this.calleeAvatar}): super._();
  

 final  int calleeId;
 final  CallType callType;
 final  String? calleeName;
 final  String? calleeAvatar;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitiatingCopyWith<_Initiating> get copyWith => __$InitiatingCopyWithImpl<_Initiating>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initiating&&(identical(other.calleeId, calleeId) || other.calleeId == calleeId)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.calleeName, calleeName) || other.calleeName == calleeName)&&(identical(other.calleeAvatar, calleeAvatar) || other.calleeAvatar == calleeAvatar));
}


@override
int get hashCode => Object.hash(runtimeType,calleeId,callType,calleeName,calleeAvatar);

@override
String toString() {
  return 'CallState.initiating(calleeId: $calleeId, callType: $callType, calleeName: $calleeName, calleeAvatar: $calleeAvatar)';
}


}

/// @nodoc
abstract mixin class _$InitiatingCopyWith<$Res> implements $CallStateCopyWith<$Res> {
  factory _$InitiatingCopyWith(_Initiating value, $Res Function(_Initiating) _then) = __$InitiatingCopyWithImpl;
@useResult
$Res call({
 int calleeId, CallType callType, String? calleeName, String? calleeAvatar
});




}
/// @nodoc
class __$InitiatingCopyWithImpl<$Res>
    implements _$InitiatingCopyWith<$Res> {
  __$InitiatingCopyWithImpl(this._self, this._then);

  final _Initiating _self;
  final $Res Function(_Initiating) _then;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? calleeId = null,Object? callType = null,Object? calleeName = freezed,Object? calleeAvatar = freezed,}) {
  return _then(_Initiating(
calleeId: null == calleeId ? _self.calleeId : calleeId // ignore: cast_nullable_to_non_nullable
as int,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,calleeName: freezed == calleeName ? _self.calleeName : calleeName // ignore: cast_nullable_to_non_nullable
as String?,calleeAvatar: freezed == calleeAvatar ? _self.calleeAvatar : calleeAvatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Ringing extends CallState {
  const _Ringing({required this.invitation}): super._();
  

 final  CallInvitation invitation;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RingingCopyWith<_Ringing> get copyWith => __$RingingCopyWithImpl<_Ringing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ringing&&(identical(other.invitation, invitation) || other.invitation == invitation));
}


@override
int get hashCode => Object.hash(runtimeType,invitation);

@override
String toString() {
  return 'CallState.ringing(invitation: $invitation)';
}


}

/// @nodoc
abstract mixin class _$RingingCopyWith<$Res> implements $CallStateCopyWith<$Res> {
  factory _$RingingCopyWith(_Ringing value, $Res Function(_Ringing) _then) = __$RingingCopyWithImpl;
@useResult
$Res call({
 CallInvitation invitation
});


$CallInvitationCopyWith<$Res> get invitation;

}
/// @nodoc
class __$RingingCopyWithImpl<$Res>
    implements _$RingingCopyWith<$Res> {
  __$RingingCopyWithImpl(this._self, this._then);

  final _Ringing _self;
  final $Res Function(_Ringing) _then;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invitation = null,}) {
  return _then(_Ringing(
invitation: null == invitation ? _self.invitation : invitation // ignore: cast_nullable_to_non_nullable
as CallInvitation,
  ));
}

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallInvitationCopyWith<$Res> get invitation {
  
  return $CallInvitationCopyWith<$Res>(_self.invitation, (value) {
    return _then(_self.copyWith(invitation: value));
  });
}
}

/// @nodoc


class _Connecting extends CallState {
  const _Connecting({required this.connection, required this.callType, required this.isOutgoing}): super._();
  

 final  CallConnection connection;
 final  CallType callType;
 final  bool isOutgoing;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectingCopyWith<_Connecting> get copyWith => __$ConnectingCopyWithImpl<_Connecting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Connecting&&(identical(other.connection, connection) || other.connection == connection)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.isOutgoing, isOutgoing) || other.isOutgoing == isOutgoing));
}


@override
int get hashCode => Object.hash(runtimeType,connection,callType,isOutgoing);

@override
String toString() {
  return 'CallState.connecting(connection: $connection, callType: $callType, isOutgoing: $isOutgoing)';
}


}

/// @nodoc
abstract mixin class _$ConnectingCopyWith<$Res> implements $CallStateCopyWith<$Res> {
  factory _$ConnectingCopyWith(_Connecting value, $Res Function(_Connecting) _then) = __$ConnectingCopyWithImpl;
@useResult
$Res call({
 CallConnection connection, CallType callType, bool isOutgoing
});


$CallConnectionCopyWith<$Res> get connection;

}
/// @nodoc
class __$ConnectingCopyWithImpl<$Res>
    implements _$ConnectingCopyWith<$Res> {
  __$ConnectingCopyWithImpl(this._self, this._then);

  final _Connecting _self;
  final $Res Function(_Connecting) _then;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? connection = null,Object? callType = null,Object? isOutgoing = null,}) {
  return _then(_Connecting(
connection: null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as CallConnection,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,isOutgoing: null == isOutgoing ? _self.isOutgoing : isOutgoing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallConnectionCopyWith<$Res> get connection {
  
  return $CallConnectionCopyWith<$Res>(_self.connection, (value) {
    return _then(_self.copyWith(connection: value));
  });
}
}

/// @nodoc


class _Connected extends CallState {
  const _Connected({required this.connection, required this.callType, required this.isOutgoing, required this.isMuted, required this.isVideoEnabled, required this.isSpeakerEnabled, required this.isFrontCamera, this.remoteUid, this.remoteIsMuted = false, this.remoteIsVideoEnabled = true}): super._();
  

 final  CallConnection connection;
 final  CallType callType;
 final  bool isOutgoing;
 final  bool isMuted;
 final  bool isVideoEnabled;
 final  bool isSpeakerEnabled;
 final  bool isFrontCamera;
 final  int? remoteUid;
@JsonKey() final  bool remoteIsMuted;
@JsonKey() final  bool remoteIsVideoEnabled;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectedCopyWith<_Connected> get copyWith => __$ConnectedCopyWithImpl<_Connected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Connected&&(identical(other.connection, connection) || other.connection == connection)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.isOutgoing, isOutgoing) || other.isOutgoing == isOutgoing)&&(identical(other.isMuted, isMuted) || other.isMuted == isMuted)&&(identical(other.isVideoEnabled, isVideoEnabled) || other.isVideoEnabled == isVideoEnabled)&&(identical(other.isSpeakerEnabled, isSpeakerEnabled) || other.isSpeakerEnabled == isSpeakerEnabled)&&(identical(other.isFrontCamera, isFrontCamera) || other.isFrontCamera == isFrontCamera)&&(identical(other.remoteUid, remoteUid) || other.remoteUid == remoteUid)&&(identical(other.remoteIsMuted, remoteIsMuted) || other.remoteIsMuted == remoteIsMuted)&&(identical(other.remoteIsVideoEnabled, remoteIsVideoEnabled) || other.remoteIsVideoEnabled == remoteIsVideoEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,connection,callType,isOutgoing,isMuted,isVideoEnabled,isSpeakerEnabled,isFrontCamera,remoteUid,remoteIsMuted,remoteIsVideoEnabled);

@override
String toString() {
  return 'CallState.connected(connection: $connection, callType: $callType, isOutgoing: $isOutgoing, isMuted: $isMuted, isVideoEnabled: $isVideoEnabled, isSpeakerEnabled: $isSpeakerEnabled, isFrontCamera: $isFrontCamera, remoteUid: $remoteUid, remoteIsMuted: $remoteIsMuted, remoteIsVideoEnabled: $remoteIsVideoEnabled)';
}


}

/// @nodoc
abstract mixin class _$ConnectedCopyWith<$Res> implements $CallStateCopyWith<$Res> {
  factory _$ConnectedCopyWith(_Connected value, $Res Function(_Connected) _then) = __$ConnectedCopyWithImpl;
@useResult
$Res call({
 CallConnection connection, CallType callType, bool isOutgoing, bool isMuted, bool isVideoEnabled, bool isSpeakerEnabled, bool isFrontCamera, int? remoteUid, bool remoteIsMuted, bool remoteIsVideoEnabled
});


$CallConnectionCopyWith<$Res> get connection;

}
/// @nodoc
class __$ConnectedCopyWithImpl<$Res>
    implements _$ConnectedCopyWith<$Res> {
  __$ConnectedCopyWithImpl(this._self, this._then);

  final _Connected _self;
  final $Res Function(_Connected) _then;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? connection = null,Object? callType = null,Object? isOutgoing = null,Object? isMuted = null,Object? isVideoEnabled = null,Object? isSpeakerEnabled = null,Object? isFrontCamera = null,Object? remoteUid = freezed,Object? remoteIsMuted = null,Object? remoteIsVideoEnabled = null,}) {
  return _then(_Connected(
connection: null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as CallConnection,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as CallType,isOutgoing: null == isOutgoing ? _self.isOutgoing : isOutgoing // ignore: cast_nullable_to_non_nullable
as bool,isMuted: null == isMuted ? _self.isMuted : isMuted // ignore: cast_nullable_to_non_nullable
as bool,isVideoEnabled: null == isVideoEnabled ? _self.isVideoEnabled : isVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,isSpeakerEnabled: null == isSpeakerEnabled ? _self.isSpeakerEnabled : isSpeakerEnabled // ignore: cast_nullable_to_non_nullable
as bool,isFrontCamera: null == isFrontCamera ? _self.isFrontCamera : isFrontCamera // ignore: cast_nullable_to_non_nullable
as bool,remoteUid: freezed == remoteUid ? _self.remoteUid : remoteUid // ignore: cast_nullable_to_non_nullable
as int?,remoteIsMuted: null == remoteIsMuted ? _self.remoteIsMuted : remoteIsMuted // ignore: cast_nullable_to_non_nullable
as bool,remoteIsVideoEnabled: null == remoteIsVideoEnabled ? _self.remoteIsVideoEnabled : remoteIsVideoEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CallConnectionCopyWith<$Res> get connection {
  
  return $CallConnectionCopyWith<$Res>(_self.connection, (value) {
    return _then(_self.copyWith(connection: value));
  });
}
}

/// @nodoc


class _Ended extends CallState {
  const _Ended({this.reason}): super._();
  

 final  String? reason;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EndedCopyWith<_Ended> get copyWith => __$EndedCopyWithImpl<_Ended>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ended&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'CallState.ended(reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$EndedCopyWith<$Res> implements $CallStateCopyWith<$Res> {
  factory _$EndedCopyWith(_Ended value, $Res Function(_Ended) _then) = __$EndedCopyWithImpl;
@useResult
$Res call({
 String? reason
});




}
/// @nodoc
class __$EndedCopyWithImpl<$Res>
    implements _$EndedCopyWith<$Res> {
  __$EndedCopyWithImpl(this._self, this._then);

  final _Ended _self;
  final $Res Function(_Ended) _then;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = freezed,}) {
  return _then(_Ended(
reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _Error extends CallState {
  const _Error({required this.message}): super._();
  

 final  String message;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CallState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $CallStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
