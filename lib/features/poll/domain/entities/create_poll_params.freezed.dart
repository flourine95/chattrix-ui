// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_poll_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreatePollParams {

 int get conversationId; String get question; List<String> get options; bool get allowMultipleVotes; DateTime? get expiresAt;
/// Create a copy of CreatePollParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePollParamsCopyWith<CreatePollParams> get copyWith => _$CreatePollParamsCopyWithImpl<CreatePollParams>(this as CreatePollParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePollParams&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,question,const DeepCollectionEquality().hash(options),allowMultipleVotes,expiresAt);

@override
String toString() {
  return 'CreatePollParams(conversationId: $conversationId, question: $question, options: $options, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $CreatePollParamsCopyWith<$Res>  {
  factory $CreatePollParamsCopyWith(CreatePollParams value, $Res Function(CreatePollParams) _then) = _$CreatePollParamsCopyWithImpl;
@useResult
$Res call({
 int conversationId, String question, List<String> options, bool allowMultipleVotes, DateTime? expiresAt
});




}
/// @nodoc
class _$CreatePollParamsCopyWithImpl<$Res>
    implements $CreatePollParamsCopyWith<$Res> {
  _$CreatePollParamsCopyWithImpl(this._self, this._then);

  final CreatePollParams _self;
  final $Res Function(CreatePollParams) _then;

/// Create a copy of CreatePollParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,Object? question = null,Object? options = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePollParams].
extension CreatePollParamsPatterns on CreatePollParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePollParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePollParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePollParams value)  $default,){
final _that = this;
switch (_that) {
case _CreatePollParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePollParams value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePollParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int conversationId,  String question,  List<String> options,  bool allowMultipleVotes,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePollParams() when $default != null:
return $default(_that.conversationId,_that.question,_that.options,_that.allowMultipleVotes,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int conversationId,  String question,  List<String> options,  bool allowMultipleVotes,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _CreatePollParams():
return $default(_that.conversationId,_that.question,_that.options,_that.allowMultipleVotes,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int conversationId,  String question,  List<String> options,  bool allowMultipleVotes,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _CreatePollParams() when $default != null:
return $default(_that.conversationId,_that.question,_that.options,_that.allowMultipleVotes,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _CreatePollParams extends CreatePollParams {
  const _CreatePollParams({required this.conversationId, required this.question, required final  List<String> options, required this.allowMultipleVotes, this.expiresAt}): _options = options,super._();
  

@override final  int conversationId;
@override final  String question;
 final  List<String> _options;
@override List<String> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  bool allowMultipleVotes;
@override final  DateTime? expiresAt;

/// Create a copy of CreatePollParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePollParamsCopyWith<_CreatePollParams> get copyWith => __$CreatePollParamsCopyWithImpl<_CreatePollParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePollParams&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.allowMultipleVotes, allowMultipleVotes) || other.allowMultipleVotes == allowMultipleVotes)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,question,const DeepCollectionEquality().hash(_options),allowMultipleVotes,expiresAt);

@override
String toString() {
  return 'CreatePollParams(conversationId: $conversationId, question: $question, options: $options, allowMultipleVotes: $allowMultipleVotes, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$CreatePollParamsCopyWith<$Res> implements $CreatePollParamsCopyWith<$Res> {
  factory _$CreatePollParamsCopyWith(_CreatePollParams value, $Res Function(_CreatePollParams) _then) = __$CreatePollParamsCopyWithImpl;
@override @useResult
$Res call({
 int conversationId, String question, List<String> options, bool allowMultipleVotes, DateTime? expiresAt
});




}
/// @nodoc
class __$CreatePollParamsCopyWithImpl<$Res>
    implements _$CreatePollParamsCopyWith<$Res> {
  __$CreatePollParamsCopyWithImpl(this._self, this._then);

  final _CreatePollParams _self;
  final $Res Function(_CreatePollParams) _then;

/// Create a copy of CreatePollParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? question = null,Object? options = null,Object? allowMultipleVotes = null,Object? expiresAt = freezed,}) {
  return _then(_CreatePollParams(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>,allowMultipleVotes: null == allowMultipleVotes ? _self.allowMultipleVotes : allowMultipleVotes // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
