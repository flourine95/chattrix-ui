// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider that tracks call status for UI feedback

@ProviderFor(CallStatusNotifier)
const callStatusProvider = CallStatusNotifierProvider._();

/// Provider that tracks call status for UI feedback
final class CallStatusNotifierProvider
    extends $NotifierProvider<CallStatusNotifier, CallStatusInfo> {
  /// Provider that tracks call status for UI feedback
  const CallStatusNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callStatusNotifierHash();

  @$internal
  @override
  CallStatusNotifier create() => CallStatusNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallStatusInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallStatusInfo>(value),
    );
  }
}

String _$callStatusNotifierHash() =>
    r'8fce50c050e58ca1d38515ac6b88b1754782da68';

/// Provider that tracks call status for UI feedback

abstract class _$CallStatusNotifier extends $Notifier<CallStatusInfo> {
  CallStatusInfo build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<CallStatusInfo, CallStatusInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CallStatusInfo, CallStatusInfo>,
              CallStatusInfo,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
