// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ConversationSettings {

 int get conversationId; bool get muted; bool get blocked; bool get notificationsEnabled; bool get pinned; int? get pinOrder; bool get archived; bool get hidden; String? get customNickname; String? get theme;
/// Create a copy of ConversationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationSettingsCopyWith<ConversationSettings> get copyWith => _$ConversationSettingsCopyWithImpl<ConversationSettings>(this as ConversationSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationSettings&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.blocked, blocked) || other.blocked == blocked)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.pinOrder, pinOrder) || other.pinOrder == pinOrder)&&(identical(other.archived, archived) || other.archived == archived)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.customNickname, customNickname) || other.customNickname == customNickname)&&(identical(other.theme, theme) || other.theme == theme));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,muted,blocked,notificationsEnabled,pinned,pinOrder,archived,hidden,customNickname,theme);

@override
String toString() {
  return 'ConversationSettings(conversationId: $conversationId, muted: $muted, blocked: $blocked, notificationsEnabled: $notificationsEnabled, pinned: $pinned, pinOrder: $pinOrder, archived: $archived, hidden: $hidden, customNickname: $customNickname, theme: $theme)';
}


}

/// @nodoc
abstract mixin class $ConversationSettingsCopyWith<$Res>  {
  factory $ConversationSettingsCopyWith(ConversationSettings value, $Res Function(ConversationSettings) _then) = _$ConversationSettingsCopyWithImpl;
@useResult
$Res call({
 int conversationId, bool muted, bool blocked, bool notificationsEnabled, bool pinned, int? pinOrder, bool archived, bool hidden, String? customNickname, String? theme
});




}
/// @nodoc
class _$ConversationSettingsCopyWithImpl<$Res>
    implements $ConversationSettingsCopyWith<$Res> {
  _$ConversationSettingsCopyWithImpl(this._self, this._then);

  final ConversationSettings _self;
  final $Res Function(ConversationSettings) _then;

/// Create a copy of ConversationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,Object? muted = null,Object? blocked = null,Object? notificationsEnabled = null,Object? pinned = null,Object? pinOrder = freezed,Object? archived = null,Object? hidden = null,Object? customNickname = freezed,Object? theme = freezed,}) {
  return _then(_self.copyWith(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool,blocked: null == blocked ? _self.blocked : blocked // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool,pinOrder: freezed == pinOrder ? _self.pinOrder : pinOrder // ignore: cast_nullable_to_non_nullable
as int?,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,customNickname: freezed == customNickname ? _self.customNickname : customNickname // ignore: cast_nullable_to_non_nullable
as String?,theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConversationSettings].
extension ConversationSettingsPatterns on ConversationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationSettings value)  $default,){
final _that = this;
switch (_that) {
case _ConversationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int conversationId,  bool muted,  bool blocked,  bool notificationsEnabled,  bool pinned,  int? pinOrder,  bool archived,  bool hidden,  String? customNickname,  String? theme)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationSettings() when $default != null:
return $default(_that.conversationId,_that.muted,_that.blocked,_that.notificationsEnabled,_that.pinned,_that.pinOrder,_that.archived,_that.hidden,_that.customNickname,_that.theme);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int conversationId,  bool muted,  bool blocked,  bool notificationsEnabled,  bool pinned,  int? pinOrder,  bool archived,  bool hidden,  String? customNickname,  String? theme)  $default,) {final _that = this;
switch (_that) {
case _ConversationSettings():
return $default(_that.conversationId,_that.muted,_that.blocked,_that.notificationsEnabled,_that.pinned,_that.pinOrder,_that.archived,_that.hidden,_that.customNickname,_that.theme);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int conversationId,  bool muted,  bool blocked,  bool notificationsEnabled,  bool pinned,  int? pinOrder,  bool archived,  bool hidden,  String? customNickname,  String? theme)?  $default,) {final _that = this;
switch (_that) {
case _ConversationSettings() when $default != null:
return $default(_that.conversationId,_that.muted,_that.blocked,_that.notificationsEnabled,_that.pinned,_that.pinOrder,_that.archived,_that.hidden,_that.customNickname,_that.theme);case _:
  return null;

}
}

}

/// @nodoc


class _ConversationSettings implements ConversationSettings {
  const _ConversationSettings({required this.conversationId, required this.muted, required this.blocked, required this.notificationsEnabled, required this.pinned, this.pinOrder, required this.archived, required this.hidden, this.customNickname, this.theme});
  

@override final  int conversationId;
@override final  bool muted;
@override final  bool blocked;
@override final  bool notificationsEnabled;
@override final  bool pinned;
@override final  int? pinOrder;
@override final  bool archived;
@override final  bool hidden;
@override final  String? customNickname;
@override final  String? theme;

/// Create a copy of ConversationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationSettingsCopyWith<_ConversationSettings> get copyWith => __$ConversationSettingsCopyWithImpl<_ConversationSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationSettings&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.blocked, blocked) || other.blocked == blocked)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.pinOrder, pinOrder) || other.pinOrder == pinOrder)&&(identical(other.archived, archived) || other.archived == archived)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.customNickname, customNickname) || other.customNickname == customNickname)&&(identical(other.theme, theme) || other.theme == theme));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,muted,blocked,notificationsEnabled,pinned,pinOrder,archived,hidden,customNickname,theme);

@override
String toString() {
  return 'ConversationSettings(conversationId: $conversationId, muted: $muted, blocked: $blocked, notificationsEnabled: $notificationsEnabled, pinned: $pinned, pinOrder: $pinOrder, archived: $archived, hidden: $hidden, customNickname: $customNickname, theme: $theme)';
}


}

/// @nodoc
abstract mixin class _$ConversationSettingsCopyWith<$Res> implements $ConversationSettingsCopyWith<$Res> {
  factory _$ConversationSettingsCopyWith(_ConversationSettings value, $Res Function(_ConversationSettings) _then) = __$ConversationSettingsCopyWithImpl;
@override @useResult
$Res call({
 int conversationId, bool muted, bool blocked, bool notificationsEnabled, bool pinned, int? pinOrder, bool archived, bool hidden, String? customNickname, String? theme
});




}
/// @nodoc
class __$ConversationSettingsCopyWithImpl<$Res>
    implements _$ConversationSettingsCopyWith<$Res> {
  __$ConversationSettingsCopyWithImpl(this._self, this._then);

  final _ConversationSettings _self;
  final $Res Function(_ConversationSettings) _then;

/// Create a copy of ConversationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? muted = null,Object? blocked = null,Object? notificationsEnabled = null,Object? pinned = null,Object? pinOrder = freezed,Object? archived = null,Object? hidden = null,Object? customNickname = freezed,Object? theme = freezed,}) {
  return _then(_ConversationSettings(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool,blocked: null == blocked ? _self.blocked : blocked // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,pinned: null == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool,pinOrder: freezed == pinOrder ? _self.pinOrder : pinOrder // ignore: cast_nullable_to_non_nullable
as int?,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,hidden: null == hidden ? _self.hidden : hidden // ignore: cast_nullable_to_non_nullable
as bool,customNickname: freezed == customNickname ? _self.customNickname : customNickname // ignore: cast_nullable_to_non_nullable
as String?,theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ConversationPermissions {

 int get conversationId; String get sendMessages; String get addMembers; String get removeMembers; String get editGroupInfo; String get pinMessages; String get deleteMessages; String get createPolls;
/// Create a copy of ConversationPermissions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationPermissionsCopyWith<ConversationPermissions> get copyWith => _$ConversationPermissionsCopyWithImpl<ConversationPermissions>(this as ConversationPermissions, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationPermissions&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.sendMessages, sendMessages) || other.sendMessages == sendMessages)&&(identical(other.addMembers, addMembers) || other.addMembers == addMembers)&&(identical(other.removeMembers, removeMembers) || other.removeMembers == removeMembers)&&(identical(other.editGroupInfo, editGroupInfo) || other.editGroupInfo == editGroupInfo)&&(identical(other.pinMessages, pinMessages) || other.pinMessages == pinMessages)&&(identical(other.deleteMessages, deleteMessages) || other.deleteMessages == deleteMessages)&&(identical(other.createPolls, createPolls) || other.createPolls == createPolls));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,sendMessages,addMembers,removeMembers,editGroupInfo,pinMessages,deleteMessages,createPolls);

@override
String toString() {
  return 'ConversationPermissions(conversationId: $conversationId, sendMessages: $sendMessages, addMembers: $addMembers, removeMembers: $removeMembers, editGroupInfo: $editGroupInfo, pinMessages: $pinMessages, deleteMessages: $deleteMessages, createPolls: $createPolls)';
}


}

/// @nodoc
abstract mixin class $ConversationPermissionsCopyWith<$Res>  {
  factory $ConversationPermissionsCopyWith(ConversationPermissions value, $Res Function(ConversationPermissions) _then) = _$ConversationPermissionsCopyWithImpl;
@useResult
$Res call({
 int conversationId, String sendMessages, String addMembers, String removeMembers, String editGroupInfo, String pinMessages, String deleteMessages, String createPolls
});




}
/// @nodoc
class _$ConversationPermissionsCopyWithImpl<$Res>
    implements $ConversationPermissionsCopyWith<$Res> {
  _$ConversationPermissionsCopyWithImpl(this._self, this._then);

  final ConversationPermissions _self;
  final $Res Function(ConversationPermissions) _then;

/// Create a copy of ConversationPermissions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,Object? sendMessages = null,Object? addMembers = null,Object? removeMembers = null,Object? editGroupInfo = null,Object? pinMessages = null,Object? deleteMessages = null,Object? createPolls = null,}) {
  return _then(_self.copyWith(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,sendMessages: null == sendMessages ? _self.sendMessages : sendMessages // ignore: cast_nullable_to_non_nullable
as String,addMembers: null == addMembers ? _self.addMembers : addMembers // ignore: cast_nullable_to_non_nullable
as String,removeMembers: null == removeMembers ? _self.removeMembers : removeMembers // ignore: cast_nullable_to_non_nullable
as String,editGroupInfo: null == editGroupInfo ? _self.editGroupInfo : editGroupInfo // ignore: cast_nullable_to_non_nullable
as String,pinMessages: null == pinMessages ? _self.pinMessages : pinMessages // ignore: cast_nullable_to_non_nullable
as String,deleteMessages: null == deleteMessages ? _self.deleteMessages : deleteMessages // ignore: cast_nullable_to_non_nullable
as String,createPolls: null == createPolls ? _self.createPolls : createPolls // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConversationPermissions].
extension ConversationPermissionsPatterns on ConversationPermissions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationPermissions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationPermissions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationPermissions value)  $default,){
final _that = this;
switch (_that) {
case _ConversationPermissions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationPermissions value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationPermissions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int conversationId,  String sendMessages,  String addMembers,  String removeMembers,  String editGroupInfo,  String pinMessages,  String deleteMessages,  String createPolls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationPermissions() when $default != null:
return $default(_that.conversationId,_that.sendMessages,_that.addMembers,_that.removeMembers,_that.editGroupInfo,_that.pinMessages,_that.deleteMessages,_that.createPolls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int conversationId,  String sendMessages,  String addMembers,  String removeMembers,  String editGroupInfo,  String pinMessages,  String deleteMessages,  String createPolls)  $default,) {final _that = this;
switch (_that) {
case _ConversationPermissions():
return $default(_that.conversationId,_that.sendMessages,_that.addMembers,_that.removeMembers,_that.editGroupInfo,_that.pinMessages,_that.deleteMessages,_that.createPolls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int conversationId,  String sendMessages,  String addMembers,  String removeMembers,  String editGroupInfo,  String pinMessages,  String deleteMessages,  String createPolls)?  $default,) {final _that = this;
switch (_that) {
case _ConversationPermissions() when $default != null:
return $default(_that.conversationId,_that.sendMessages,_that.addMembers,_that.removeMembers,_that.editGroupInfo,_that.pinMessages,_that.deleteMessages,_that.createPolls);case _:
  return null;

}
}

}

/// @nodoc


class _ConversationPermissions implements ConversationPermissions {
  const _ConversationPermissions({required this.conversationId, required this.sendMessages, required this.addMembers, required this.removeMembers, required this.editGroupInfo, required this.pinMessages, required this.deleteMessages, required this.createPolls});
  

@override final  int conversationId;
@override final  String sendMessages;
@override final  String addMembers;
@override final  String removeMembers;
@override final  String editGroupInfo;
@override final  String pinMessages;
@override final  String deleteMessages;
@override final  String createPolls;

/// Create a copy of ConversationPermissions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationPermissionsCopyWith<_ConversationPermissions> get copyWith => __$ConversationPermissionsCopyWithImpl<_ConversationPermissions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationPermissions&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.sendMessages, sendMessages) || other.sendMessages == sendMessages)&&(identical(other.addMembers, addMembers) || other.addMembers == addMembers)&&(identical(other.removeMembers, removeMembers) || other.removeMembers == removeMembers)&&(identical(other.editGroupInfo, editGroupInfo) || other.editGroupInfo == editGroupInfo)&&(identical(other.pinMessages, pinMessages) || other.pinMessages == pinMessages)&&(identical(other.deleteMessages, deleteMessages) || other.deleteMessages == deleteMessages)&&(identical(other.createPolls, createPolls) || other.createPolls == createPolls));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,sendMessages,addMembers,removeMembers,editGroupInfo,pinMessages,deleteMessages,createPolls);

@override
String toString() {
  return 'ConversationPermissions(conversationId: $conversationId, sendMessages: $sendMessages, addMembers: $addMembers, removeMembers: $removeMembers, editGroupInfo: $editGroupInfo, pinMessages: $pinMessages, deleteMessages: $deleteMessages, createPolls: $createPolls)';
}


}

/// @nodoc
abstract mixin class _$ConversationPermissionsCopyWith<$Res> implements $ConversationPermissionsCopyWith<$Res> {
  factory _$ConversationPermissionsCopyWith(_ConversationPermissions value, $Res Function(_ConversationPermissions) _then) = __$ConversationPermissionsCopyWithImpl;
@override @useResult
$Res call({
 int conversationId, String sendMessages, String addMembers, String removeMembers, String editGroupInfo, String pinMessages, String deleteMessages, String createPolls
});




}
/// @nodoc
class __$ConversationPermissionsCopyWithImpl<$Res>
    implements _$ConversationPermissionsCopyWith<$Res> {
  __$ConversationPermissionsCopyWithImpl(this._self, this._then);

  final _ConversationPermissions _self;
  final $Res Function(_ConversationPermissions) _then;

/// Create a copy of ConversationPermissions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? sendMessages = null,Object? addMembers = null,Object? removeMembers = null,Object? editGroupInfo = null,Object? pinMessages = null,Object? deleteMessages = null,Object? createPolls = null,}) {
  return _then(_ConversationPermissions(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as int,sendMessages: null == sendMessages ? _self.sendMessages : sendMessages // ignore: cast_nullable_to_non_nullable
as String,addMembers: null == addMembers ? _self.addMembers : addMembers // ignore: cast_nullable_to_non_nullable
as String,removeMembers: null == removeMembers ? _self.removeMembers : removeMembers // ignore: cast_nullable_to_non_nullable
as String,editGroupInfo: null == editGroupInfo ? _self.editGroupInfo : editGroupInfo // ignore: cast_nullable_to_non_nullable
as String,pinMessages: null == pinMessages ? _self.pinMessages : pinMessages // ignore: cast_nullable_to_non_nullable
as String,deleteMessages: null == deleteMessages ? _self.deleteMessages : deleteMessages // ignore: cast_nullable_to_non_nullable
as String,createPolls: null == createPolls ? _self.createPolls : createPolls // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$MutedMember {

 int get userId; String get username; String get fullName; bool get muted; DateTime? get mutedUntil; DateTime? get mutedAt; int? get mutedBy;
/// Create a copy of MutedMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MutedMemberCopyWith<MutedMember> get copyWith => _$MutedMemberCopyWithImpl<MutedMember>(this as MutedMember, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MutedMember&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.mutedUntil, mutedUntil) || other.mutedUntil == mutedUntil)&&(identical(other.mutedAt, mutedAt) || other.mutedAt == mutedAt)&&(identical(other.mutedBy, mutedBy) || other.mutedBy == mutedBy));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,muted,mutedUntil,mutedAt,mutedBy);

@override
String toString() {
  return 'MutedMember(userId: $userId, username: $username, fullName: $fullName, muted: $muted, mutedUntil: $mutedUntil, mutedAt: $mutedAt, mutedBy: $mutedBy)';
}


}

/// @nodoc
abstract mixin class $MutedMemberCopyWith<$Res>  {
  factory $MutedMemberCopyWith(MutedMember value, $Res Function(MutedMember) _then) = _$MutedMemberCopyWithImpl;
@useResult
$Res call({
 int userId, String username, String fullName, bool muted, DateTime? mutedUntil, DateTime? mutedAt, int? mutedBy
});




}
/// @nodoc
class _$MutedMemberCopyWithImpl<$Res>
    implements $MutedMemberCopyWith<$Res> {
  _$MutedMemberCopyWithImpl(this._self, this._then);

  final MutedMember _self;
  final $Res Function(MutedMember) _then;

/// Create a copy of MutedMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? muted = null,Object? mutedUntil = freezed,Object? mutedAt = freezed,Object? mutedBy = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool,mutedUntil: freezed == mutedUntil ? _self.mutedUntil : mutedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,mutedAt: freezed == mutedAt ? _self.mutedAt : mutedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,mutedBy: freezed == mutedBy ? _self.mutedBy : mutedBy // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MutedMember].
extension MutedMemberPatterns on MutedMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MutedMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MutedMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MutedMember value)  $default,){
final _that = this;
switch (_that) {
case _MutedMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MutedMember value)?  $default,){
final _that = this;
switch (_that) {
case _MutedMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userId,  String username,  String fullName,  bool muted,  DateTime? mutedUntil,  DateTime? mutedAt,  int? mutedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MutedMember() when $default != null:
return $default(_that.userId,_that.username,_that.fullName,_that.muted,_that.mutedUntil,_that.mutedAt,_that.mutedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userId,  String username,  String fullName,  bool muted,  DateTime? mutedUntil,  DateTime? mutedAt,  int? mutedBy)  $default,) {final _that = this;
switch (_that) {
case _MutedMember():
return $default(_that.userId,_that.username,_that.fullName,_that.muted,_that.mutedUntil,_that.mutedAt,_that.mutedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userId,  String username,  String fullName,  bool muted,  DateTime? mutedUntil,  DateTime? mutedAt,  int? mutedBy)?  $default,) {final _that = this;
switch (_that) {
case _MutedMember() when $default != null:
return $default(_that.userId,_that.username,_that.fullName,_that.muted,_that.mutedUntil,_that.mutedAt,_that.mutedBy);case _:
  return null;

}
}

}

/// @nodoc


class _MutedMember implements MutedMember {
  const _MutedMember({required this.userId, required this.username, required this.fullName, required this.muted, this.mutedUntil, this.mutedAt, this.mutedBy});
  

@override final  int userId;
@override final  String username;
@override final  String fullName;
@override final  bool muted;
@override final  DateTime? mutedUntil;
@override final  DateTime? mutedAt;
@override final  int? mutedBy;

/// Create a copy of MutedMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MutedMemberCopyWith<_MutedMember> get copyWith => __$MutedMemberCopyWithImpl<_MutedMember>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MutedMember&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.mutedUntil, mutedUntil) || other.mutedUntil == mutedUntil)&&(identical(other.mutedAt, mutedAt) || other.mutedAt == mutedAt)&&(identical(other.mutedBy, mutedBy) || other.mutedBy == mutedBy));
}


@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,muted,mutedUntil,mutedAt,mutedBy);

@override
String toString() {
  return 'MutedMember(userId: $userId, username: $username, fullName: $fullName, muted: $muted, mutedUntil: $mutedUntil, mutedAt: $mutedAt, mutedBy: $mutedBy)';
}


}

/// @nodoc
abstract mixin class _$MutedMemberCopyWith<$Res> implements $MutedMemberCopyWith<$Res> {
  factory _$MutedMemberCopyWith(_MutedMember value, $Res Function(_MutedMember) _then) = __$MutedMemberCopyWithImpl;
@override @useResult
$Res call({
 int userId, String username, String fullName, bool muted, DateTime? mutedUntil, DateTime? mutedAt, int? mutedBy
});




}
/// @nodoc
class __$MutedMemberCopyWithImpl<$Res>
    implements _$MutedMemberCopyWith<$Res> {
  __$MutedMemberCopyWithImpl(this._self, this._then);

  final _MutedMember _self;
  final $Res Function(_MutedMember) _then;

/// Create a copy of MutedMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? muted = null,Object? mutedUntil = freezed,Object? mutedAt = freezed,Object? mutedBy = freezed,}) {
  return _then(_MutedMember(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool,mutedUntil: freezed == mutedUntil ? _self.mutedUntil : mutedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,mutedAt: freezed == mutedAt ? _self.mutedAt : mutedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,mutedBy: freezed == mutedBy ? _self.mutedBy : mutedBy // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
