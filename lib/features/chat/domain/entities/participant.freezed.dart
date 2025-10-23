// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'participant.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Participant {

  int get userId;

  String get username;

  String get fullName;

  String get role; // 'ADMIN' or 'MEMBER'
  String? get email;

  String? get nickname;

  bool? get isOnline;

  DateTime? get lastSeen;

  /// Create a copy of Participant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParticipantCopyWith<Participant> get copyWith =>
      _$ParticipantCopyWithImpl<Participant>(this as Participant, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Participant &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }


  @override
  int get hashCode =>
      Object.hash(
          runtimeType,
          userId,
          username,
          fullName,
          role,
          email,
          nickname,
          isOnline,
          lastSeen);

  @override
  String toString() {
    return 'Participant(userId: $userId, username: $username, fullName: $fullName, role: $role, email: $email, nickname: $nickname, isOnline: $isOnline, lastSeen: $lastSeen)';
  }


}

/// @nodoc
abstract mixin class $ParticipantCopyWith<$Res> {
  factory $ParticipantCopyWith(Participant value,
      $Res Function(Participant) _then) = _$ParticipantCopyWithImpl;

  @useResult
  $Res call({
    int userId, String username, String fullName, String role, String? email, String? nickname, bool? isOnline, DateTime? lastSeen
  });


}

/// @nodoc
class _$ParticipantCopyWithImpl<$Res>
    implements $ParticipantCopyWith<$Res> {
  _$ParticipantCopyWithImpl(this._self, this._then);

  final Participant _self;
  final $Res Function(Participant) _then;

  /// Create a copy of Participant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? userId = null, Object? username = null, Object? fullName = null, Object? role = null, Object? email = freezed, Object? nickname = freezed, Object? isOnline = freezed, Object? lastSeen = freezed,}) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
      as int,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
      as String,
      fullName: null == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
      as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
      as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
      as String?,
      nickname: freezed == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
      as String?,
      isOnline: freezed == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
      as bool?,
      lastSeen: freezed == lastSeen
          ? _self.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
      as DateTime?,
    ));
  }

}


/// Adds pattern-matching-related methods to [Participant].
extension ParticipantPatterns on Participant {
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

  TResult Function( _Participant value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _Participant() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Participant value) $default,){
  final _that = this;
  switch (_that) {
  case _Participant():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Participant value)? $default,){
  final _that = this;
  switch (_that) {
  case _Participant() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId, String username, String fullName, String role, String? email, String? nickname, bool? isOnline, DateTime? lastSeen)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _Participant() when $default != null:
  return $default(_that.userId,_that.username,_that.fullName,_that.role,_that.email,_that.nickname,_that.isOnline,_that.lastSeen);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId, String username, String fullName, String role, String? email, String? nickname, bool? isOnline, DateTime? lastSeen) $default,) {final _that = this;
  switch (_that) {
  case _Participant():
  return $default(_that.userId,_that.username,_that.fullName,_that.role,_that.email,_that.nickname,_that.isOnline,_that.lastSeen);case _:
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId, String username, String fullName, String role, String? email, String? nickname, bool? isOnline, DateTime? lastSeen)? $default,) {final _that = this;
  switch (_that) {
  case _Participant() when $default != null:
  return $default(_that.userId,_that.username,_that.fullName,_that.role,_that.email,_that.nickname,_that.isOnline,_that.lastSeen);case _:
  return null;

  }
  }

}

/// @nodoc


class _Participant implements Participant {
  const _Participant(
      {required this.userId, required this.username, required this.fullName, required this.role, this.email, this.nickname, this.isOnline, this.lastSeen});


  @override final int userId;
  @override final String username;
  @override final String fullName;
  @override final String role;

// 'ADMIN' or 'MEMBER'
  @override final String? email;
  @override final String? nickname;
  @override final bool? isOnline;
  @override final DateTime? lastSeen;

  /// Create a copy of Participant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ParticipantCopyWith<_Participant> get copyWith =>
      __$ParticipantCopyWithImpl<_Participant>(this, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Participant &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }


  @override
  int get hashCode =>
      Object.hash(
          runtimeType,
          userId,
          username,
          fullName,
          role,
          email,
          nickname,
          isOnline,
          lastSeen);

  @override
  String toString() {
    return 'Participant(userId: $userId, username: $username, fullName: $fullName, role: $role, email: $email, nickname: $nickname, isOnline: $isOnline, lastSeen: $lastSeen)';
  }


}

/// @nodoc
abstract mixin class _$ParticipantCopyWith<$Res>
    implements $ParticipantCopyWith<$Res> {
  factory _$ParticipantCopyWith(_Participant value,
      $Res Function(_Participant) _then) = __$ParticipantCopyWithImpl;

  @override
  @useResult
  $Res call({
    int userId, String username, String fullName, String role, String? email, String? nickname, bool? isOnline, DateTime? lastSeen
  });


}

/// @nodoc
class __$ParticipantCopyWithImpl<$Res>
    implements _$ParticipantCopyWith<$Res> {
  __$ParticipantCopyWithImpl(this._self, this._then);

  final _Participant _self;
  final $Res Function(_Participant) _then;

  /// Create a copy of Participant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? userId = null, Object? username = null, Object? fullName = null, Object? role = null, Object? email = freezed, Object? nickname = freezed, Object? isOnline = freezed, Object? lastSeen = freezed,}) {
    return _then(_Participant(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
      as int,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
      as String,
      fullName: null == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
      as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
      as String,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
      as String?,
      nickname: freezed == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
      as String?,
      isOnline: freezed == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
      as bool?,
      lastSeen: freezed == lastSeen
          ? _self.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
      as DateTime?,
    ));
  }


}

// dart format on
