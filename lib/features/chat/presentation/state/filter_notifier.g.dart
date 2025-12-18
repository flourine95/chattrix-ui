// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'filter_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for managing conversation filter state
///
/// **State**: ConversationFilter (all, unread, groups)
/// **Lifecycle**: keepAlive (persists during session)
///
/// **Requirements**: 2.1, 2.2, 2.3, 2.4

@ProviderFor(FilterNotifier)
const filterProvider = FilterNotifierProvider._();

/// Notifier for managing conversation filter state
///
/// **State**: ConversationFilter (all, unread, groups)
/// **Lifecycle**: keepAlive (persists during session)
///
/// **Requirements**: 2.1, 2.2, 2.3, 2.4
final class FilterNotifierProvider
    extends $NotifierProvider<FilterNotifier, ConversationFilter> {
  /// Notifier for managing conversation filter state
  ///
  /// **State**: ConversationFilter (all, unread, groups)
  /// **Lifecycle**: keepAlive (persists during session)
  ///
  /// **Requirements**: 2.1, 2.2, 2.3, 2.4
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

String _$filterNotifierHash() => r'a38b0c2106a749913d390c4eed5a2a9fb1bd1b05';

/// Notifier for managing conversation filter state
///
/// **State**: ConversationFilter (all, unread, groups)
/// **Lifecycle**: keepAlive (persists during session)
///
/// **Requirements**: 2.1, 2.2, 2.3, 2.4

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
