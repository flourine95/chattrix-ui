// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'typing_indicator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TypingIndicatorNotifier)
final typingIndicatorProvider = TypingIndicatorNotifierFamily._();

final class TypingIndicatorNotifierProvider
    extends $NotifierProvider<TypingIndicatorNotifier, TypingIndicator> {
  TypingIndicatorNotifierProvider._({
    required TypingIndicatorNotifierFamily super.from,
    required int super.argument,
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
    r'38c95d6b39f720d48da8682501cdd44a51a570a7';

final class TypingIndicatorNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TypingIndicatorNotifier,
          TypingIndicator,
          TypingIndicator,
          TypingIndicator,
          int
        > {
  TypingIndicatorNotifierFamily._()
    : super(
        retry: null,
        name: r'typingIndicatorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TypingIndicatorNotifierProvider call(int conversationId) =>
      TypingIndicatorNotifierProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'typingIndicatorProvider';
}

abstract class _$TypingIndicatorNotifier extends $Notifier<TypingIndicator> {
  late final _$args = ref.$arg as int;
  int get conversationId => _$args;

  TypingIndicator build(int conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TypingIndicator, TypingIndicator>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TypingIndicator, TypingIndicator>,
              TypingIndicator,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
