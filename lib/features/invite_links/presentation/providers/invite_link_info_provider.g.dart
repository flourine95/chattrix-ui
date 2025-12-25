// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'invite_link_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InviteLinkInfo)
const inviteLinkInfoProvider = InviteLinkInfoFamily._();

final class InviteLinkInfoProvider
    extends $AsyncNotifierProvider<InviteLinkInfo, InviteLinkInfoEntity?> {
  const InviteLinkInfoProvider._({
    required InviteLinkInfoFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'inviteLinkInfoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$inviteLinkInfoHash();

  @override
  String toString() {
    return r'inviteLinkInfoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  InviteLinkInfo create() => InviteLinkInfo();

  @override
  bool operator ==(Object other) {
    return other is InviteLinkInfoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$inviteLinkInfoHash() => r'ee890d917991ace1873633d1612b42f5aa40837a';

final class InviteLinkInfoFamily extends $Family
    with
        $ClassFamilyOverride<
          InviteLinkInfo,
          AsyncValue<InviteLinkInfoEntity?>,
          InviteLinkInfoEntity?,
          FutureOr<InviteLinkInfoEntity?>,
          String
        > {
  const InviteLinkInfoFamily._()
    : super(
        retry: null,
        name: r'inviteLinkInfoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  InviteLinkInfoProvider call(String token) =>
      InviteLinkInfoProvider._(argument: token, from: this);

  @override
  String toString() => r'inviteLinkInfoProvider';
}

abstract class _$InviteLinkInfo extends $AsyncNotifier<InviteLinkInfoEntity?> {
  late final _$args = ref.$arg as String;
  String get token => _$args;

  FutureOr<InviteLinkInfoEntity?> build(String token);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<InviteLinkInfoEntity?>, InviteLinkInfoEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<InviteLinkInfoEntity?>,
                InviteLinkInfoEntity?
              >,
              AsyncValue<InviteLinkInfoEntity?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
