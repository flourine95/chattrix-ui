// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'voice_recorder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(voiceRecorderService)
const voiceRecorderServiceProvider = VoiceRecorderServiceProvider._();

final class VoiceRecorderServiceProvider
    extends
        $FunctionalProvider<
          VoiceRecorderService,
          VoiceRecorderService,
          VoiceRecorderService
        >
    with $Provider<VoiceRecorderService> {
  const VoiceRecorderServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voiceRecorderServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voiceRecorderServiceHash();

  @$internal
  @override
  $ProviderElement<VoiceRecorderService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VoiceRecorderService create(Ref ref) {
    return voiceRecorderService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoiceRecorderService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoiceRecorderService>(value),
    );
  }
}

String _$voiceRecorderServiceHash() =>
    r'f93e9e0f51fac4f242674e05d3ad2eba06cb8879';
