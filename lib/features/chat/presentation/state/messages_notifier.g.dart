// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'messages_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MessagesNotifier)
const messagesProvider = MessagesNotifierFamily._();

final class MessagesNotifierProvider
    extends $AsyncNotifierProvider<MessagesNotifier, List<Message>> {
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

String _$messagesNotifierHash() => r'7269c685557954eee9bc5406c408ecffe257c349';

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

  MessagesNotifierProvider call(String conversationId) =>
      MessagesNotifierProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'messagesProvider';
}

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
