// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'marked_unread_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider to manage conversations marked as unread by user
///
/// This is a local-only feature (mock implementation) until API is ready.
/// State is persisted in SharedPreferences.
///
/// **Features:**
/// - Mark conversation as unread (adds to set)
/// - Remove unread mark (removes from set)
/// - Check if conversation is marked unread
/// - Persist state across app restarts
///
/// **Future API Integration:**
/// When API endpoint is ready, replace SharedPreferences with API calls:
/// - POST /v1/conversations/{id}/mark-unread
/// - DELETE /v1/conversations/{id}/mark-unread

@ProviderFor(MarkedUnreadConversations)
const markedUnreadConversationsProvider = MarkedUnreadConversationsProvider._();

/// Provider to manage conversations marked as unread by user
///
/// This is a local-only feature (mock implementation) until API is ready.
/// State is persisted in SharedPreferences.
///
/// **Features:**
/// - Mark conversation as unread (adds to set)
/// - Remove unread mark (removes from set)
/// - Check if conversation is marked unread
/// - Persist state across app restarts
///
/// **Future API Integration:**
/// When API endpoint is ready, replace SharedPreferences with API calls:
/// - POST /v1/conversations/{id}/mark-unread
/// - DELETE /v1/conversations/{id}/mark-unread
final class MarkedUnreadConversationsProvider
    extends $NotifierProvider<MarkedUnreadConversations, Set<int>> {
  /// Provider to manage conversations marked as unread by user
  ///
  /// This is a local-only feature (mock implementation) until API is ready.
  /// State is persisted in SharedPreferences.
  ///
  /// **Features:**
  /// - Mark conversation as unread (adds to set)
  /// - Remove unread mark (removes from set)
  /// - Check if conversation is marked unread
  /// - Persist state across app restarts
  ///
  /// **Future API Integration:**
  /// When API endpoint is ready, replace SharedPreferences with API calls:
  /// - POST /v1/conversations/{id}/mark-unread
  /// - DELETE /v1/conversations/{id}/mark-unread
  const MarkedUnreadConversationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'markedUnreadConversationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markedUnreadConversationsHash();

  @$internal
  @override
  MarkedUnreadConversations create() => MarkedUnreadConversations();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<int>>(value),
    );
  }
}

String _$markedUnreadConversationsHash() =>
    r'6549df05b62052f442da8466633da7375108bdfa';

/// Provider to manage conversations marked as unread by user
///
/// This is a local-only feature (mock implementation) until API is ready.
/// State is persisted in SharedPreferences.
///
/// **Features:**
/// - Mark conversation as unread (adds to set)
/// - Remove unread mark (removes from set)
/// - Check if conversation is marked unread
/// - Persist state across app restarts
///
/// **Future API Integration:**
/// When API endpoint is ready, replace SharedPreferences with API calls:
/// - POST /v1/conversations/{id}/mark-unread
/// - DELETE /v1/conversations/{id}/mark-unread

abstract class _$MarkedUnreadConversations extends $Notifier<Set<int>> {
  Set<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<int>, Set<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<int>, Set<int>>,
              Set<int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
