// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConversationSettingsModel {

 int get conversationId; bool get muted; bool get blocked; bool get notificationsEnabled; bool get pinned; int? get pinOrder; bool get archived; bool get hidden; String? get customNickname; String? get theme;
/// Create a copy of ConversationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationSettingsModelCopyWith<ConversationSettingsModel> get copyWith => _$ConversationSettingsModelCopyWithImpl<ConversationSettingsModel>(this as ConversationSettingsModel, _$identity);

  /// Serializes this ConversationSettingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationSettingsModel&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.blocked, blocked) || other.blocked == blocked)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.pinOrder, pinOrder) || other.pinOrder == pinOrder)&&(identical(other.archived, archived) || other.archived == archived)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.customNickname, customNickname) || other.customNickname == customNickname)&&(identical(other.theme, theme) || other.theme == theme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationId,muted,blocked,notificationsEnabled,pinned,pinOrder,archived,hidden,customNickname,theme);

@override
String toString() {
  return 'ConversationSettingsModel(conversationId: $conversationId, muted: $muted, blocked: $blocked, notificationsEnabled: $notificationsEnabled, pinned: $pinned, pinOrder: $pinOrder, archived: $archived, hidden: $hidden, customNickname: $customNickname, theme: $theme)';
}


}

/// @nodoc
abstract mixin class $ConversationSettingsModelCopyWith<$Res>  {
  factory $ConversationSettingsModelCopyWith(ConversationSettingsModel value, $Res Function(ConversationSettingsModel) _then) = _$ConversationSettingsModelCopyWithImpl;
@useResult
$Res call({
 int conversationId, bool muted, bool blocked, bool notificationsEnabled, bool pinned, int? pinOrder, bool archived, bool hidden, String? customNickname, String? theme
});




}
/// @nodoc
class _$ConversationSettingsModelCopyWithImpl<$Res>
    implements $ConversationSettingsModelCopyWith<$Res> {
  _$ConversationSettingsModelCopyWithImpl(this._self, this._then);

  final ConversationSettingsModel _self;
  final $Res Function(ConversationSettingsModel) _then;

/// Create a copy of ConversationSettingsModel
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


/// Adds pattern-matching-related methods to [ConversationSettingsModel].
extension ConversationSettingsModelPatterns on ConversationSettingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationSettingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationSettingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationSettingsModel value)  $default,){
final _that = this;
switch (_that) {
case _ConversationSettingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationSettingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationSettingsModel() when $default != null:
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
case _ConversationSettingsModel() when $default != null:
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
case _ConversationSettingsModel():
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
case _ConversationSettingsModel() when $default != null:
return $default(_that.conversationId,_that.muted,_that.blocked,_that.notificationsEnabled,_that.pinned,_that.pinOrder,_that.archived,_that.hidden,_that.customNickname,_that.theme);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConversationSettingsModel extends ConversationSettingsModel {
  const _ConversationSettingsModel({required this.conversationId, this.muted = false, this.blocked = false, this.notificationsEnabled = true, this.pinned = false, this.pinOrder, this.archived = false, this.hidden = false, this.customNickname, this.theme}): super._();
  factory _ConversationSettingsModel.fromJson(Map<String, dynamic> json) => _$ConversationSettingsModelFromJson(json);

@override final  int conversationId;
@override@JsonKey() final  bool muted;
@override@JsonKey() final  bool blocked;
@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey() final  bool pinned;
@override final  int? pinOrder;
@override@JsonKey() final  bool archived;
@override@JsonKey() final  bool hidden;
@override final  String? customNickname;
@override final  String? theme;

/// Create a copy of ConversationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationSettingsModelCopyWith<_ConversationSettingsModel> get copyWith => __$ConversationSettingsModelCopyWithImpl<_ConversationSettingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationSettingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationSettingsModel&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.blocked, blocked) || other.blocked == blocked)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.pinOrder, pinOrder) || other.pinOrder == pinOrder)&&(identical(other.archived, archived) || other.archived == archived)&&(identical(other.hidden, hidden) || other.hidden == hidden)&&(identical(other.customNickname, customNickname) || other.customNickname == customNickname)&&(identical(other.theme, theme) || other.theme == theme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationId,muted,blocked,notificationsEnabled,pinned,pinOrder,archived,hidden,customNickname,theme);

@override
String toString() {
  return 'ConversationSettingsModel(conversationId: $conversationId, muted: $muted, blocked: $blocked, notificationsEnabled: $notificationsEnabled, pinned: $pinned, pinOrder: $pinOrder, archived: $archived, hidden: $hidden, customNickname: $customNickname, theme: $theme)';
}


}

/// @nodoc
abstract mixin class _$ConversationSettingsModelCopyWith<$Res> implements $ConversationSettingsModelCopyWith<$Res> {
  factory _$ConversationSettingsModelCopyWith(_ConversationSettingsModel value, $Res Function(_ConversationSettingsModel) _then) = __$ConversationSettingsModelCopyWithImpl;
@override @useResult
$Res call({
 int conversationId, bool muted, bool blocked, bool notificationsEnabled, bool pinned, int? pinOrder, bool archived, bool hidden, String? customNickname, String? theme
});




}
/// @nodoc
class __$ConversationSettingsModelCopyWithImpl<$Res>
    implements _$ConversationSettingsModelCopyWith<$Res> {
  __$ConversationSettingsModelCopyWithImpl(this._self, this._then);

  final _ConversationSettingsModel _self;
  final $Res Function(_ConversationSettingsModel) _then;

/// Create a copy of ConversationSettingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? muted = null,Object? blocked = null,Object? notificationsEnabled = null,Object? pinned = null,Object? pinOrder = freezed,Object? archived = null,Object? hidden = null,Object? customNickname = freezed,Object? theme = freezed,}) {
  return _then(_ConversationSettingsModel(
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
mixin _$UpdateConversationSettingsRequest {

 bool? get notificationsEnabled; String? get customNickname; String? get theme;
/// Create a copy of UpdateConversationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateConversationSettingsRequestCopyWith<UpdateConversationSettingsRequest> get copyWith => _$UpdateConversationSettingsRequestCopyWithImpl<UpdateConversationSettingsRequest>(this as UpdateConversationSettingsRequest, _$identity);

  /// Serializes this UpdateConversationSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateConversationSettingsRequest&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.customNickname, customNickname) || other.customNickname == customNickname)&&(identical(other.theme, theme) || other.theme == theme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationsEnabled,customNickname,theme);

@override
String toString() {
  return 'UpdateConversationSettingsRequest(notificationsEnabled: $notificationsEnabled, customNickname: $customNickname, theme: $theme)';
}


}

/// @nodoc
abstract mixin class $UpdateConversationSettingsRequestCopyWith<$Res>  {
  factory $UpdateConversationSettingsRequestCopyWith(UpdateConversationSettingsRequest value, $Res Function(UpdateConversationSettingsRequest) _then) = _$UpdateConversationSettingsRequestCopyWithImpl;
@useResult
$Res call({
 bool? notificationsEnabled, String? customNickname, String? theme
});




}
/// @nodoc
class _$UpdateConversationSettingsRequestCopyWithImpl<$Res>
    implements $UpdateConversationSettingsRequestCopyWith<$Res> {
  _$UpdateConversationSettingsRequestCopyWithImpl(this._self, this._then);

  final UpdateConversationSettingsRequest _self;
  final $Res Function(UpdateConversationSettingsRequest) _then;

/// Create a copy of UpdateConversationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationsEnabled = freezed,Object? customNickname = freezed,Object? theme = freezed,}) {
  return _then(_self.copyWith(
notificationsEnabled: freezed == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,customNickname: freezed == customNickname ? _self.customNickname : customNickname // ignore: cast_nullable_to_non_nullable
as String?,theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateConversationSettingsRequest].
extension UpdateConversationSettingsRequestPatterns on UpdateConversationSettingsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateConversationSettingsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateConversationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateConversationSettingsRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateConversationSettingsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateConversationSettingsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateConversationSettingsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? notificationsEnabled,  String? customNickname,  String? theme)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateConversationSettingsRequest() when $default != null:
return $default(_that.notificationsEnabled,_that.customNickname,_that.theme);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? notificationsEnabled,  String? customNickname,  String? theme)  $default,) {final _that = this;
switch (_that) {
case _UpdateConversationSettingsRequest():
return $default(_that.notificationsEnabled,_that.customNickname,_that.theme);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? notificationsEnabled,  String? customNickname,  String? theme)?  $default,) {final _that = this;
switch (_that) {
case _UpdateConversationSettingsRequest() when $default != null:
return $default(_that.notificationsEnabled,_that.customNickname,_that.theme);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateConversationSettingsRequest implements UpdateConversationSettingsRequest {
  const _UpdateConversationSettingsRequest({this.notificationsEnabled, this.customNickname, this.theme});
  factory _UpdateConversationSettingsRequest.fromJson(Map<String, dynamic> json) => _$UpdateConversationSettingsRequestFromJson(json);

@override final  bool? notificationsEnabled;
@override final  String? customNickname;
@override final  String? theme;

/// Create a copy of UpdateConversationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateConversationSettingsRequestCopyWith<_UpdateConversationSettingsRequest> get copyWith => __$UpdateConversationSettingsRequestCopyWithImpl<_UpdateConversationSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateConversationSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateConversationSettingsRequest&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.customNickname, customNickname) || other.customNickname == customNickname)&&(identical(other.theme, theme) || other.theme == theme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,notificationsEnabled,customNickname,theme);

@override
String toString() {
  return 'UpdateConversationSettingsRequest(notificationsEnabled: $notificationsEnabled, customNickname: $customNickname, theme: $theme)';
}


}

/// @nodoc
abstract mixin class _$UpdateConversationSettingsRequestCopyWith<$Res> implements $UpdateConversationSettingsRequestCopyWith<$Res> {
  factory _$UpdateConversationSettingsRequestCopyWith(_UpdateConversationSettingsRequest value, $Res Function(_UpdateConversationSettingsRequest) _then) = __$UpdateConversationSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
 bool? notificationsEnabled, String? customNickname, String? theme
});




}
/// @nodoc
class __$UpdateConversationSettingsRequestCopyWithImpl<$Res>
    implements _$UpdateConversationSettingsRequestCopyWith<$Res> {
  __$UpdateConversationSettingsRequestCopyWithImpl(this._self, this._then);

  final _UpdateConversationSettingsRequest _self;
  final $Res Function(_UpdateConversationSettingsRequest) _then;

/// Create a copy of UpdateConversationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationsEnabled = freezed,Object? customNickname = freezed,Object? theme = freezed,}) {
  return _then(_UpdateConversationSettingsRequest(
notificationsEnabled: freezed == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,customNickname: freezed == customNickname ? _self.customNickname : customNickname // ignore: cast_nullable_to_non_nullable
as String?,theme: freezed == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ConversationPermissionsModel {

 int get conversationId; String get sendMessages; String get addMembers; String get removeMembers; String get editGroupInfo; String get pinMessages; String get deleteMessages; String get createPolls;
/// Create a copy of ConversationPermissionsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationPermissionsModelCopyWith<ConversationPermissionsModel> get copyWith => _$ConversationPermissionsModelCopyWithImpl<ConversationPermissionsModel>(this as ConversationPermissionsModel, _$identity);

  /// Serializes this ConversationPermissionsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationPermissionsModel&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.sendMessages, sendMessages) || other.sendMessages == sendMessages)&&(identical(other.addMembers, addMembers) || other.addMembers == addMembers)&&(identical(other.removeMembers, removeMembers) || other.removeMembers == removeMembers)&&(identical(other.editGroupInfo, editGroupInfo) || other.editGroupInfo == editGroupInfo)&&(identical(other.pinMessages, pinMessages) || other.pinMessages == pinMessages)&&(identical(other.deleteMessages, deleteMessages) || other.deleteMessages == deleteMessages)&&(identical(other.createPolls, createPolls) || other.createPolls == createPolls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationId,sendMessages,addMembers,removeMembers,editGroupInfo,pinMessages,deleteMessages,createPolls);

@override
String toString() {
  return 'ConversationPermissionsModel(conversationId: $conversationId, sendMessages: $sendMessages, addMembers: $addMembers, removeMembers: $removeMembers, editGroupInfo: $editGroupInfo, pinMessages: $pinMessages, deleteMessages: $deleteMessages, createPolls: $createPolls)';
}


}

/// @nodoc
abstract mixin class $ConversationPermissionsModelCopyWith<$Res>  {
  factory $ConversationPermissionsModelCopyWith(ConversationPermissionsModel value, $Res Function(ConversationPermissionsModel) _then) = _$ConversationPermissionsModelCopyWithImpl;
@useResult
$Res call({
 int conversationId, String sendMessages, String addMembers, String removeMembers, String editGroupInfo, String pinMessages, String deleteMessages, String createPolls
});




}
/// @nodoc
class _$ConversationPermissionsModelCopyWithImpl<$Res>
    implements $ConversationPermissionsModelCopyWith<$Res> {
  _$ConversationPermissionsModelCopyWithImpl(this._self, this._then);

  final ConversationPermissionsModel _self;
  final $Res Function(ConversationPermissionsModel) _then;

/// Create a copy of ConversationPermissionsModel
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


/// Adds pattern-matching-related methods to [ConversationPermissionsModel].
extension ConversationPermissionsModelPatterns on ConversationPermissionsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationPermissionsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationPermissionsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationPermissionsModel value)  $default,){
final _that = this;
switch (_that) {
case _ConversationPermissionsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationPermissionsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationPermissionsModel() when $default != null:
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
case _ConversationPermissionsModel() when $default != null:
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
case _ConversationPermissionsModel():
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
case _ConversationPermissionsModel() when $default != null:
return $default(_that.conversationId,_that.sendMessages,_that.addMembers,_that.removeMembers,_that.editGroupInfo,_that.pinMessages,_that.deleteMessages,_that.createPolls);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConversationPermissionsModel implements ConversationPermissionsModel {
  const _ConversationPermissionsModel({required this.conversationId, this.sendMessages = 'ALL', this.addMembers = 'ADMIN_ONLY', this.removeMembers = 'ADMIN_ONLY', this.editGroupInfo = 'ADMIN_ONLY', this.pinMessages = 'ADMIN_ONLY', this.deleteMessages = 'ADMIN_ONLY', this.createPolls = 'ALL'});
  factory _ConversationPermissionsModel.fromJson(Map<String, dynamic> json) => _$ConversationPermissionsModelFromJson(json);

@override final  int conversationId;
@override@JsonKey() final  String sendMessages;
@override@JsonKey() final  String addMembers;
@override@JsonKey() final  String removeMembers;
@override@JsonKey() final  String editGroupInfo;
@override@JsonKey() final  String pinMessages;
@override@JsonKey() final  String deleteMessages;
@override@JsonKey() final  String createPolls;

/// Create a copy of ConversationPermissionsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationPermissionsModelCopyWith<_ConversationPermissionsModel> get copyWith => __$ConversationPermissionsModelCopyWithImpl<_ConversationPermissionsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationPermissionsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationPermissionsModel&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.sendMessages, sendMessages) || other.sendMessages == sendMessages)&&(identical(other.addMembers, addMembers) || other.addMembers == addMembers)&&(identical(other.removeMembers, removeMembers) || other.removeMembers == removeMembers)&&(identical(other.editGroupInfo, editGroupInfo) || other.editGroupInfo == editGroupInfo)&&(identical(other.pinMessages, pinMessages) || other.pinMessages == pinMessages)&&(identical(other.deleteMessages, deleteMessages) || other.deleteMessages == deleteMessages)&&(identical(other.createPolls, createPolls) || other.createPolls == createPolls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conversationId,sendMessages,addMembers,removeMembers,editGroupInfo,pinMessages,deleteMessages,createPolls);

@override
String toString() {
  return 'ConversationPermissionsModel(conversationId: $conversationId, sendMessages: $sendMessages, addMembers: $addMembers, removeMembers: $removeMembers, editGroupInfo: $editGroupInfo, pinMessages: $pinMessages, deleteMessages: $deleteMessages, createPolls: $createPolls)';
}


}

/// @nodoc
abstract mixin class _$ConversationPermissionsModelCopyWith<$Res> implements $ConversationPermissionsModelCopyWith<$Res> {
  factory _$ConversationPermissionsModelCopyWith(_ConversationPermissionsModel value, $Res Function(_ConversationPermissionsModel) _then) = __$ConversationPermissionsModelCopyWithImpl;
@override @useResult
$Res call({
 int conversationId, String sendMessages, String addMembers, String removeMembers, String editGroupInfo, String pinMessages, String deleteMessages, String createPolls
});




}
/// @nodoc
class __$ConversationPermissionsModelCopyWithImpl<$Res>
    implements _$ConversationPermissionsModelCopyWith<$Res> {
  __$ConversationPermissionsModelCopyWithImpl(this._self, this._then);

  final _ConversationPermissionsModel _self;
  final $Res Function(_ConversationPermissionsModel) _then;

/// Create a copy of ConversationPermissionsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? sendMessages = null,Object? addMembers = null,Object? removeMembers = null,Object? editGroupInfo = null,Object? pinMessages = null,Object? deleteMessages = null,Object? createPolls = null,}) {
  return _then(_ConversationPermissionsModel(
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
mixin _$UpdateConversationPermissionsRequest {

 String? get sendMessages; String? get addMembers; String? get removeMembers; String? get editGroupInfo; String? get pinMessages; String? get deleteMessages; String? get createPolls;
/// Create a copy of UpdateConversationPermissionsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateConversationPermissionsRequestCopyWith<UpdateConversationPermissionsRequest> get copyWith => _$UpdateConversationPermissionsRequestCopyWithImpl<UpdateConversationPermissionsRequest>(this as UpdateConversationPermissionsRequest, _$identity);

  /// Serializes this UpdateConversationPermissionsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateConversationPermissionsRequest&&(identical(other.sendMessages, sendMessages) || other.sendMessages == sendMessages)&&(identical(other.addMembers, addMembers) || other.addMembers == addMembers)&&(identical(other.removeMembers, removeMembers) || other.removeMembers == removeMembers)&&(identical(other.editGroupInfo, editGroupInfo) || other.editGroupInfo == editGroupInfo)&&(identical(other.pinMessages, pinMessages) || other.pinMessages == pinMessages)&&(identical(other.deleteMessages, deleteMessages) || other.deleteMessages == deleteMessages)&&(identical(other.createPolls, createPolls) || other.createPolls == createPolls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sendMessages,addMembers,removeMembers,editGroupInfo,pinMessages,deleteMessages,createPolls);

@override
String toString() {
  return 'UpdateConversationPermissionsRequest(sendMessages: $sendMessages, addMembers: $addMembers, removeMembers: $removeMembers, editGroupInfo: $editGroupInfo, pinMessages: $pinMessages, deleteMessages: $deleteMessages, createPolls: $createPolls)';
}


}

/// @nodoc
abstract mixin class $UpdateConversationPermissionsRequestCopyWith<$Res>  {
  factory $UpdateConversationPermissionsRequestCopyWith(UpdateConversationPermissionsRequest value, $Res Function(UpdateConversationPermissionsRequest) _then) = _$UpdateConversationPermissionsRequestCopyWithImpl;
@useResult
$Res call({
 String? sendMessages, String? addMembers, String? removeMembers, String? editGroupInfo, String? pinMessages, String? deleteMessages, String? createPolls
});




}
/// @nodoc
class _$UpdateConversationPermissionsRequestCopyWithImpl<$Res>
    implements $UpdateConversationPermissionsRequestCopyWith<$Res> {
  _$UpdateConversationPermissionsRequestCopyWithImpl(this._self, this._then);

  final UpdateConversationPermissionsRequest _self;
  final $Res Function(UpdateConversationPermissionsRequest) _then;

/// Create a copy of UpdateConversationPermissionsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sendMessages = freezed,Object? addMembers = freezed,Object? removeMembers = freezed,Object? editGroupInfo = freezed,Object? pinMessages = freezed,Object? deleteMessages = freezed,Object? createPolls = freezed,}) {
  return _then(_self.copyWith(
sendMessages: freezed == sendMessages ? _self.sendMessages : sendMessages // ignore: cast_nullable_to_non_nullable
as String?,addMembers: freezed == addMembers ? _self.addMembers : addMembers // ignore: cast_nullable_to_non_nullable
as String?,removeMembers: freezed == removeMembers ? _self.removeMembers : removeMembers // ignore: cast_nullable_to_non_nullable
as String?,editGroupInfo: freezed == editGroupInfo ? _self.editGroupInfo : editGroupInfo // ignore: cast_nullable_to_non_nullable
as String?,pinMessages: freezed == pinMessages ? _self.pinMessages : pinMessages // ignore: cast_nullable_to_non_nullable
as String?,deleteMessages: freezed == deleteMessages ? _self.deleteMessages : deleteMessages // ignore: cast_nullable_to_non_nullable
as String?,createPolls: freezed == createPolls ? _self.createPolls : createPolls // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateConversationPermissionsRequest].
extension UpdateConversationPermissionsRequestPatterns on UpdateConversationPermissionsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateConversationPermissionsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateConversationPermissionsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateConversationPermissionsRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateConversationPermissionsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateConversationPermissionsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateConversationPermissionsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? sendMessages,  String? addMembers,  String? removeMembers,  String? editGroupInfo,  String? pinMessages,  String? deleteMessages,  String? createPolls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateConversationPermissionsRequest() when $default != null:
return $default(_that.sendMessages,_that.addMembers,_that.removeMembers,_that.editGroupInfo,_that.pinMessages,_that.deleteMessages,_that.createPolls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? sendMessages,  String? addMembers,  String? removeMembers,  String? editGroupInfo,  String? pinMessages,  String? deleteMessages,  String? createPolls)  $default,) {final _that = this;
switch (_that) {
case _UpdateConversationPermissionsRequest():
return $default(_that.sendMessages,_that.addMembers,_that.removeMembers,_that.editGroupInfo,_that.pinMessages,_that.deleteMessages,_that.createPolls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? sendMessages,  String? addMembers,  String? removeMembers,  String? editGroupInfo,  String? pinMessages,  String? deleteMessages,  String? createPolls)?  $default,) {final _that = this;
switch (_that) {
case _UpdateConversationPermissionsRequest() when $default != null:
return $default(_that.sendMessages,_that.addMembers,_that.removeMembers,_that.editGroupInfo,_that.pinMessages,_that.deleteMessages,_that.createPolls);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateConversationPermissionsRequest implements UpdateConversationPermissionsRequest {
  const _UpdateConversationPermissionsRequest({this.sendMessages, this.addMembers, this.removeMembers, this.editGroupInfo, this.pinMessages, this.deleteMessages, this.createPolls});
  factory _UpdateConversationPermissionsRequest.fromJson(Map<String, dynamic> json) => _$UpdateConversationPermissionsRequestFromJson(json);

@override final  String? sendMessages;
@override final  String? addMembers;
@override final  String? removeMembers;
@override final  String? editGroupInfo;
@override final  String? pinMessages;
@override final  String? deleteMessages;
@override final  String? createPolls;

/// Create a copy of UpdateConversationPermissionsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateConversationPermissionsRequestCopyWith<_UpdateConversationPermissionsRequest> get copyWith => __$UpdateConversationPermissionsRequestCopyWithImpl<_UpdateConversationPermissionsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateConversationPermissionsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateConversationPermissionsRequest&&(identical(other.sendMessages, sendMessages) || other.sendMessages == sendMessages)&&(identical(other.addMembers, addMembers) || other.addMembers == addMembers)&&(identical(other.removeMembers, removeMembers) || other.removeMembers == removeMembers)&&(identical(other.editGroupInfo, editGroupInfo) || other.editGroupInfo == editGroupInfo)&&(identical(other.pinMessages, pinMessages) || other.pinMessages == pinMessages)&&(identical(other.deleteMessages, deleteMessages) || other.deleteMessages == deleteMessages)&&(identical(other.createPolls, createPolls) || other.createPolls == createPolls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sendMessages,addMembers,removeMembers,editGroupInfo,pinMessages,deleteMessages,createPolls);

@override
String toString() {
  return 'UpdateConversationPermissionsRequest(sendMessages: $sendMessages, addMembers: $addMembers, removeMembers: $removeMembers, editGroupInfo: $editGroupInfo, pinMessages: $pinMessages, deleteMessages: $deleteMessages, createPolls: $createPolls)';
}


}

/// @nodoc
abstract mixin class _$UpdateConversationPermissionsRequestCopyWith<$Res> implements $UpdateConversationPermissionsRequestCopyWith<$Res> {
  factory _$UpdateConversationPermissionsRequestCopyWith(_UpdateConversationPermissionsRequest value, $Res Function(_UpdateConversationPermissionsRequest) _then) = __$UpdateConversationPermissionsRequestCopyWithImpl;
@override @useResult
$Res call({
 String? sendMessages, String? addMembers, String? removeMembers, String? editGroupInfo, String? pinMessages, String? deleteMessages, String? createPolls
});




}
/// @nodoc
class __$UpdateConversationPermissionsRequestCopyWithImpl<$Res>
    implements _$UpdateConversationPermissionsRequestCopyWith<$Res> {
  __$UpdateConversationPermissionsRequestCopyWithImpl(this._self, this._then);

  final _UpdateConversationPermissionsRequest _self;
  final $Res Function(_UpdateConversationPermissionsRequest) _then;

/// Create a copy of UpdateConversationPermissionsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sendMessages = freezed,Object? addMembers = freezed,Object? removeMembers = freezed,Object? editGroupInfo = freezed,Object? pinMessages = freezed,Object? deleteMessages = freezed,Object? createPolls = freezed,}) {
  return _then(_UpdateConversationPermissionsRequest(
sendMessages: freezed == sendMessages ? _self.sendMessages : sendMessages // ignore: cast_nullable_to_non_nullable
as String?,addMembers: freezed == addMembers ? _self.addMembers : addMembers // ignore: cast_nullable_to_non_nullable
as String?,removeMembers: freezed == removeMembers ? _self.removeMembers : removeMembers // ignore: cast_nullable_to_non_nullable
as String?,editGroupInfo: freezed == editGroupInfo ? _self.editGroupInfo : editGroupInfo // ignore: cast_nullable_to_non_nullable
as String?,pinMessages: freezed == pinMessages ? _self.pinMessages : pinMessages // ignore: cast_nullable_to_non_nullable
as String?,deleteMessages: freezed == deleteMessages ? _self.deleteMessages : deleteMessages // ignore: cast_nullable_to_non_nullable
as String?,createPolls: freezed == createPolls ? _self.createPolls : createPolls // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MuteMemberRequest {

 int get duration;
/// Create a copy of MuteMemberRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MuteMemberRequestCopyWith<MuteMemberRequest> get copyWith => _$MuteMemberRequestCopyWithImpl<MuteMemberRequest>(this as MuteMemberRequest, _$identity);

  /// Serializes this MuteMemberRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MuteMemberRequest&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,duration);

@override
String toString() {
  return 'MuteMemberRequest(duration: $duration)';
}


}

/// @nodoc
abstract mixin class $MuteMemberRequestCopyWith<$Res>  {
  factory $MuteMemberRequestCopyWith(MuteMemberRequest value, $Res Function(MuteMemberRequest) _then) = _$MuteMemberRequestCopyWithImpl;
@useResult
$Res call({
 int duration
});




}
/// @nodoc
class _$MuteMemberRequestCopyWithImpl<$Res>
    implements $MuteMemberRequestCopyWith<$Res> {
  _$MuteMemberRequestCopyWithImpl(this._self, this._then);

  final MuteMemberRequest _self;
  final $Res Function(MuteMemberRequest) _then;

/// Create a copy of MuteMemberRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? duration = null,}) {
  return _then(_self.copyWith(
duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MuteMemberRequest].
extension MuteMemberRequestPatterns on MuteMemberRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MuteMemberRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MuteMemberRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MuteMemberRequest value)  $default,){
final _that = this;
switch (_that) {
case _MuteMemberRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MuteMemberRequest value)?  $default,){
final _that = this;
switch (_that) {
case _MuteMemberRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MuteMemberRequest() when $default != null:
return $default(_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int duration)  $default,) {final _that = this;
switch (_that) {
case _MuteMemberRequest():
return $default(_that.duration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int duration)?  $default,) {final _that = this;
switch (_that) {
case _MuteMemberRequest() when $default != null:
return $default(_that.duration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MuteMemberRequest implements MuteMemberRequest {
  const _MuteMemberRequest({required this.duration});
  factory _MuteMemberRequest.fromJson(Map<String, dynamic> json) => _$MuteMemberRequestFromJson(json);

@override final  int duration;

/// Create a copy of MuteMemberRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MuteMemberRequestCopyWith<_MuteMemberRequest> get copyWith => __$MuteMemberRequestCopyWithImpl<_MuteMemberRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MuteMemberRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MuteMemberRequest&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,duration);

@override
String toString() {
  return 'MuteMemberRequest(duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$MuteMemberRequestCopyWith<$Res> implements $MuteMemberRequestCopyWith<$Res> {
  factory _$MuteMemberRequestCopyWith(_MuteMemberRequest value, $Res Function(_MuteMemberRequest) _then) = __$MuteMemberRequestCopyWithImpl;
@override @useResult
$Res call({
 int duration
});




}
/// @nodoc
class __$MuteMemberRequestCopyWithImpl<$Res>
    implements _$MuteMemberRequestCopyWith<$Res> {
  __$MuteMemberRequestCopyWithImpl(this._self, this._then);

  final _MuteMemberRequest _self;
  final $Res Function(_MuteMemberRequest) _then;

/// Create a copy of MuteMemberRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? duration = null,}) {
  return _then(_MuteMemberRequest(
duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MutedMemberModel {

 int get userId; String get username; String get fullName; bool get muted; DateTime? get mutedUntil; DateTime? get mutedAt; int? get mutedBy;
/// Create a copy of MutedMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MutedMemberModelCopyWith<MutedMemberModel> get copyWith => _$MutedMemberModelCopyWithImpl<MutedMemberModel>(this as MutedMemberModel, _$identity);

  /// Serializes this MutedMemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MutedMemberModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.mutedUntil, mutedUntil) || other.mutedUntil == mutedUntil)&&(identical(other.mutedAt, mutedAt) || other.mutedAt == mutedAt)&&(identical(other.mutedBy, mutedBy) || other.mutedBy == mutedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,muted,mutedUntil,mutedAt,mutedBy);

@override
String toString() {
  return 'MutedMemberModel(userId: $userId, username: $username, fullName: $fullName, muted: $muted, mutedUntil: $mutedUntil, mutedAt: $mutedAt, mutedBy: $mutedBy)';
}


}

/// @nodoc
abstract mixin class $MutedMemberModelCopyWith<$Res>  {
  factory $MutedMemberModelCopyWith(MutedMemberModel value, $Res Function(MutedMemberModel) _then) = _$MutedMemberModelCopyWithImpl;
@useResult
$Res call({
 int userId, String username, String fullName, bool muted, DateTime? mutedUntil, DateTime? mutedAt, int? mutedBy
});




}
/// @nodoc
class _$MutedMemberModelCopyWithImpl<$Res>
    implements $MutedMemberModelCopyWith<$Res> {
  _$MutedMemberModelCopyWithImpl(this._self, this._then);

  final MutedMemberModel _self;
  final $Res Function(MutedMemberModel) _then;

/// Create a copy of MutedMemberModel
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


/// Adds pattern-matching-related methods to [MutedMemberModel].
extension MutedMemberModelPatterns on MutedMemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MutedMemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MutedMemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MutedMemberModel value)  $default,){
final _that = this;
switch (_that) {
case _MutedMemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MutedMemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _MutedMemberModel() when $default != null:
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
case _MutedMemberModel() when $default != null:
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
case _MutedMemberModel():
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
case _MutedMemberModel() when $default != null:
return $default(_that.userId,_that.username,_that.fullName,_that.muted,_that.mutedUntil,_that.mutedAt,_that.mutedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MutedMemberModel implements MutedMemberModel {
  const _MutedMemberModel({required this.userId, required this.username, required this.fullName, required this.muted, this.mutedUntil, this.mutedAt, this.mutedBy});
  factory _MutedMemberModel.fromJson(Map<String, dynamic> json) => _$MutedMemberModelFromJson(json);

@override final  int userId;
@override final  String username;
@override final  String fullName;
@override final  bool muted;
@override final  DateTime? mutedUntil;
@override final  DateTime? mutedAt;
@override final  int? mutedBy;

/// Create a copy of MutedMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MutedMemberModelCopyWith<_MutedMemberModel> get copyWith => __$MutedMemberModelCopyWithImpl<_MutedMemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MutedMemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MutedMemberModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.mutedUntil, mutedUntil) || other.mutedUntil == mutedUntil)&&(identical(other.mutedAt, mutedAt) || other.mutedAt == mutedAt)&&(identical(other.mutedBy, mutedBy) || other.mutedBy == mutedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,username,fullName,muted,mutedUntil,mutedAt,mutedBy);

@override
String toString() {
  return 'MutedMemberModel(userId: $userId, username: $username, fullName: $fullName, muted: $muted, mutedUntil: $mutedUntil, mutedAt: $mutedAt, mutedBy: $mutedBy)';
}


}

/// @nodoc
abstract mixin class _$MutedMemberModelCopyWith<$Res> implements $MutedMemberModelCopyWith<$Res> {
  factory _$MutedMemberModelCopyWith(_MutedMemberModel value, $Res Function(_MutedMemberModel) _then) = __$MutedMemberModelCopyWithImpl;
@override @useResult
$Res call({
 int userId, String username, String fullName, bool muted, DateTime? mutedUntil, DateTime? mutedAt, int? mutedBy
});




}
/// @nodoc
class __$MutedMemberModelCopyWithImpl<$Res>
    implements _$MutedMemberModelCopyWith<$Res> {
  __$MutedMemberModelCopyWithImpl(this._self, this._then);

  final _MutedMemberModel _self;
  final $Res Function(_MutedMemberModel) _then;

/// Create a copy of MutedMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? username = null,Object? fullName = null,Object? muted = null,Object? mutedUntil = freezed,Object? mutedAt = freezed,Object? mutedBy = freezed,}) {
  return _then(_MutedMemberModel(
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
