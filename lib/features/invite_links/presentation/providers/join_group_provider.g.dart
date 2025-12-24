// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'join_group_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for joining group via invite link

@ProviderFor(JoinGroup)
const joinGroupProvider = JoinGroupProvider._();

/// Provider for joining group via invite link
final class JoinGroupProvider
    extends $AsyncNotifierProvider<JoinGroup, JoinGroupResultEntity?> {
  /// Provider for joining group via invite link
  const JoinGroupProvider._()
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

String _$joinGroupHash() => r'daaa673874e4b4ce0f22fd81a486b0495663e17d';

/// Provider for joining group via invite link

abstract class _$JoinGroup extends $AsyncNotifier<JoinGroupResultEntity?> {
  FutureOr<JoinGroupResultEntity?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
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
    element.handleValue(ref, created);
  }
}
