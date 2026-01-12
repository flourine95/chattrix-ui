// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'pinned_messages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for pinned messages in a conversation

@ProviderFor(PinnedMessages)
const pinnedMessagesProvider = PinnedMessagesFamily._();

/// Provider for pinned messages in a conversation
final class PinnedMessagesProvider
    extends $AsyncNotifierProvider<PinnedMessages, List<Message>> {
  /// Provider for pinned messages in a conversation
  const PinnedMessagesProvider._({
    required PinnedMessagesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pinnedMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pinnedMessagesHash();

  @override
  String toString() {
    return r'pinnedMessagesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PinnedMessages create() => PinnedMessages();

  @override
  bool operator ==(Object other) {
    return other is PinnedMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pinnedMessagesHash() => r'd1b6762eeb095d402aefc2b23397602fb01df1ca';

/// Provider for pinned messages in a conversation

final class PinnedMessagesFamily extends $Family
    with
        $ClassFamilyOverride<
          PinnedMessages,
          AsyncValue<List<Message>>,
          List<Message>,
          FutureOr<List<Message>>,
          String
        > {
  const PinnedMessagesFamily._()
    : super(
        retry: null,
        name: r'pinnedMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for pinned messages in a conversation

  PinnedMessagesProvider call(String conversationId) =>
      PinnedMessagesProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'pinnedMessagesProvider';
}

/// Provider for pinned messages in a conversation

abstract class _$PinnedMessages extends $AsyncNotifier<List<Message>> {
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
