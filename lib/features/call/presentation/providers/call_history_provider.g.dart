// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'call_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(callHistoryDataSource)
final callHistoryDataSourceProvider = CallHistoryDataSourceProvider._();

final class CallHistoryDataSourceProvider
    extends
        $FunctionalProvider<
          CallHistoryDataSource,
          CallHistoryDataSource,
          CallHistoryDataSource
        >
    with $Provider<CallHistoryDataSource> {
  CallHistoryDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callHistoryDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callHistoryDataSourceHash();

  @$internal
  @override
  $ProviderElement<CallHistoryDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallHistoryDataSource create(Ref ref) {
    return callHistoryDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallHistoryDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallHistoryDataSource>(value),
    );
  }
}

String _$callHistoryDataSourceHash() =>
    r'3edc23ec54e9899e6417ccb29e5fe3d615524581';

@ProviderFor(callHistoryRepository)
final callHistoryRepositoryProvider = CallHistoryRepositoryProvider._();

final class CallHistoryRepositoryProvider
    extends
        $FunctionalProvider<
          CallHistoryRepository,
          CallHistoryRepository,
          CallHistoryRepository
        >
    with $Provider<CallHistoryRepository> {
  CallHistoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callHistoryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callHistoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<CallHistoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallHistoryRepository create(Ref ref) {
    return callHistoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallHistoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallHistoryRepository>(value),
    );
  }
}

String _$callHistoryRepositoryHash() =>
    r'6790a41d4a3ab867e96306765035bfd6e12a2943';

@ProviderFor(getCallHistoryUseCase)
final getCallHistoryUseCaseProvider = GetCallHistoryUseCaseProvider._();

final class GetCallHistoryUseCaseProvider
    extends
        $FunctionalProvider<
          GetCallHistoryUseCase,
          GetCallHistoryUseCase,
          GetCallHistoryUseCase
        >
    with $Provider<GetCallHistoryUseCase> {
  GetCallHistoryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getCallHistoryUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getCallHistoryUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetCallHistoryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetCallHistoryUseCase create(Ref ref) {
    return getCallHistoryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetCallHistoryUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetCallHistoryUseCase>(value),
    );
  }
}

String _$getCallHistoryUseCaseHash() =>
    r'0c52e190c8951f3daa18150a4753f8479ec1202c';

@ProviderFor(CallHistory)
final callHistoryProvider = CallHistoryProvider._();

final class CallHistoryProvider
    extends $AsyncNotifierProvider<CallHistory, List<CallHistoryItem>> {
  CallHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callHistoryHash();

  @$internal
  @override
  CallHistory create() => CallHistory();
}

String _$callHistoryHash() => r'16fe4b569dc46659675f6bf2ce7bfd44a3bbf904';

abstract class _$CallHistory extends $AsyncNotifier<List<CallHistoryItem>> {
  FutureOr<List<CallHistoryItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<CallHistoryItem>>, List<CallHistoryItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CallHistoryItem>>,
                List<CallHistoryItem>
              >,
              AsyncValue<List<CallHistoryItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
