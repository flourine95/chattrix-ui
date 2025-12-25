// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'invite_links_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InviteLinksList)
const inviteLinksListProvider = InviteLinksListFamily._();

final class InviteLinksListProvider
    extends $AsyncNotifierProvider<InviteLinksList, List<InviteLinkEntity>> {
  const InviteLinksListProvider._({
    required InviteLinksListFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'inviteLinksListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$inviteLinksListHash();

  @override
  String toString() {
    return r'inviteLinksListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  InviteLinksList create() => InviteLinksList();

  @override
  bool operator ==(Object other) {
    return other is InviteLinksListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$inviteLinksListHash() => r'0781d688873e0c565c440aa7f0bfe6b30e5f56cb';

final class InviteLinksListFamily extends $Family
    with
        $ClassFamilyOverride<
          InviteLinksList,
          AsyncValue<List<InviteLinkEntity>>,
          List<InviteLinkEntity>,
          FutureOr<List<InviteLinkEntity>>,
          int
        > {
  const InviteLinksListFamily._()
    : super(
        retry: null,
        name: r'inviteLinksListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  InviteLinksListProvider call(int conversationId) =>
      InviteLinksListProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'inviteLinksListProvider';
}

abstract class _$InviteLinksList
    extends $AsyncNotifier<List<InviteLinkEntity>> {
  late final _$args = ref.$arg as int;
  int get conversationId => _$args;

  FutureOr<List<InviteLinkEntity>> build(int conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<InviteLinkEntity>>, List<InviteLinkEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<InviteLinkEntity>>,
                List<InviteLinkEntity>
              >,
              AsyncValue<List<InviteLinkEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
