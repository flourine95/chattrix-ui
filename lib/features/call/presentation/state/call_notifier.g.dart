// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CallNotifier)
final callProvider = CallNotifierProvider._();

final class CallNotifierProvider
    extends $NotifierProvider<CallNotifier, CallState> {
  CallNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callNotifierHash();

  @$internal
  @override
  CallNotifier create() => CallNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallState>(value),
    );
  }
}

String _$callNotifierHash() => r'214fae569ded3f597b90a9b048d105dd7547c259';

abstract class _$CallNotifier extends $Notifier<CallState> {
  CallState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CallState, CallState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CallState, CallState>,
              CallState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
