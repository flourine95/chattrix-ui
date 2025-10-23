// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserStatus {

  int get userId;

  bool get isOnline;

  int get activeSessionCount;

  /// Create a copy of UserStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserStatusCopyWith<UserStatus> get copyWith =>
      _$UserStatusCopyWithImpl<UserStatus>(this as UserStatus, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UserStatus &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.activeSessionCount, activeSessionCount) ||
                other.activeSessionCount == activeSessionCount));
  }


  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, isOnline, activeSessionCount);

  @override
  String toString() {
    return 'UserStatus(userId: $userId, isOnline: $isOnline, activeSessionCount: $activeSessionCount)';
  }


}

/// @nodoc
abstract mixin class $UserStatusCopyWith<$Res> {
  factory $UserStatusCopyWith(UserStatus value,
      $Res Function(UserStatus) _then) = _$UserStatusCopyWithImpl;

  @useResult
  $Res call({
    int userId, bool isOnline, int activeSessionCount
  });


}

/// @nodoc
class _$UserStatusCopyWithImpl<$Res>
    implements $UserStatusCopyWith<$Res> {
  _$UserStatusCopyWithImpl(this._self, this._then);

  final UserStatus _self;
  final $Res Function(UserStatus) _then;

  /// Create a copy of UserStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? userId = null, Object? isOnline = null, Object? activeSessionCount = null,}) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
      as int,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
      as bool,
      activeSessionCount: null == activeSessionCount
          ? _self.activeSessionCount
          : activeSessionCount // ignore: cast_nullable_to_non_nullable
      as int,
    ));
  }

}


/// Adds pattern-matching-related methods to [UserStatus].
extension UserStatusPatterns on UserStatus {
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

  @optionalTypeArgs TResult maybeMap

  <

  TResult

  extends

  Object?

  >

  (

  TResult Function( _UserStatus value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _UserStatus() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserStatus value) $default,){
  final _that = this;
  switch (_that) {
  case _UserStatus():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserStatus value)? $default,){
  final _that = this;
  switch (_that) {
  case _UserStatus() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId, bool isOnline, int activeSessionCount)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _UserStatus() when $default != null:
  return $default(_that.userId,_that.isOnline,_that.activeSessionCount);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId, bool isOnline, int activeSessionCount) $default,) {final _that = this;
  switch (_that) {
  case _UserStatus():
  return $default(_that.userId,_that.isOnline,_that.activeSessionCount);case _:
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId, bool isOnline, int activeSessionCount)? $default,) {final _that = this;
  switch (_that) {
  case _UserStatus() when $default != null:
  return $default(_that.userId,_that.isOnline,_that.activeSessionCount);case _:
  return null;

  }
  }

}

/// @nodoc


class _UserStatus implements UserStatus {
  const _UserStatus(
      {required this.userId, required this.isOnline, required this.activeSessionCount});


  @override final int userId;
  @override final bool isOnline;
  @override final int activeSessionCount;

  /// Create a copy of UserStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserStatusCopyWith<_UserStatus> get copyWith =>
      __$UserStatusCopyWithImpl<_UserStatus>(this, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _UserStatus &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.activeSessionCount, activeSessionCount) ||
                other.activeSessionCount == activeSessionCount));
  }


  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, isOnline, activeSessionCount);

  @override
  String toString() {
    return 'UserStatus(userId: $userId, isOnline: $isOnline, activeSessionCount: $activeSessionCount)';
  }


}

/// @nodoc
abstract mixin class _$UserStatusCopyWith<$Res>
    implements $UserStatusCopyWith<$Res> {
  factory _$UserStatusCopyWith(_UserStatus value,
      $Res Function(_UserStatus) _then) = __$UserStatusCopyWithImpl;

  @override
  @useResult
  $Res call({
    int userId, bool isOnline, int activeSessionCount
  });


}

/// @nodoc
class __$UserStatusCopyWithImpl<$Res>
    implements _$UserStatusCopyWith<$Res> {
  __$UserStatusCopyWithImpl(this._self, this._then);

  final _UserStatus _self;
  final $Res Function(_UserStatus) _then;

  /// Create a copy of UserStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? userId = null, Object? isOnline = null, Object? activeSessionCount = null,}) {
    return _then(_UserStatus(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
      as int,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
      as bool,
      activeSessionCount: null == activeSessionCount
          ? _self.activeSessionCount
          : activeSessionCount // ignore: cast_nullable_to_non_nullable
      as int,
    ));
  }


}

// dart format on
