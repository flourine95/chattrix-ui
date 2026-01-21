// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'invite_link_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for managing the current active invite link for a conversation
///
/// **API**: GET /v1/conversations/{conversationId}/invite-link
/// Returns null if no active link exists

@ProviderFor(InviteLink)
final inviteLinkProvider = InviteLinkFamily._();

/// Provider for managing the current active invite link for a conversation
///
/// **API**: GET /v1/conversations/{conversationId}/invite-link
/// Returns null if no active link exists
final class InviteLinkProvider
    extends $AsyncNotifierProvider<InviteLink, InviteLinkEntity?> {
  /// Provider for managing the current active invite link for a conversation
  ///
  /// **API**: GET /v1/conversations/{conversationId}/invite-link
  /// Returns null if no active link exists
  InviteLinkProvider._({
    required InviteLinkFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'inviteLinkProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$inviteLinkHash();

  @override
  String toString() {
    return r'inviteLinkProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  InviteLink create() => InviteLink();

  @override
  bool operator ==(Object other) {
    return other is InviteLinkProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$inviteLinkHash() => r'd2724255ec0bae6d83808c8abf147e195325f477';

/// Provider for managing the current active invite link for a conversation
///
/// **API**: GET /v1/conversations/{conversationId}/invite-link
/// Returns null if no active link exists

final class InviteLinkFamily extends $Family
    with
        $ClassFamilyOverride<
          InviteLink,
          AsyncValue<InviteLinkEntity?>,
          InviteLinkEntity?,
          FutureOr<InviteLinkEntity?>,
          int
        > {
  InviteLinkFamily._()
    : super(
        retry: null,
        name: r'inviteLinkProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for managing the current active invite link for a conversation
  ///
  /// **API**: GET /v1/conversations/{conversationId}/invite-link
  /// Returns null if no active link exists

  InviteLinkProvider call(int conversationId) =>
      InviteLinkProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'inviteLinkProvider';
}

/// Provider for managing the current active invite link for a conversation
///
/// **API**: GET /v1/conversations/{conversationId}/invite-link
/// Returns null if no active link exists

abstract class _$InviteLink extends $AsyncNotifier<InviteLinkEntity?> {
  late final _$args = ref.$arg as int;
  int get conversationId => _$args;

  FutureOr<InviteLinkEntity?> build(int conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<InviteLinkEntity?>, InviteLinkEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<InviteLinkEntity?>, InviteLinkEntity?>,
              AsyncValue<InviteLinkEntity?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
