// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'online_users_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for managing online users list
///
/// Fetches online users from contacts and listens to WebSocket user status events
/// to update the list in real-time.

@ProviderFor(OnlineUsersNotifier)
const onlineUsersProvider = OnlineUsersNotifierProvider._();

/// Notifier for managing online users list
///
/// Fetches online users from contacts and listens to WebSocket user status events
/// to update the list in real-time.
final class OnlineUsersNotifierProvider
    extends $AsyncNotifierProvider<OnlineUsersNotifier, List<User>> {
  /// Notifier for managing online users list
  ///
  /// Fetches online users from contacts and listens to WebSocket user status events
  /// to update the list in real-time.
  const OnlineUsersNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onlineUsersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onlineUsersNotifierHash();

  @$internal
  @override
  OnlineUsersNotifier create() => OnlineUsersNotifier();
}

String _$onlineUsersNotifierHash() =>
    r'b6f7a1adfce5463ea6fdca67336be6cfd8a600be';

/// Notifier for managing online users list
///
/// Fetches online users from contacts and listens to WebSocket user status events
/// to update the list in real-time.

abstract class _$OnlineUsersNotifier extends $AsyncNotifier<List<User>> {
  FutureOr<List<User>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<User>>, List<User>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<User>>, List<User>>,
              AsyncValue<List<User>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
