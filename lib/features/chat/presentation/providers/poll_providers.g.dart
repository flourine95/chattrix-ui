// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pollDatasource)
const pollDatasourceProvider = PollDatasourceProvider._();

final class PollDatasourceProvider
    extends $FunctionalProvider<PollDatasource, PollDatasource, PollDatasource>
    with $Provider<PollDatasource> {
  const PollDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pollDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pollDatasourceHash();

  @$internal
  @override
  $ProviderElement<PollDatasource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PollDatasource create(Ref ref) {
    return pollDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PollDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PollDatasource>(value),
    );
  }
}

String _$pollDatasourceHash() => r'b93343f40dbc17c7f87574d701c4f567a05542e3';

@ProviderFor(pollRepository)
const pollRepositoryProvider = PollRepositoryProvider._();

final class PollRepositoryProvider
    extends $FunctionalProvider<PollRepository, PollRepository, PollRepository>
    with $Provider<PollRepository> {
  const PollRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pollRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pollRepositoryHash();

  @$internal
  @override
  $ProviderElement<PollRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PollRepository create(Ref ref) {
    return pollRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PollRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PollRepository>(value),
    );
  }
}

String _$pollRepositoryHash() => r'9f6187770f7f701937fbdb74464482027c894500';

@ProviderFor(createPollUseCase)
const createPollUseCaseProvider = CreatePollUseCaseProvider._();

final class CreatePollUseCaseProvider
    extends
        $FunctionalProvider<
          CreatePollUseCase,
          CreatePollUseCase,
          CreatePollUseCase
        >
    with $Provider<CreatePollUseCase> {
  const CreatePollUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPollUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPollUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreatePollUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreatePollUseCase create(Ref ref) {
    return createPollUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreatePollUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreatePollUseCase>(value),
    );
  }
}

String _$createPollUseCaseHash() => r'e469e8909e3c5d125d648b39fc919ea922cca4de';

@ProviderFor(votePollUseCase)
const votePollUseCaseProvider = VotePollUseCaseProvider._();

final class VotePollUseCaseProvider
    extends
        $FunctionalProvider<VotePollUseCase, VotePollUseCase, VotePollUseCase>
    with $Provider<VotePollUseCase> {
  const VotePollUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'votePollUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$votePollUseCaseHash();

  @$internal
  @override
  $ProviderElement<VotePollUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VotePollUseCase create(Ref ref) {
    return votePollUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VotePollUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VotePollUseCase>(value),
    );
  }
}

String _$votePollUseCaseHash() => r'b576d3c9732b9db3129e96baa9ff47be078d8a93';

@ProviderFor(closePollUseCase)
const closePollUseCaseProvider = ClosePollUseCaseProvider._();

final class ClosePollUseCaseProvider
    extends
        $FunctionalProvider<
          ClosePollUseCase,
          ClosePollUseCase,
          ClosePollUseCase
        >
    with $Provider<ClosePollUseCase> {
  const ClosePollUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'closePollUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$closePollUseCaseHash();

  @$internal
  @override
  $ProviderElement<ClosePollUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ClosePollUseCase create(Ref ref) {
    return closePollUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClosePollUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClosePollUseCase>(value),
    );
  }
}

String _$closePollUseCaseHash() => r'f3c8d6f1c27d178d3a652380f5db78904fad86a0';

@ProviderFor(deletePollUseCase)
const deletePollUseCaseProvider = DeletePollUseCaseProvider._();

final class DeletePollUseCaseProvider
    extends
        $FunctionalProvider<
          DeletePollUseCase,
          DeletePollUseCase,
          DeletePollUseCase
        >
    with $Provider<DeletePollUseCase> {
  const DeletePollUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletePollUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deletePollUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeletePollUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeletePollUseCase create(Ref ref) {
    return deletePollUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeletePollUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeletePollUseCase>(value),
    );
  }
}

String _$deletePollUseCaseHash() => r'a3a6a062bb2efc9ba0a9cc6f417c52e4ac895dfb';

@ProviderFor(getAllPollsUseCase)
const getAllPollsUseCaseProvider = GetAllPollsUseCaseProvider._();

final class GetAllPollsUseCaseProvider
    extends
        $FunctionalProvider<
          GetAllPollsUseCase,
          GetAllPollsUseCase,
          GetAllPollsUseCase
        >
    with $Provider<GetAllPollsUseCase> {
  const GetAllPollsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllPollsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllPollsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAllPollsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAllPollsUseCase create(Ref ref) {
    return getAllPollsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllPollsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllPollsUseCase>(value),
    );
  }
}

String _$getAllPollsUseCaseHash() =>
    r'0713516eb8983095eb2096286ed52b0ccf9355e0';

@ProviderFor(PollsList)
const pollsListProvider = PollsListFamily._();

final class PollsListProvider
    extends $AsyncNotifierProvider<PollsList, List<Poll>> {
  const PollsListProvider._({
    required PollsListFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'pollsListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pollsListHash();

  @override
  String toString() {
    return r'pollsListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PollsList create() => PollsList();

  @override
  bool operator ==(Object other) {
    return other is PollsListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pollsListHash() => r'5423985fda667e20f9b4647f9c78742aa79d7609';

final class PollsListFamily extends $Family
    with
        $ClassFamilyOverride<
          PollsList,
          AsyncValue<List<Poll>>,
          List<Poll>,
          FutureOr<List<Poll>>,
          int
        > {
  const PollsListFamily._()
    : super(
        retry: null,
        name: r'pollsListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PollsListProvider call(int conversationId) =>
      PollsListProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'pollsListProvider';
}

abstract class _$PollsList extends $AsyncNotifier<List<Poll>> {
  late final _$args = ref.$arg as int;
  int get conversationId => _$args;

  FutureOr<List<Poll>> build(int conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<List<Poll>>, List<Poll>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Poll>>, List<Poll>>,
              AsyncValue<List<Poll>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
