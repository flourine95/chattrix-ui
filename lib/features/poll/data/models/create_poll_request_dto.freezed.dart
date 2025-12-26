// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_poll_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatePollRequestDto {

 String get question; List<String> get options; bool get allowMultipleVotes;@JsonKey(name: 'expiresAt', toJson: _dateTimeToMilliseconds, fromJson: _millisecondsToDateTime) DateTime? get expiresAt;
/// Create a copy of CreatePollRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePollRequestDtoCopyWith<CreatePollRequestDto> get copyWith => _$CreatePollRequestDtoCopyWithImpl<CreatePollRequestDto>(this as CreatePollRequestDto, _$identity);

  /// Serializes this CreatePollRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePollRequestDto&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,const DeepCollectionEquality().hash(options),allowMultipleVotes,expiresAt);

@override
String toString() {
  return 'CreatePollRequestDto(question: $question, options: $options, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $CreatePollRequestDtoCopyWith<$Res>  {
  factory $CreatePollRequestDtoCopyWith(CreatePollRequestDto value, $Res Function(CreatePollRequestDto) _then) = _$CreatePollRequestDtoCopyWithImpl;
@useResult
$Res call({
 String question, List<String> options, bool allowMultipleVotes,@JsonKey(name: 'expiresAt', toJson: _dateTimeToMilliseconds, fromJson: _millisecondsToDateTime) DateTime? expiresAt
});




}
/// @nodoc
class _$CreatePollRequestDtoCopyWithImpl<$Res>
    implements $CreatePollRequestDtoCopyWith<$Res> {
  _$CreatePollRequestDtoCopyWithImpl(this._self, this._then);

  final CreatePollRequestDto _self;
  final $Res Function(CreatePollRequestDto) _then;

/// Create a copy of CreatePollRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? options = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePollRequestDto].
extension CreatePollRequestDtoPatterns on CreatePollRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePollRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePollRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePollRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _CreatePollRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePollRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePollRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  List<String> options,  bool allowMultipleVotes, @JsonKey(name: 'expiresAt', toJson: _dateTimeToMilliseconds, fromJson: _millisecondsToDateTime)  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePollRequestDto() when $default != null:
return $default(_that.question,_that.options,_that.allowMultipleVotes,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  List<String> options,  bool allowMultipleVotes, @JsonKey(name: 'expiresAt', toJson: _dateTimeToMilliseconds, fromJson: _millisecondsToDateTime)  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _CreatePollRequestDto():
return $default(_that.question,_that.options,_that.allowMultipleVotes,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  List<String> options,  bool allowMultipleVotes, @JsonKey(name: 'expiresAt', toJson: _dateTimeToMilliseconds, fromJson: _millisecondsToDateTime)  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _CreatePollRequestDto() when $default != null:
return $default(_that.question,_that.options,_that.allowMultipleVotes,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePollRequestDto implements CreatePollRequestDto {
  const _CreatePollRequestDto({required this.question, required final  List<String> options, required this.allowMultipleVotes, @JsonKey(name: 'expiresAt', toJson: _dateTimeToMilliseconds, fromJson: _millisecondsToDateTime) this.expiresAt}): _options = options;
  factory _CreatePollRequestDto.fromJson(Map<String, dynamic> json) => _$CreatePollRequestDtoFromJson(json);

@override final  String question;
 final  List<String> _options;
@override List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  bool allowMultipleVotes;
@override@JsonKey(name: 'expiresAt', toJson: _dateTimeToMilliseconds, fromJson: _millisecondsToDateTime) final  DateTime? expiresAt;

/// Create a copy of CreatePollRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePollRequestDtoCopyWith<_CreatePollRequestDto> get copyWith => __$CreatePollRequestDtoCopyWithImpl<_CreatePollRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePollRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePollRequestDto&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,question,const DeepCollectionEquality().hash(_options),allowMultipleVotes,expiresAt);

@override
String toString() {
  return 'CreatePollRequestDto(question: $question, options: $options, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$CreatePollRequestDtoCopyWith<$Res> implements $CreatePollRequestDtoCopyWith<$Res> {
  factory _$CreatePollRequestDtoCopyWith(_CreatePollRequestDto value, $Res Function(_CreatePollRequestDto) _then) = __$CreatePollRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String question, List<String> options, bool allowMultipleVotes,@JsonKey(name: 'expiresAt', toJson: _dateTimeToMilliseconds, fromJson: _millisecondsToDateTime) DateTime? expiresAt
});




}
/// @nodoc
class __$CreatePollRequestDtoCopyWithImpl<$Res>
    implements _$CreatePollRequestDtoCopyWith<$Res> {
  __$CreatePollRequestDtoCopyWithImpl(this._self, this._then);

  final _CreatePollRequestDto _self;
  final $Res Function(_CreatePollRequestDto) _then;

/// Create a copy of CreatePollRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? options = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,}) {
  return _then(_CreatePollRequestDto(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
