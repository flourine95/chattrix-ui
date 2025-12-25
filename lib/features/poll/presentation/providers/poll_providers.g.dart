// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'poll_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pollApiService)
const pollApiServiceProvider = PollApiServiceProvider._();

final class PollApiServiceProvider
    extends $FunctionalProvider<PollApiService, PollApiService, PollApiService>
    with $Provider<PollApiService> {
  const PollApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pollApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pollApiServiceHash();

  @$internal
  @override
  $ProviderElement<PollApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PollApiService create(Ref ref) {
    return pollApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PollApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PollApiService>(value),
    );
  }
}

String _$pollApiServiceHash() => r'9f7e3f1ad653b063a341910ec947b13005561597';

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
        isAutoDispose: false,
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

String _$pollRepositoryHash() => r'370946578bde6cde8743cf87f2ee17f67af09871';

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

@ProviderFor(getPollUseCase)
const getPollUseCaseProvider = GetPollUseCaseProvider._();

final class GetPollUseCaseProvider
    extends $FunctionalProvider<GetPollUseCase, GetPollUseCase, GetPollUseCase>
    with $Provider<GetPollUseCase> {
  const GetPollUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPollUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPollUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPollUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetPollUseCase create(Ref ref) {
    return getPollUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPollUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPollUseCase>(value),
    );
  }
}

String _$getPollUseCaseHash() => r'807bb5bc8823ac5f7d0d7da0430b1ba84ccdb5d8';

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
