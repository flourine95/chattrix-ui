// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'typing_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TypingNotifier)
final typingProvider = TypingNotifierProvider._();

final class TypingNotifierProvider
    extends $NotifierProvider<TypingNotifier, Map<int, List<TypingUser>>> {
  TypingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'typingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$typingNotifierHash();

  @$internal
  @override
  TypingNotifier create() => TypingNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, List<TypingUser>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, List<TypingUser>>>(value),
    );
  }
}

String _$typingNotifierHash() => r'bc3d917bfb3775e7cd02370848bba534cef0053f';

abstract class _$TypingNotifier extends $Notifier<Map<int, List<TypingUser>>> {
  Map<int, List<TypingUser>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<Map<int, List<TypingUser>>, Map<int, List<TypingUser>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<int, List<TypingUser>>,
                Map<int, List<TypingUser>>
              >,
              Map<int, List<TypingUser>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Convenience provider to get typing users for a specific conversation

@ProviderFor(conversationTypingUsers)
final conversationTypingUsersProvider = ConversationTypingUsersFamily._();

/// Convenience provider to get typing users for a specific conversation

final class ConversationTypingUsersProvider
    extends
        $FunctionalProvider<
          List<TypingUser>,
          List<TypingUser>,
          List<TypingUser>
        >
    with $Provider<List<TypingUser>> {
  /// Convenience provider to get typing users for a specific conversation
  ConversationTypingUsersProvider._({
    required ConversationTypingUsersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'conversationTypingUsersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$conversationTypingUsersHash();

  @override
  String toString() {
    return r'conversationTypingUsersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<TypingUser>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<TypingUser> create(Ref ref) {
    final argument = this.argument as int;
    return conversationTypingUsers(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TypingUser> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TypingUser>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationTypingUsersProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$conversationTypingUsersHash() =>
    r'ecfc25eb685a48c4967826573b7b535b4ea12c66';

/// Convenience provider to get typing users for a specific conversation

final class ConversationTypingUsersFamily extends $Family
    with $FunctionalFamilyOverride<List<TypingUser>, int> {
  ConversationTypingUsersFamily._()
    : super(
        retry: null,
        name: r'conversationTypingUsersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Convenience provider to get typing users for a specific conversation

  ConversationTypingUsersProvider call(int conversationId) =>
      ConversationTypingUsersProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'conversationTypingUsersProvider';
}
