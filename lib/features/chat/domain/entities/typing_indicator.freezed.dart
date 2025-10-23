// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'typing_indicator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TypingIndicator {

  String get conversationId;

  List<TypingUser> get typingUsers;

  /// Create a copy of TypingIndicator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TypingIndicatorCopyWith<TypingIndicator> get copyWith =>
      _$TypingIndicatorCopyWithImpl<TypingIndicator>(
          this as TypingIndicator, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TypingIndicator &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            const DeepCollectionEquality().equals(
                other.typingUsers, typingUsers));
  }


  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId,
      const DeepCollectionEquality().hash(typingUsers));

  @override
  String toString() {
    return 'TypingIndicator(conversationId: $conversationId, typingUsers: $typingUsers)';
  }


}

/// @nodoc
abstract mixin class $TypingIndicatorCopyWith<$Res> {
  factory $TypingIndicatorCopyWith(TypingIndicator value,
      $Res Function(TypingIndicator) _then) = _$TypingIndicatorCopyWithImpl;

  @useResult
  $Res call({
    String conversationId, List<TypingUser> typingUsers
  });


}

/// @nodoc
class _$TypingIndicatorCopyWithImpl<$Res>
    implements $TypingIndicatorCopyWith<$Res> {
  _$TypingIndicatorCopyWithImpl(this._self, this._then);

  final TypingIndicator _self;
  final $Res Function(TypingIndicator) _then;

  /// Create a copy of TypingIndicator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversationId = null, Object? typingUsers = null,}) {
    return _then(_self.copyWith(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
      as String,
      typingUsers: null == typingUsers
          ? _self.typingUsers
          : typingUsers // ignore: cast_nullable_to_non_nullable
      as List<TypingUser>,
    ));
  }

}


/// Adds pattern-matching-related methods to [TypingIndicator].
extension TypingIndicatorPatterns on TypingIndicator {
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

  TResult Function( _TypingIndicator value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _TypingIndicator() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TypingIndicator value) $default,){
  final _that = this;
  switch (_that) {
  case _TypingIndicator():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TypingIndicator value)? $default,){
  final _that = this;
  switch (_that) {
  case _TypingIndicator() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String conversationId, List<TypingUser> typingUsers)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _TypingIndicator() when $default != null:
  return $default(_that.conversationId,_that.typingUsers);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String conversationId, List<TypingUser> typingUsers) $default,) {final _that = this;
  switch (_that) {
  case _TypingIndicator():
  return $default(_that.conversationId,_that.typingUsers);case _:
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String conversationId, List<TypingUser> typingUsers)? $default,) {final _that = this;
  switch (_that) {
  case _TypingIndicator() when $default != null:
  return $default(_that.conversationId,_that.typingUsers);case _:
  return null;

  }
  }

}

/// @nodoc


class _TypingIndicator extends TypingIndicator {
  const _TypingIndicator({required this.conversationId, required final List<
      TypingUser> typingUsers})
      : _typingUsers = typingUsers,
        super._();


  @override final String conversationId;
  final List<TypingUser> _typingUsers;

  @override List<TypingUser> get typingUsers {
    if (_typingUsers is EqualUnmodifiableListView) return _typingUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typingUsers);
  }


  /// Create a copy of TypingIndicator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypingIndicatorCopyWith<_TypingIndicator> get copyWith =>
      __$TypingIndicatorCopyWithImpl<_TypingIndicator>(this, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _TypingIndicator &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            const DeepCollectionEquality().equals(
                other._typingUsers, _typingUsers));
  }


  @override
  int get hashCode =>
      Object.hash(runtimeType, conversationId,
      const DeepCollectionEquality().hash(_typingUsers));

  @override
  String toString() {
    return 'TypingIndicator(conversationId: $conversationId, typingUsers: $typingUsers)';
  }


}

/// @nodoc
abstract mixin class _$TypingIndicatorCopyWith<$Res>
    implements $TypingIndicatorCopyWith<$Res> {
  factory _$TypingIndicatorCopyWith(_TypingIndicator value,
      $Res Function(_TypingIndicator) _then) = __$TypingIndicatorCopyWithImpl;

  @override
  @useResult
  $Res call({
    String conversationId, List<TypingUser> typingUsers
  });


}

/// @nodoc
class __$TypingIndicatorCopyWithImpl<$Res>
    implements _$TypingIndicatorCopyWith<$Res> {
  __$TypingIndicatorCopyWithImpl(this._self, this._then);

  final _TypingIndicator _self;
  final $Res Function(_TypingIndicator) _then;

  /// Create a copy of TypingIndicator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? conversationId = null, Object? typingUsers = null,}) {
    return _then(_TypingIndicator(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
      as String,
      typingUsers: null == typingUsers
          ? _self._typingUsers
          : typingUsers // ignore: cast_nullable_to_non_nullable
      as List<TypingUser>,
    ));
  }


}

/// @nodoc
mixin _$TypingUser {

  String get id;

  String get username;

  String get fullName;

  /// Create a copy of TypingUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TypingUserCopyWith<TypingUser> get copyWith =>
      _$TypingUserCopyWithImpl<TypingUser>(this as TypingUser, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TypingUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName));
  }


  @override
  int get hashCode => Object.hash(runtimeType, id, username, fullName);

  @override
  String toString() {
    return 'TypingUser(id: $id, username: $username, fullName: $fullName)';
  }


}

/// @nodoc
abstract mixin class $TypingUserCopyWith<$Res> {
  factory $TypingUserCopyWith(TypingUser value,
      $Res Function(TypingUser) _then) = _$TypingUserCopyWithImpl;

  @useResult
  $Res call({
    String id, String username, String fullName
  });


}

/// @nodoc
class _$TypingUserCopyWithImpl<$Res>
    implements $TypingUserCopyWith<$Res> {
  _$TypingUserCopyWithImpl(this._self, this._then);

  final TypingUser _self;
  final $Res Function(TypingUser) _then;

  /// Create a copy of TypingUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? id = null, Object? username = null, Object? fullName = null,}) {
    return _then(_self.copyWith(
      id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
      as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
      as String,
      fullName: null == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
      as String,
    ));
  }

}


/// Adds pattern-matching-related methods to [TypingUser].
extension TypingUserPatterns on TypingUser {
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

  TResult Function( _TypingUser value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _TypingUser() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TypingUser value) $default,){
  final _that = this;
  switch (_that) {
  case _TypingUser():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TypingUser value)? $default,){
  final _that = this;
  switch (_that) {
  case _TypingUser() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, String username, String fullName)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _TypingUser() when $default != null:
  return $default(_that.id,_that.username,_that.fullName);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, String username, String fullName) $default,) {final _that = this;
  switch (_that) {
  case _TypingUser():
  return $default(_that.id,_that.username,_that.fullName);case _:
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, String username, String fullName)? $default,) {final _that = this;
  switch (_that) {
  case _TypingUser() when $default != null:
  return $default(_that.id,_that.username,_that.fullName);case _:
  return null;

  }
  }

}

/// @nodoc


class _TypingUser extends TypingUser {
  const _TypingUser(
      {required this.id, required this.username, required this.fullName})
      : super._();


  @override final String id;
  @override final String username;
  @override final String fullName;

  /// Create a copy of TypingUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypingUserCopyWith<_TypingUser> get copyWith =>
      __$TypingUserCopyWithImpl<_TypingUser>(this, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _TypingUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName));
  }


  @override
  int get hashCode => Object.hash(runtimeType, id, username, fullName);

  @override
  String toString() {
    return 'TypingUser(id: $id, username: $username, fullName: $fullName)';
  }


}

/// @nodoc
abstract mixin class _$TypingUserCopyWith<$Res>
    implements $TypingUserCopyWith<$Res> {
  factory _$TypingUserCopyWith(_TypingUser value,
      $Res Function(_TypingUser) _then) = __$TypingUserCopyWithImpl;

  @override
  @useResult
  $Res call({
    String id, String username, String fullName
  });


}

/// @nodoc
class __$TypingUserCopyWithImpl<$Res>
    implements _$TypingUserCopyWith<$Res> {
  __$TypingUserCopyWithImpl(this._self, this._then);

  final _TypingUser _self;
  final $Res Function(_TypingUser) _then;

  /// Create a copy of TypingUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? id = null, Object? username = null, Object? fullName = null,}) {
    return _then(_TypingUser(
      id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
      as String,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
      as String,
      fullName: null == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
      as String,
    ));
  }


}

// dart format on
