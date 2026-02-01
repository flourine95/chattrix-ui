// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'join_group_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JoinGroup)
final joinGroupProvider = JoinGroupProvider._();

final class JoinGroupProvider
    extends $AsyncNotifierProvider<JoinGroup, JoinGroupResultEntity?> {
  JoinGroupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'joinGroupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joinGroupHash();

  @$internal
  @override
  JoinGroup create() => JoinGroup();
}

String _$joinGroupHash() => r'29e33ef1685f063fab98eff215e7d1f9f5ec5d12';

abstract class _$JoinGroup extends $AsyncNotifier<JoinGroupResultEntity?> {
  FutureOr<JoinGroupResultEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<JoinGroupResultEntity?>, JoinGroupResultEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<JoinGroupResultEntity?>,
                JoinGroupResultEntity?
              >,
              AsyncValue<JoinGroupResultEntity?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
