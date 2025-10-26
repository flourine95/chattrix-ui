// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for managing messages in a conversation
/// Handles fetching and caching messages with real-time updates

@ProviderFor(MessagesNotifier)
const messagesProvider = MessagesNotifierFamily._();

/// Notifier for managing messages in a conversation
/// Handles fetching and caching messages with real-time updates
final class MessagesNotifierProvider
    extends $AsyncNotifierProvider<MessagesNotifier, List<Message>> {
  /// Notifier for managing messages in a conversation
  /// Handles fetching and caching messages with real-time updates
  const MessagesNotifierProvider._({
    required MessagesNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'messagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$messagesNotifierHash();

  @override
  String toString() {
    return r'messagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MessagesNotifier create() => MessagesNotifier();

  @override
  bool operator ==(Object other) {
    return other is MessagesNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$messagesNotifierHash() => r'f43e4cd0596e3b61ffc18cc121f29323b1f974d3';

/// Notifier for managing messages in a conversation
/// Handles fetching and caching messages with real-time updates

final class MessagesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          MessagesNotifier,
          AsyncValue<List<Message>>,
          List<Message>,
          FutureOr<List<Message>>,
          String
        > {
  const MessagesNotifierFamily._()
    : super(
        retry: null,
        name: r'messagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier for managing messages in a conversation
  /// Handles fetching and caching messages with real-time updates

  MessagesNotifierProvider call(String conversationId) =>
      MessagesNotifierProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'messagesProvider';
}

/// Notifier for managing messages in a conversation
/// Handles fetching and caching messages with real-time updates

abstract class _$MessagesNotifier extends $AsyncNotifier<List<Message>> {
  late final _$args = ref.$arg as String;
  String get conversationId => _$args;

  FutureOr<List<Message>> build(String conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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
