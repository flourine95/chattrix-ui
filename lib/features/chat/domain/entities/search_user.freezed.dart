// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchUser {

  int get id;

  String get username;

  String get email;

  String get fullName;

  String? get avatarUrl;

  bool get isOnline;

  DateTime get lastSeen;

  bool get contact;

  bool get hasConversation;

  int? get conversationId;

  /// Create a copy of SearchUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchUserCopyWith<SearchUser> get copyWith =>
      _$SearchUserCopyWithImpl<SearchUser>(this as SearchUser, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SearchUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.hasConversation, hasConversation) ||
                other.hasConversation == hasConversation) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }


  @override
  int get hashCode =>
      Object.hash(
          runtimeType,
          id,
          username,
          email,
          fullName,
          avatarUrl,
          isOnline,
          lastSeen,
          contact,
          hasConversation,
          conversationId);

  @override
  String toString() {
    return 'SearchUser(id: $id, username: $username, email: $email, fullName: $fullName, avatarUrl: $avatarUrl, isOnline: $isOnline, lastSeen: $lastSeen, contact: $contact, hasConversation: $hasConversation, conversationId: $conversationId)';
  }


}

/// @nodoc
abstract mixin class $SearchUserCopyWith<$Res> {
  factory $SearchUserCopyWith(SearchUser value,
      $Res Function(SearchUser) _then) = _$SearchUserCopyWithImpl;

  @useResult
  $Res call({
    int id, String username, String email, String fullName, String? avatarUrl, bool isOnline, DateTime lastSeen, bool contact, bool hasConversation, int? conversationId
  });


}

/// @nodoc
class _$SearchUserCopyWithImpl<$Res>
    implements $SearchUserCopyWith<$Res> {
  _$SearchUserCopyWithImpl(this._self, this._then);

  final SearchUser _self;
  final $Res Function(SearchUser) _then;

  /// Create a copy of SearchUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? id = null, Object? username = null, Object? email = null, Object? fullName = null, Object? avatarUrl = freezed, Object? isOnline = null, Object? lastSeen = null, Object? contact = null, Object? hasConversation = null, Object? conversationId = freezed,}) {
    return _then(_self.copyWith(
      id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
      as int,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
      as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
      as String,
      fullName: null == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
      as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
      as String?,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
      as bool,
      lastSeen: null == lastSeen
          ? _self.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
      as DateTime,
      contact: null == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
      as bool,
      hasConversation: null == hasConversation
          ? _self.hasConversation
          : hasConversation // ignore: cast_nullable_to_non_nullable
      as bool,
      conversationId: freezed == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
      as int?,
    ));
  }

}


/// Adds pattern-matching-related methods to [SearchUser].
extension SearchUserPatterns on SearchUser {
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

  TResult Function( _SearchUser value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _SearchUser() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchUser value) $default,){
  final _that = this;
  switch (_that) {
  case _SearchUser():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchUser value)? $default,){
  final _that = this;
  switch (_that) {
  case _SearchUser() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, String username, String email, String fullName, String? avatarUrl, bool isOnline, DateTime lastSeen, bool contact, bool hasConversation, int? conversationId)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _SearchUser() when $default != null:
  return $default(_that.id,_that.username,_that.email,_that.fullName,_that.avatarUrl,_that.isOnline,_that.lastSeen,_that.contact,_that.hasConversation,_that.conversationId);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, String username, String email, String fullName, String? avatarUrl, bool isOnline, DateTime lastSeen, bool contact, bool hasConversation, int? conversationId) $default,) {final _that = this;
  switch (_that) {
  case _SearchUser():
  return $default(_that.id,_that.username,_that.email,_that.fullName,_that.avatarUrl,_that.isOnline,_that.lastSeen,_that.contact,_that.hasConversation,_that.conversationId);case _:
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, String username, String email, String fullName, String? avatarUrl, bool isOnline, DateTime lastSeen, bool contact, bool hasConversation, int? conversationId)? $default,) {final _that = this;
  switch (_that) {
  case _SearchUser() when $default != null:
  return $default(_that.id,_that.username,_that.email,_that.fullName,_that.avatarUrl,_that.isOnline,_that.lastSeen,_that.contact,_that.hasConversation,_that.conversationId);case _:
  return null;

  }
  }

}

/// @nodoc


class _SearchUser implements SearchUser {
  const _SearchUser(
      {required this.id, required this.username, required this.email, required this.fullName, this.avatarUrl, required this.isOnline, required this.lastSeen, required this.contact, required this.hasConversation, this.conversationId});


  @override final int id;
  @override final String username;
  @override final String email;
  @override final String fullName;
  @override final String? avatarUrl;
  @override final bool isOnline;
  @override final DateTime lastSeen;
  @override final bool contact;
  @override final bool hasConversation;
  @override final int? conversationId;

  /// Create a copy of SearchUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchUserCopyWith<_SearchUser> get copyWith =>
      __$SearchUserCopyWithImpl<_SearchUser>(this, _$identity);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SearchUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.contact, contact) || other.contact == contact) &&
            (identical(other.hasConversation, hasConversation) ||
                other.hasConversation == hasConversation) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }


  @override
  int get hashCode =>
      Object.hash(
          runtimeType,
          id,
          username,
          email,
          fullName,
          avatarUrl,
          isOnline,
          lastSeen,
          contact,
          hasConversation,
          conversationId);

  @override
  String toString() {
    return 'SearchUser(id: $id, username: $username, email: $email, fullName: $fullName, avatarUrl: $avatarUrl, isOnline: $isOnline, lastSeen: $lastSeen, contact: $contact, hasConversation: $hasConversation, conversationId: $conversationId)';
  }


}

/// @nodoc
abstract mixin class _$SearchUserCopyWith<$Res>
    implements $SearchUserCopyWith<$Res> {
  factory _$SearchUserCopyWith(_SearchUser value,
      $Res Function(_SearchUser) _then) = __$SearchUserCopyWithImpl;

  @override
  @useResult
  $Res call({
    int id, String username, String email, String fullName, String? avatarUrl, bool isOnline, DateTime lastSeen, bool contact, bool hasConversation, int? conversationId
  });


}

/// @nodoc
class __$SearchUserCopyWithImpl<$Res>
    implements _$SearchUserCopyWith<$Res> {
  __$SearchUserCopyWithImpl(this._self, this._then);

  final _SearchUser _self;
  final $Res Function(_SearchUser) _then;

  /// Create a copy of SearchUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? id = null, Object? username = null, Object? email = null, Object? fullName = null, Object? avatarUrl = freezed, Object? isOnline = null, Object? lastSeen = null, Object? contact = null, Object? hasConversation = null, Object? conversationId = freezed,}) {
    return _then(_SearchUser(
      id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
      as int,
      username: null == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
      as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
      as String,
      fullName: null == fullName
          ? _self.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
      as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
      as String?,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
      as bool,
      lastSeen: null == lastSeen
          ? _self.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
      as DateTime,
      contact: null == contact
          ? _self.contact
          : contact // ignore: cast_nullable_to_non_nullable
      as bool,
      hasConversation: null == hasConversation
          ? _self.hasConversation
          : hasConversation // ignore: cast_nullable_to_non_nullable
      as bool,
      conversationId: freezed == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
      as int?,
    ));
  }


}

// dart format on
