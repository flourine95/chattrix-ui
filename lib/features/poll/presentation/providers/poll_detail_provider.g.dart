// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PollDetail)
const pollDetailProvider = PollDetailFamily._();

final class PollDetailProvider
    extends $AsyncNotifierProvider<PollDetail, PollEntity> {
  const PollDetailProvider._({
    required PollDetailFamily super.from,
    required (int, int) super.argument,
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
        '$argument';
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

String _$pollDetailHash() => r'993087791643be71237822a20313414a50aa4fb7';

final class PollDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          PollDetail,
          AsyncValue<PollEntity>,
          PollEntity,
          FutureOr<PollEntity>,
          (int, int)
        > {
  const PollDetailFamily._()
    : super(
        retry: null,
        name: r'pollDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PollDetailProvider call(int conversationId, int pollId) =>
      PollDetailProvider._(argument: (conversationId, pollId), from: this);

  @override
  String toString() => r'pollDetailProvider';
}

abstract class _$PollDetail extends $AsyncNotifier<PollEntity> {
  late final _$args = ref.$arg as (int, int);
  int get conversationId => _$args.$1;
  int get pollId => _$args.$2;

  FutureOr<PollEntity> build(int conversationId, int pollId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2);
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
