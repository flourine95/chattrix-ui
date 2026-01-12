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
const typingProvider = TypingNotifierProvider._();

final class TypingNotifierProvider
    extends $NotifierProvider<TypingNotifier, Map<String, List<TypingUser>>> {
  const TypingNotifierProvider._()
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
  Override overrideWithValue(Map<String, List<TypingUser>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, List<TypingUser>>>(
        value,
      ),
    );
  }
}

String _$typingNotifierHash() => r'57c751eee2a4e426914f0160f47079250d5b399a';

abstract class _$TypingNotifier
    extends $Notifier<Map<String, List<TypingUser>>> {
  Map<String, List<TypingUser>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              Map<String, List<TypingUser>>,
              Map<String, List<TypingUser>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<String, List<TypingUser>>,
                Map<String, List<TypingUser>>
              >,
              Map<String, List<TypingUser>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Convenience provider to get typing users for a specific conversation

@ProviderFor(conversationTypingUsers)
const conversationTypingUsersProvider = ConversationTypingUsersFamily._();

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
  const ConversationTypingUsersProvider._({
    required ConversationTypingUsersFamily super.from,
    required String super.argument,
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
    final argument = this.argument as String;
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
    r'7f013bfab34f8151f3b6cccc790da79b8b495e65';

/// Convenience provider to get typing users for a specific conversation

final class ConversationTypingUsersFamily extends $Family
    with $FunctionalFamilyOverride<List<TypingUser>, String> {
  const ConversationTypingUsersFamily._()
    : super(
        retry: null,
        name: r'conversationTypingUsersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Convenience provider to get typing users for a specific conversation

  ConversationTypingUsersProvider call(String conversationId) =>
      ConversationTypingUsersProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'conversationTypingUsersProvider';
}
