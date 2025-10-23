// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiResponse<T> {

  bool get success;

  String get message;

  T? get data;

  List<Map<String, dynamic>>? get errors;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApiResponseCopyWith<T, ApiResponse<T>> get copyWith =>
      _$ApiResponseCopyWithImpl<T, ApiResponse<T>>(
          this as ApiResponse<T>, _$identity);

  /// Serializes this ApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ApiResponse<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.errors, errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(errors));

  @override
  String toString() {
    return 'ApiResponse<$T>(success: $success, message: $message, data: $data, errors: $errors)';
  }


}

/// @nodoc
abstract mixin class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(ApiResponse<T> value,
      $Res Function(ApiResponse<T>) _then) = _$ApiResponseCopyWithImpl;

  @useResult
  $Res call({
    bool success, String message, T? data, List<Map<String, dynamic>>? errors
  });


}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._self, this._then);

  final ApiResponse<T> _self;
  final $Res Function(ApiResponse<T>) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? success = null, Object? message = null, Object? data = freezed, Object? errors = freezed,}) {
    return _then(_self.copyWith(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
      as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
      as String,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
      as T?,
      errors: freezed == errors
          ? _self.errors
          : errors // ignore: cast_nullable_to_non_nullable
      as List<Map<String, dynamic>>?,
    ));
  }

}


/// Adds pattern-matching-related methods to [ApiResponse].
extension ApiResponsePatterns<T> on ApiResponse<T> {
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

  TResult Function( _ApiResponse<T> value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _ApiResponse() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiResponse<T> value) $default,){
  final _that = this;
  switch (_that) {
  case _ApiResponse():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiResponse<T> value)? $default,){
  final _that = this;
  switch (_that) {
  case _ApiResponse() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success, String message, T? data, List<Map<String, dynamic>>? errors)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _ApiResponse() when $default != null:
  return $default(_that.success,_that.message,_that.data,_that.errors);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success, String message, T? data, List<Map<String, dynamic>>? errors) $default,) {final _that = this;
  switch (_that) {
  case _ApiResponse():
  return $default(_that.success,_that.message,_that.data,_that.errors);case _:
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success, String message, T? data, List<Map<String, dynamic>>? errors)? $default,) {final _that = this;
  switch (_that) {
  case _ApiResponse() when $default != null:
  return $default(_that.success,_that.message,_that.data,_that.errors);case _:
  return null;

  }
  }

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _ApiResponse<T> implements ApiResponse<T> {
  const _ApiResponse(
      {required this.success, required this.message, this.data, final List<
          Map<String, dynamic>>? errors}) : _errors = errors;

  factory _ApiResponse.fromJson(Map<String, dynamic> json,
      T Function(Object?) fromJsonT) => _$ApiResponseFromJson(json, fromJsonT);

  @override final bool success;
  @override final String message;
  @override final T? data;
  final List<Map<String, dynamic>>? _errors;

  @override List<Map<String, dynamic>>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }


  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ApiResponseCopyWith<T, _ApiResponse<T>> get copyWith =>
      __$ApiResponseCopyWithImpl<T, _ApiResponse<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$ApiResponseToJson<T>(this, toJsonT);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ApiResponse<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(_errors));

  @override
  String toString() {
    return 'ApiResponse<$T>(success: $success, message: $message, data: $data, errors: $errors)';
  }


}

/// @nodoc
abstract mixin class _$ApiResponseCopyWith<T, $Res>
    implements $ApiResponseCopyWith<T, $Res> {
  factory _$ApiResponseCopyWith(_ApiResponse<T> value,
      $Res Function(_ApiResponse<T>) _then) = __$ApiResponseCopyWithImpl;

  @override
  @useResult
  $Res call({
    bool success, String message, T? data, List<Map<String, dynamic>>? errors
  });


}

/// @nodoc
class __$ApiResponseCopyWithImpl<T, $Res>
    implements _$ApiResponseCopyWith<T, $Res> {
  __$ApiResponseCopyWithImpl(this._self, this._then);

  final _ApiResponse<T> _self;
  final $Res Function(_ApiResponse<T>) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? success = null, Object? message = null, Object? data = freezed, Object? errors = freezed,}) {
    return _then(_ApiResponse<T>(
      success: null == success
          ? _self.success
          : success // ignore: cast_nullable_to_non_nullable
      as bool,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
      as String,
      data: freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
      as T?,
      errors: freezed == errors
          ? _self._errors
          : errors // ignore: cast_nullable_to_non_nullable
      as List<Map<String, dynamic>>?,
    ));
  }


}

// dart format on
