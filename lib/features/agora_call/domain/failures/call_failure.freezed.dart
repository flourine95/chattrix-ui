// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallFailure()';
}


}

/// @nodoc
class $CallFailureCopyWith<$Res>  {
$CallFailureCopyWith(CallFailure _, $Res Function(CallFailure) __);
}


/// Adds pattern-matching-related methods to [CallFailure].
extension CallFailurePatterns on CallFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServerError value)?  serverError,TResult Function( NetworkError value)?  networkError,TResult Function( UserBusy value)?  userBusy,TResult Function( CallNotFound value)?  callNotFound,TResult Function( PermissionDenied value)?  permissionDenied,TResult Function( AgoraError value)?  agoraError,TResult Function( Unauthorized value)?  unauthorized,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServerError() when serverError != null:
return serverError(_that);case NetworkError() when networkError != null:
return networkError(_that);case UserBusy() when userBusy != null:
return userBusy(_that);case CallNotFound() when callNotFound != null:
return callNotFound(_that);case PermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case AgoraError() when agoraError != null:
return agoraError(_that);case Unauthorized() when unauthorized != null:
return unauthorized(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServerError value)  serverError,required TResult Function( NetworkError value)  networkError,required TResult Function( UserBusy value)  userBusy,required TResult Function( CallNotFound value)  callNotFound,required TResult Function( PermissionDenied value)  permissionDenied,required TResult Function( AgoraError value)  agoraError,required TResult Function( Unauthorized value)  unauthorized,}){
final _that = this;
switch (_that) {
case ServerError():
return serverError(_that);case NetworkError():
return networkError(_that);case UserBusy():
return userBusy(_that);case CallNotFound():
return callNotFound(_that);case PermissionDenied():
return permissionDenied(_that);case AgoraError():
return agoraError(_that);case Unauthorized():
return unauthorized(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServerError value)?  serverError,TResult? Function( NetworkError value)?  networkError,TResult? Function( UserBusy value)?  userBusy,TResult? Function( CallNotFound value)?  callNotFound,TResult? Function( PermissionDenied value)?  permissionDenied,TResult? Function( AgoraError value)?  agoraError,TResult? Function( Unauthorized value)?  unauthorized,}){
final _that = this;
switch (_that) {
case ServerError() when serverError != null:
return serverError(_that);case NetworkError() when networkError != null:
return networkError(_that);case UserBusy() when userBusy != null:
return userBusy(_that);case CallNotFound() when callNotFound != null:
return callNotFound(_that);case PermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case AgoraError() when agoraError != null:
return agoraError(_that);case Unauthorized() when unauthorized != null:
return unauthorized(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  serverError,TResult Function()?  networkError,TResult Function()?  userBusy,TResult Function()?  callNotFound,TResult Function( String permission)?  permissionDenied,TResult Function( String message)?  agoraError,TResult Function()?  unauthorized,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServerError() when serverError != null:
return serverError(_that.message);case NetworkError() when networkError != null:
return networkError();case UserBusy() when userBusy != null:
return userBusy();case CallNotFound() when callNotFound != null:
return callNotFound();case PermissionDenied() when permissionDenied != null:
return permissionDenied(_that.permission);case AgoraError() when agoraError != null:
return agoraError(_that.message);case Unauthorized() when unauthorized != null:
return unauthorized();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  serverError,required TResult Function()  networkError,required TResult Function()  userBusy,required TResult Function()  callNotFound,required TResult Function( String permission)  permissionDenied,required TResult Function( String message)  agoraError,required TResult Function()  unauthorized,}) {final _that = this;
switch (_that) {
case ServerError():
return serverError(_that.message);case NetworkError():
return networkError();case UserBusy():
return userBusy();case CallNotFound():
return callNotFound();case PermissionDenied():
return permissionDenied(_that.permission);case AgoraError():
return agoraError(_that.message);case Unauthorized():
return unauthorized();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  serverError,TResult? Function()?  networkError,TResult? Function()?  userBusy,TResult? Function()?  callNotFound,TResult? Function( String permission)?  permissionDenied,TResult? Function( String message)?  agoraError,TResult? Function()?  unauthorized,}) {final _that = this;
switch (_that) {
case ServerError() when serverError != null:
return serverError(_that.message);case NetworkError() when networkError != null:
return networkError();case UserBusy() when userBusy != null:
return userBusy();case CallNotFound() when callNotFound != null:
return callNotFound();case PermissionDenied() when permissionDenied != null:
return permissionDenied(_that.permission);case AgoraError() when agoraError != null:
return agoraError(_that.message);case Unauthorized() when unauthorized != null:
return unauthorized();case _:
  return null;

}
}

}

/// @nodoc


class ServerError implements CallFailure {
  const ServerError(this.message);
  

 final  String message;

/// Create a copy of CallFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerErrorCopyWith<ServerError> get copyWith => _$ServerErrorCopyWithImpl<ServerError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CallFailure.serverError(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerErrorCopyWith<$Res> implements $CallFailureCopyWith<$Res> {
  factory $ServerErrorCopyWith(ServerError value, $Res Function(ServerError) _then) = _$ServerErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ServerErrorCopyWithImpl<$Res>
    implements $ServerErrorCopyWith<$Res> {
  _$ServerErrorCopyWithImpl(this._self, this._then);

  final ServerError _self;
  final $Res Function(ServerError) _then;

/// Create a copy of CallFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServerError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class NetworkError implements CallFailure {
  const NetworkError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallFailure.networkError()';
}


}




/// @nodoc


class UserBusy implements CallFailure {
  const UserBusy();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserBusy);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallFailure.userBusy()';
}


}




/// @nodoc


class CallNotFound implements CallFailure {
  const CallNotFound();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallNotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallFailure.callNotFound()';
}


}




/// @nodoc


class PermissionDenied implements CallFailure {
  const PermissionDenied(this.permission);
  

 final  String permission;

/// Create a copy of CallFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PermissionDeniedCopyWith<PermissionDenied> get copyWith => _$PermissionDeniedCopyWithImpl<PermissionDenied>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PermissionDenied&&(identical(other.permission, permission) || other.permission == permission));
}


@override
int get hashCode => Object.hash(runtimeType,permission);

@override
String toString() {
  return 'CallFailure.permissionDenied(permission: $permission)';
}


}

/// @nodoc
abstract mixin class $PermissionDeniedCopyWith<$Res> implements $CallFailureCopyWith<$Res> {
  factory $PermissionDeniedCopyWith(PermissionDenied value, $Res Function(PermissionDenied) _then) = _$PermissionDeniedCopyWithImpl;
@useResult
$Res call({
 String permission
});




}
/// @nodoc
class _$PermissionDeniedCopyWithImpl<$Res>
    implements $PermissionDeniedCopyWith<$Res> {
  _$PermissionDeniedCopyWithImpl(this._self, this._then);

  final PermissionDenied _self;
  final $Res Function(PermissionDenied) _then;

/// Create a copy of CallFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? permission = null,}) {
  return _then(PermissionDenied(
null == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AgoraError implements CallFailure {
  const AgoraError(this.message);
  

 final  String message;

/// Create a copy of CallFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgoraErrorCopyWith<AgoraError> get copyWith => _$AgoraErrorCopyWithImpl<AgoraError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgoraError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CallFailure.agoraError(message: $message)';
}


}

/// @nodoc
abstract mixin class $AgoraErrorCopyWith<$Res> implements $CallFailureCopyWith<$Res> {
  factory $AgoraErrorCopyWith(AgoraError value, $Res Function(AgoraError) _then) = _$AgoraErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AgoraErrorCopyWithImpl<$Res>
    implements $AgoraErrorCopyWith<$Res> {
  _$AgoraErrorCopyWithImpl(this._self, this._then);

  final AgoraError _self;
  final $Res Function(AgoraError) _then;

/// Create a copy of CallFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AgoraError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Unauthorized implements CallFailure {
  const Unauthorized();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Unauthorized);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CallFailure.unauthorized()';
}


}




// dart format on
