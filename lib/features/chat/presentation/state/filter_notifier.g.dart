// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'filter_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FilterNotifier)
const filterProvider = FilterNotifierProvider._();

final class FilterNotifierProvider
    extends $NotifierProvider<FilterNotifier, ConversationFilter> {
  const FilterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filterNotifierHash();

  @$internal
  @override
  FilterNotifier create() => FilterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConversationFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConversationFilter>(value),
    );
  }
}

String _$filterNotifierHash() => r'aedbb170e37d5edbd7b2e464bcb27818255756b4';

abstract class _$FilterNotifier extends $Notifier<ConversationFilter> {
  ConversationFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ConversationFilter, ConversationFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ConversationFilter, ConversationFilter>,
              ConversationFilter,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
