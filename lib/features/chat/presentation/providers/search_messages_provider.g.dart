// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'search_messages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for searching messages in a conversation
///
/// **State**: AsyncValue<List<Message>>

@ProviderFor(SearchMessages)
const searchMessagesProvider = SearchMessagesFamily._();

/// Provider for searching messages in a conversation
///
/// **State**: AsyncValue<List<Message>>
final class SearchMessagesProvider
    extends $AsyncNotifierProvider<SearchMessages, List<Message>> {
  /// Provider for searching messages in a conversation
  ///
  /// **State**: AsyncValue<List<Message>>
  const SearchMessagesProvider._({
    required SearchMessagesFamily super.from,
    required (String, String) super.argument,
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

String _$searchMessagesHash() => r'56c173c0730204460bd4c620d2b12c95b2d577cf';

/// Provider for searching messages in a conversation
///
/// **State**: AsyncValue<List<Message>>

final class SearchMessagesFamily extends $Family
    with
        $ClassFamilyOverride<
          SearchMessages,
          AsyncValue<List<Message>>,
          List<Message>,
          FutureOr<List<Message>>,
          (String, String)
        > {
  const SearchMessagesFamily._()
    : super(
        retry: null,
        name: r'searchMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for searching messages in a conversation
  ///
  /// **State**: AsyncValue<List<Message>>

  SearchMessagesProvider call(String conversationId, String query) =>
      SearchMessagesProvider._(argument: (conversationId, query), from: this);

  @override
  String toString() => r'searchMessagesProvider';
}

/// Provider for searching messages in a conversation
///
/// **State**: AsyncValue<List<Message>>

abstract class _$SearchMessages extends $AsyncNotifier<List<Message>> {
  late final _$args = ref.$arg as (String, String);
  String get conversationId => _$args.$1;
  String get query => _$args.$2;

  FutureOr<List<Message>> build(String conversationId, String query);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2);
    final ref = this.ref as $Ref<AsyncValue<List<Message>>, List<Message>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Message>>, List<Message>>,
              AsyncValue<List<Message>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
