// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'ringtone_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the ringtone service

@ProviderFor(ringtoneService)
const ringtoneServiceProvider = RingtoneServiceProvider._();

/// Provider for the ringtone service

final class RingtoneServiceProvider
    extends
        $FunctionalProvider<RingtoneService, RingtoneService, RingtoneService>
    with $Provider<RingtoneService> {
  /// Provider for the ringtone service
  const RingtoneServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ringtoneServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ringtoneServiceHash();

  @$internal
  @override
  $ProviderElement<RingtoneService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RingtoneService create(Ref ref) {
    return ringtoneService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RingtoneService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RingtoneService>(value),
    );
  }
}

String _$ringtoneServiceHash() => r'5ca6e299aa1b01378795f22f4b5595c3c9d71717';
