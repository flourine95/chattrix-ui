// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'invite_links_websocket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InviteLinksWebSocketListener)
const inviteLinksWebSocketListenerProvider =
    InviteLinksWebSocketListenerProvider._();

final class InviteLinksWebSocketListenerProvider
    extends $NotifierProvider<InviteLinksWebSocketListener, bool> {
  const InviteLinksWebSocketListenerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteLinksWebSocketListenerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteLinksWebSocketListenerHash();

  @$internal
  @override
  InviteLinksWebSocketListener create() => InviteLinksWebSocketListener();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$inviteLinksWebSocketListenerHash() =>
    r'6e0e8a586dc5763d881fae5ea711ec2cd795618e';

abstract class _$InviteLinksWebSocketListener extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
