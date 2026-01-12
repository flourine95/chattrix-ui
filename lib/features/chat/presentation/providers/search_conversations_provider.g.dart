// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'search_conversations_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchConversationsUseCase)
const searchConversationsUseCaseProvider =
    SearchConversationsUseCaseProvider._();

final class SearchConversationsUseCaseProvider
    extends
        $FunctionalProvider<
          SearchConversationsUseCase,
          SearchConversationsUseCase,
          SearchConversationsUseCase
        >
    with $Provider<SearchConversationsUseCase> {
  const SearchConversationsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchConversationsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchConversationsUseCaseHash();

  @$internal
  @override
  $ProviderElement<SearchConversationsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchConversationsUseCase create(Ref ref) {
    return searchConversationsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchConversationsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchConversationsUseCase>(value),
    );
  }
}

String _$searchConversationsUseCaseHash() =>
    r'006379fb70760276f44b0a0037f4a8fb2bfde371';

@ProviderFor(SearchConversations)
const searchConversationsProvider = SearchConversationsProvider._();

final class SearchConversationsProvider
    extends $AsyncNotifierProvider<SearchConversations, List<Conversation>> {
  const SearchConversationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchConversationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchConversationsHash();

  @$internal
  @override
  SearchConversations create() => SearchConversations();
}

String _$searchConversationsHash() =>
    r'6c35f481b0e397b123274fba9395972939efdfeb';

abstract class _$SearchConversations
    extends $AsyncNotifier<List<Conversation>> {
  FutureOr<List<Conversation>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<Conversation>>, List<Conversation>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Conversation>>, List<Conversation>>,
              AsyncValue<List<Conversation>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
