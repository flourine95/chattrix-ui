// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserNote {

 int get id; int get userId; String get username; String get fullName; String? get avatarUrl; String get noteText; String? get musicUrl; String? get musicTitle; String? get emoji; DateTime get createdAt; DateTime get expiresAt; int get replyCount;
/// Create a copy of UserNote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserNoteCopyWith<UserNote> get copyWith => _$UserNoteCopyWithImpl<UserNote>(this as UserNote, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserNote&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.noteText, noteText) || other.noteText == noteText)&&(identical(other.musicUrl, musicUrl) || other.musicUrl == musicUrl)&&(identical(other.musicTitle, musicTitle) || other.musicTitle == musicTitle)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.replyCount, replyCount) || other.replyCount == replyCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,username,fullName,avatarUrl,noteText,musicUrl,musicTitle,emoji,createdAt,expiresAt,replyCount);

@override
String toString() {
  return 'UserNote(id: $id, userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, noteText: $noteText, musicUrl: $musicUrl, musicTitle: $musicTitle, emoji: $emoji, createdAt: $createdAt, expiresAt: $expiresAt, replyCount: $replyCount)';
}


}

/// @nodoc
abstract mixin class $UserNoteCopyWith<$Res>  {
  factory $UserNoteCopyWith(UserNote value, $Res Function(UserNote) _then) = _$UserNoteCopyWithImpl;
@useResult
$Res call({
 int id, int userId, String username, String fullName, String? avatarUrl, String noteText, String? musicUrl, String? musicTitle, String? emoji, DateTime createdAt, DateTime expiresAt, int replyCount
});




}
/// @nodoc
class _$UserNoteCopyWithImpl<$Res>
    implements $UserNoteCopyWith<$Res> {
  _$UserNoteCopyWithImpl(this._self, this._then);

  final UserNote _self;
  final $Res Function(UserNote) _then;

/// Create a copy of UserNote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? noteText = null,Object? musicUrl = freezed,Object? musicTitle = freezed,Object? emoji = freezed,Object? createdAt = null,Object? expiresAt = null,Object? replyCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,noteText: null == noteText ? _self.noteText : noteText // ignore: cast_nullable_to_non_nullable
as String,musicUrl: freezed == musicUrl ? _self.musicUrl : musicUrl // ignore: cast_nullable_to_non_nullable
as String?,musicTitle: freezed == musicTitle ? _self.musicTitle : musicTitle // ignore: cast_nullable_to_non_nullable
as String?,emoji: freezed == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,replyCount: null == replyCount ? _self.replyCount : replyCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserNote].
extension UserNotePatterns on UserNote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserNote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserNote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserNote value)  $default,){
final _that = this;
switch (_that) {
case _UserNote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserNote value)?  $default,){
final _that = this;
switch (_that) {
case _UserNote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int userId,  String username,  String fullName,  String? avatarUrl,  String noteText,  String? musicUrl,  String? musicTitle,  String? emoji,  DateTime createdAt,  DateTime expiresAt,  int replyCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserNote() when $default != null:
return $default(_that.id,_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.noteText,_that.musicUrl,_that.musicTitle,_that.emoji,_that.createdAt,_that.expiresAt,_that.replyCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int userId,  String username,  String fullName,  String? avatarUrl,  String noteText,  String? musicUrl,  String? musicTitle,  String? emoji,  DateTime createdAt,  DateTime expiresAt,  int replyCount)  $default,) {final _that = this;
switch (_that) {
case _UserNote():
return $default(_that.id,_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.noteText,_that.musicUrl,_that.musicTitle,_that.emoji,_that.createdAt,_that.expiresAt,_that.replyCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int userId,  String username,  String fullName,  String? avatarUrl,  String noteText,  String? musicUrl,  String? musicTitle,  String? emoji,  DateTime createdAt,  DateTime expiresAt,  int replyCount)?  $default,) {final _that = this;
switch (_that) {
case _UserNote() when $default != null:
return $default(_that.id,_that.userId,_that.username,_that.fullName,_that.avatarUrl,_that.noteText,_that.musicUrl,_that.musicTitle,_that.emoji,_that.createdAt,_that.expiresAt,_that.replyCount);case _:
  return null;

}
}

}

/// @nodoc


class _UserNote implements UserNote {
  const _UserNote({required this.id, required this.userId, required this.username, required this.fullName, this.avatarUrl, required this.noteText, this.musicUrl, this.musicTitle, this.emoji, required this.createdAt, required this.expiresAt, this.replyCount = 0});
  

@override final  int id;
@override final  int userId;
@override final  String username;
@override final  String fullName;
@override final  String? avatarUrl;
@override final  String noteText;
@override final  String? musicUrl;
@override final  String? musicTitle;
@override final  String? emoji;
@override final  DateTime createdAt;
@override final  DateTime expiresAt;
@override@JsonKey() final  int replyCount;

/// Create a copy of UserNote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserNoteCopyWith<_UserNote> get copyWith => __$UserNoteCopyWithImpl<_UserNote>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserNote&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.noteText, noteText) || other.noteText == noteText)&&(identical(other.musicUrl, musicUrl) || other.musicUrl == musicUrl)&&(identical(other.musicTitle, musicTitle) || other.musicTitle == musicTitle)&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.replyCount, replyCount) || other.replyCount == replyCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,username,fullName,avatarUrl,noteText,musicUrl,musicTitle,emoji,createdAt,expiresAt,replyCount);

@override
String toString() {
  return 'UserNote(id: $id, userId: $userId, username: $username, fullName: $fullName, avatarUrl: $avatarUrl, noteText: $noteText, musicUrl: $musicUrl, musicTitle: $musicTitle, emoji: $emoji, createdAt: $createdAt, expiresAt: $expiresAt, replyCount: $replyCount)';
}


}

/// @nodoc
abstract mixin class _$UserNoteCopyWith<$Res> implements $UserNoteCopyWith<$Res> {
  factory _$UserNoteCopyWith(_UserNote value, $Res Function(_UserNote) _then) = __$UserNoteCopyWithImpl;
@override @useResult
$Res call({
 int id, int userId, String username, String fullName, String? avatarUrl, String noteText, String? musicUrl, String? musicTitle, String? emoji, DateTime createdAt, DateTime expiresAt, int replyCount
});




}
/// @nodoc
class __$UserNoteCopyWithImpl<$Res>
    implements _$UserNoteCopyWith<$Res> {
  __$UserNoteCopyWithImpl(this._self, this._then);

  final _UserNote _self;
  final $Res Function(_UserNote) _then;

/// Create a copy of UserNote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? username = null,Object? fullName = null,Object? avatarUrl = freezed,Object? noteText = null,Object? musicUrl = freezed,Object? musicTitle = freezed,Object? emoji = freezed,Object? createdAt = null,Object? expiresAt = null,Object? replyCount = null,}) {
  return _then(_UserNote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,noteText: null == noteText ? _self.noteText : noteText // ignore: cast_nullable_to_non_nullable
as String,musicUrl: freezed == musicUrl ? _self.musicUrl : musicUrl // ignore: cast_nullable_to_non_nullable
as String?,musicTitle: freezed == musicTitle ? _self.musicTitle : musicTitle // ignore: cast_nullable_to_non_nullable
as String?,emoji: freezed == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,replyCount: null == replyCount ? _self.replyCount : replyCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
