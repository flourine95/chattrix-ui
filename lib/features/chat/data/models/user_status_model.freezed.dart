// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserStatusModel {

  String get userId;

  bool get isOnline;

  int get activeSessionCount;

  /// Create a copy of UserStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserStatusModelCopyWith<UserStatusModel> get copyWith =>
      _$UserStatusModelCopyWithImpl<UserStatusModel>(
          this as UserStatusModel, _$identity);

  /// Serializes this UserStatusModel to a JSON map.
  Map<String, dynamic> toJson();


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is UserStatusModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.activeSessionCount, activeSessionCount) ||
                other.activeSessionCount == activeSessionCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, isOnline, activeSessionCount);

  @override
  String toString() {
    return 'UserStatusModel(userId: $userId, isOnline: $isOnline, activeSessionCount: $activeSessionCount)';
  }


}

/// @nodoc
abstract mixin class $UserStatusModelCopyWith<$Res> {
  factory $UserStatusModelCopyWith(UserStatusModel value,
      $Res Function(UserStatusModel) _then) = _$UserStatusModelCopyWithImpl;

  @useResult
  $Res call({
    String userId, bool isOnline, int activeSessionCount
  });


}

/// @nodoc
class _$UserStatusModelCopyWithImpl<$Res>
    implements $UserStatusModelCopyWith<$Res> {
  _$UserStatusModelCopyWithImpl(this._self, this._then);

  final UserStatusModel _self;
  final $Res Function(UserStatusModel) _then;

  /// Create a copy of UserStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? userId = null, Object? isOnline = null, Object? activeSessionCount = null,}) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
      as String,
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


/// Adds pattern-matching-related methods to [UserStatusModel].
extension UserStatusModelPatterns on UserStatusModel {
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

  TResult Function( _UserStatusModel value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _UserStatusModel() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserStatusModel value) $default,){
  final _that = this;
  switch (_that) {
  case _UserStatusModel():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserStatusModel value)? $default,){
  final _that = this;
  switch (_that) {
  case _UserStatusModel() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId, bool isOnline, int activeSessionCount)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _UserStatusModel() when $default != null:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId, bool isOnline, int activeSessionCount) $default,) {final _that = this;
  switch (_that) {
  case _UserStatusModel():
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId, bool isOnline, int activeSessionCount)? $default,) {final _that = this;
  switch (_that) {
  case _UserStatusModel() when $default != null:
  return $default(_that.userId,_that.isOnline,_that.activeSessionCount);case _:
  return null;

  }
  }

}

/// @nodoc
@JsonSerializable()
class _UserStatusModel extends UserStatusModel {
  const _UserStatusModel(
      {required this.userId, required this.isOnline, required this.activeSessionCount})
      : super._();

  factory _UserStatusModel.fromJson(Map<String, dynamic> json) =>
      _$UserStatusModelFromJson(json);

  @override final String userId;
  @override final bool isOnline;
  @override final int activeSessionCount;

  /// Create a copy of UserStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserStatusModelCopyWith<_UserStatusModel> get copyWith =>
      __$UserStatusModelCopyWithImpl<_UserStatusModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserStatusModelToJson(this,);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _UserStatusModel &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.activeSessionCount, activeSessionCount) ||
                other.activeSessionCount == activeSessionCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, isOnline, activeSessionCount);

  @override
  String toString() {
    return 'UserStatusModel(userId: $userId, isOnline: $isOnline, activeSessionCount: $activeSessionCount)';
  }


}

/// @nodoc
abstract mixin class _$UserStatusModelCopyWith<$Res>
    implements $UserStatusModelCopyWith<$Res> {
  factory _$UserStatusModelCopyWith(_UserStatusModel value,
      $Res Function(_UserStatusModel) _then) = __$UserStatusModelCopyWithImpl;

  @override
  @useResult
  $Res call({
    String userId, bool isOnline, int activeSessionCount
  });


}

/// @nodoc
class __$UserStatusModelCopyWithImpl<$Res>
    implements _$UserStatusModelCopyWith<$Res> {
  __$UserStatusModelCopyWithImpl(this._self, this._then);

  final _UserStatusModel _self;
  final $Res Function(_UserStatusModel) _then;

  /// Create a copy of UserStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? userId = null, Object? isOnline = null, Object? activeSessionCount = null,}) {
    return _then(_UserStatusModel(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
      as String,
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
