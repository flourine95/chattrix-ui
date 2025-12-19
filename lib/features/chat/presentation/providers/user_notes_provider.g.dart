// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'user_notes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for user notes/stories
///
/// Uses mock data until API is available
/// TODO: Replace with API calls when backend is ready

@ProviderFor(UserNotes)
const userNotesProvider = UserNotesProvider._();

/// Provider for user notes/stories
///
/// Uses mock data until API is available
/// TODO: Replace with API calls when backend is ready
final class UserNotesProvider
    extends $NotifierProvider<UserNotes, Map<String, UserNoteEntity>> {
  /// Provider for user notes/stories
  ///
  /// Uses mock data until API is available
  /// TODO: Replace with API calls when backend is ready
  const UserNotesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userNotesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userNotesHash();

  @$internal
  @override
  UserNotes create() => UserNotes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, UserNoteEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, UserNoteEntity>>(value),
    );
  }
}

String _$userNotesHash() => r'5e116bb62395e0b29816a2a92218fca0f17965f0';

/// Provider for user notes/stories
///
/// Uses mock data until API is available
/// TODO: Replace with API calls when backend is ready

abstract class _$UserNotes extends $Notifier<Map<String, UserNoteEntity>> {
  Map<String, UserNoteEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<Map<String, UserNoteEntity>, Map<String, UserNoteEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, UserNoteEntity>,
                Map<String, UserNoteEntity>
              >,
              Map<String, UserNoteEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
