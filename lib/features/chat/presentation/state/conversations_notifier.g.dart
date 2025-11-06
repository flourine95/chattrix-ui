// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversations_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConversationsNotifier)
const conversationsProvider = ConversationsNotifierProvider._();

final class ConversationsNotifierProvider
    extends $AsyncNotifierProvider<ConversationsNotifier, List<Conversation>> {
  const ConversationsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'conversationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$conversationsNotifierHash();

  @$internal
  @override
  ConversationsNotifier create() => ConversationsNotifier();
}

String _$conversationsNotifierHash() =>
    r'84a3ba437f8024b6a9af5c6051d81f9c219879d7';

abstract class _$ConversationsNotifier
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
