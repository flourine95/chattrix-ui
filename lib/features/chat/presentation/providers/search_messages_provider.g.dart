// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'search_messages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchMessages)
final searchMessagesProvider = SearchMessagesFamily._();

final class SearchMessagesProvider
    extends $AsyncNotifierProvider<SearchMessages, List<Message>> {
  SearchMessagesProvider._({
    required SearchMessagesFamily super.from,
    required (int, String) super.argument,
  }) : super(
         retry: null,
         name: r'searchMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchMessagesHash();

  @override
  String toString() {
    return r'searchMessagesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SearchMessages create() => SearchMessages();

  @override
  bool operator ==(Object other) {
    return other is SearchMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchMessagesHash() => r'3685a67acd3ff50d7b8d277611cac603ef321c0e';

final class SearchMessagesFamily extends $Family
    with
        $ClassFamilyOverride<
          SearchMessages,
          AsyncValue<List<Message>>,
          List<Message>,
          FutureOr<List<Message>>,
          (int, String)
        > {
  SearchMessagesFamily._()
    : super(
        retry: null,
        name: r'searchMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchMessagesProvider call(int conversationId, String query) =>
      SearchMessagesProvider._(argument: (conversationId, query), from: this);

  @override
  String toString() => r'searchMessagesProvider';
}

abstract class _$SearchMessages extends $AsyncNotifier<List<Message>> {
  late final _$args = ref.$arg as (int, String);
  int get conversationId => _$args.$1;
  String get query => _$args.$2;

  FutureOr<List<Message>> build(int conversationId, String query);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Message>>, List<Message>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Message>>, List<Message>>,
              AsyncValue<List<Message>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
