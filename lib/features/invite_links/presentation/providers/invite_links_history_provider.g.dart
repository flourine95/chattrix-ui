// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'invite_links_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for invite links history with cursor-based pagination

@ProviderFor(InviteLinksHistory)
final inviteLinksHistoryProvider = InviteLinksHistoryFamily._();

/// Provider for invite links history with cursor-based pagination
final class InviteLinksHistoryProvider
    extends
        $AsyncNotifierProvider<InviteLinksHistory, InviteLinksHistoryEntity> {
  /// Provider for invite links history with cursor-based pagination
  InviteLinksHistoryProvider._({
    required InviteLinksHistoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'inviteLinksHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$inviteLinksHistoryHash();

  @override
  String toString() {
    return r'inviteLinksHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  InviteLinksHistory create() => InviteLinksHistory();

  @override
  bool operator ==(Object other) {
    return other is InviteLinksHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$inviteLinksHistoryHash() =>
    r'8563c25413dbd128fd46c6b3ff94a8f8983d00f2';

/// Provider for invite links history with cursor-based pagination

final class InviteLinksHistoryFamily extends $Family
    with
        $ClassFamilyOverride<
          InviteLinksHistory,
          AsyncValue<InviteLinksHistoryEntity>,
          InviteLinksHistoryEntity,
          FutureOr<InviteLinksHistoryEntity>,
          int
        > {
  InviteLinksHistoryFamily._()
    : super(
        retry: null,
        name: r'inviteLinksHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for invite links history with cursor-based pagination

  InviteLinksHistoryProvider call(int conversationId) =>
      InviteLinksHistoryProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'inviteLinksHistoryProvider';
}

/// Provider for invite links history with cursor-based pagination

abstract class _$InviteLinksHistory
    extends $AsyncNotifier<InviteLinksHistoryEntity> {
  late final _$args = ref.$arg as int;
  int get conversationId => _$args;

  FutureOr<InviteLinksHistoryEntity> build(int conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<InviteLinksHistoryEntity>,
              InviteLinksHistoryEntity
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<InviteLinksHistoryEntity>,
                InviteLinksHistoryEntity
              >,
              AsyncValue<InviteLinksHistoryEntity>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
