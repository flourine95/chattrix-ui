// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'conversations_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConversationsNotifier)
final conversationsProvider = ConversationsNotifierProvider._();

final class ConversationsNotifierProvider
    extends $AsyncNotifierProvider<ConversationsNotifier, List<Conversation>> {
  ConversationsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'conversationsProvider',
        isAutoDispose: false,
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
    r'e268d7d5ee6517cb89030079be9371162d12e23b';

abstract class _$ConversationsNotifier
    extends $AsyncNotifier<List<Conversation>> {
  FutureOr<List<Conversation>> build();
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, build);
  }
}
