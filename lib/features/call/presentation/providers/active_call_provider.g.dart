// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'active_call_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider to check if there's an active call in a conversation
///
/// **Usage:**
/// ```dart
/// final activeCall = ref.watch(activeCallProvider(conversationId));
/// ```

@ProviderFor(activeCall)
final activeCallProvider = ActiveCallFamily._();

/// Provider to check if there's an active call in a conversation
///
/// **Usage:**
/// ```dart
/// final activeCall = ref.watch(activeCallProvider(conversationId));
/// ```

final class ActiveCallProvider
    extends
        $FunctionalProvider<
          AsyncValue<CallInfo?>,
          CallInfo?,
          FutureOr<CallInfo?>
        >
    with $FutureModifier<CallInfo?>, $FutureProvider<CallInfo?> {
  /// Provider to check if there's an active call in a conversation
  ///
  /// **Usage:**
  /// ```dart
  /// final activeCall = ref.watch(activeCallProvider(conversationId));
  /// ```
  ActiveCallProvider._({
    required ActiveCallFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'activeCallProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activeCallHash();

  @override
  String toString() {
    return r'activeCallProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CallInfo?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<CallInfo?> create(Ref ref) {
    final argument = this.argument as int;
    return activeCall(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ActiveCallProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activeCallHash() => r'e023151f0c03c1b471b9cf87e1bd9d5dbce6c2c8';

/// Provider to check if there's an active call in a conversation
///
/// **Usage:**
/// ```dart
/// final activeCall = ref.watch(activeCallProvider(conversationId));
/// ```

final class ActiveCallFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CallInfo?>, int> {
  ActiveCallFamily._()
    : super(
        retry: null,
        name: r'activeCallProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to check if there's an active call in a conversation
  ///
  /// **Usage:**
  /// ```dart
  /// final activeCall = ref.watch(activeCallProvider(conversationId));
  /// ```

  ActiveCallProvider call(int conversationId) =>
      ActiveCallProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'activeCallProvider';
}
