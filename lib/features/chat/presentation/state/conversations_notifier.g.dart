// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversations_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for managing conversations list
/// Handles fetching and caching conversations with real-time updates

@ProviderFor(ConversationsNotifier)
const conversationsProvider = ConversationsNotifierProvider._();

/// Notifier for managing conversations list
/// Handles fetching and caching conversations with real-time updates
final class ConversationsNotifierProvider
    extends $AsyncNotifierProvider<ConversationsNotifier, List<Conversation>> {
  /// Notifier for managing conversations list
  /// Handles fetching and caching conversations with real-time updates
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
    r'be8a8637e2ad7b22a78e424197aa1abebabcbe06';

/// Notifier for managing conversations list
/// Handles fetching and caching conversations with real-time updates

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
