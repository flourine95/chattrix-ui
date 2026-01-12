// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'typing_indicator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for typing indicator state in a specific conversation

@ProviderFor(TypingIndicatorNotifier)
const typingIndicatorProvider = TypingIndicatorNotifierFamily._();

/// Provider for typing indicator state in a specific conversation
final class TypingIndicatorNotifierProvider
    extends $NotifierProvider<TypingIndicatorNotifier, TypingIndicator> {
  /// Provider for typing indicator state in a specific conversation
  const TypingIndicatorNotifierProvider._({
    required TypingIndicatorNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'typingIndicatorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$typingIndicatorNotifierHash();

  @override
  String toString() {
    return r'typingIndicatorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TypingIndicatorNotifier create() => TypingIndicatorNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TypingIndicator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TypingIndicator>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TypingIndicatorNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$typingIndicatorNotifierHash() =>
    r'20b3fcad431bf1ab45d62657eb97828ff8ae0d52';

/// Provider for typing indicator state in a specific conversation

final class TypingIndicatorNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TypingIndicatorNotifier,
          TypingIndicator,
          TypingIndicator,
          TypingIndicator,
          String
        > {
  const TypingIndicatorNotifierFamily._()
    : super(
        retry: null,
        name: r'typingIndicatorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for typing indicator state in a specific conversation

  TypingIndicatorNotifierProvider call(String conversationId) =>
      TypingIndicatorNotifierProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'typingIndicatorProvider';
}

/// Provider for typing indicator state in a specific conversation

abstract class _$TypingIndicatorNotifier extends $Notifier<TypingIndicator> {
  late final _$args = ref.$arg as String;
  String get conversationId => _$args;

  TypingIndicator build(String conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<TypingIndicator, TypingIndicator>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TypingIndicator, TypingIndicator>,
              TypingIndicator,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
