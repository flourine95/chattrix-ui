// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for poll details
///
/// State: AsyncValue<PollEntity>

@ProviderFor(PollDetail)
const pollDetailProvider = PollDetailFamily._();

/// Provider for poll details
///
/// State: AsyncValue<PollEntity>
final class PollDetailProvider
    extends $AsyncNotifierProvider<PollDetail, PollEntity> {
  /// Provider for poll details
  ///
  /// State: AsyncValue<PollEntity>
  const PollDetailProvider._({
    required PollDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'pollDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pollDetailHash();

  @override
  String toString() {
    return r'pollDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PollDetail create() => PollDetail();

  @override
  bool operator ==(Object other) {
    return other is PollDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pollDetailHash() => r'6ee340ce4d24b15da60c62446ba93f2b6db3bddc';

/// Provider for poll details
///
/// State: AsyncValue<PollEntity>

final class PollDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          PollDetail,
          AsyncValue<PollEntity>,
          PollEntity,
          FutureOr<PollEntity>,
          int
        > {
  const PollDetailFamily._()
    : super(
        retry: null,
        name: r'pollDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for poll details
  ///
  /// State: AsyncValue<PollEntity>

  PollDetailProvider call(int pollId) =>
      PollDetailProvider._(argument: pollId, from: this);

  @override
  String toString() => r'pollDetailProvider';
}

/// Provider for poll details
///
/// State: AsyncValue<PollEntity>

abstract class _$PollDetail extends $AsyncNotifier<PollEntity> {
  late final _$args = ref.$arg as int;
  int get pollId => _$args;

  FutureOr<PollEntity> build(int pollId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<PollEntity>, PollEntity>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PollEntity>, PollEntity>,
              AsyncValue<PollEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
