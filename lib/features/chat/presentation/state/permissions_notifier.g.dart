// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'permissions_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PermissionsNotifier)
final permissionsProvider = PermissionsNotifierFamily._();

final class PermissionsNotifierProvider
    extends
        $AsyncNotifierProvider<PermissionsNotifier, ConversationPermissions?> {
  PermissionsNotifierProvider._({
    required PermissionsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'permissionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$permissionsNotifierHash();

  @override
  String toString() {
    return r'permissionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PermissionsNotifier create() => PermissionsNotifier();

  @override
  bool operator ==(Object other) {
    return other is PermissionsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$permissionsNotifierHash() =>
    r'e3ce336f3eb49169f2d44365d5d654403eb7207e';

final class PermissionsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          PermissionsNotifier,
          AsyncValue<ConversationPermissions?>,
          ConversationPermissions?,
          FutureOr<ConversationPermissions?>,
          int
        > {
  PermissionsNotifierFamily._()
    : super(
        retry: null,
        name: r'permissionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PermissionsNotifierProvider call(int conversationId) =>
      PermissionsNotifierProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'permissionsProvider';
}

abstract class _$PermissionsNotifier
    extends $AsyncNotifier<ConversationPermissions?> {
  late final _$args = ref.$arg as int;
  int get conversationId => _$args;

  FutureOr<ConversationPermissions?> build(int conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ConversationPermissions?>,
              ConversationPermissions?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ConversationPermissions?>,
                ConversationPermissions?
              >,
              AsyncValue<ConversationPermissions?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
