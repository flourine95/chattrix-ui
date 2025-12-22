// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'birthday_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(birthdayApiService)
const birthdayApiServiceProvider = BirthdayApiServiceProvider._();

final class BirthdayApiServiceProvider
    extends
        $FunctionalProvider<
          BirthdayApiService,
          BirthdayApiService,
          BirthdayApiService
        >
    with $Provider<BirthdayApiService> {
  const BirthdayApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'birthdayApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$birthdayApiServiceHash();

  @$internal
  @override
  $ProviderElement<BirthdayApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BirthdayApiService create(Ref ref) {
    return birthdayApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BirthdayApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BirthdayApiService>(value),
    );
  }
}

String _$birthdayApiServiceHash() =>
    r'381f5bd9cde0677033d5d19b27fab6df5ce1f49e';

@ProviderFor(birthdayRepository)
const birthdayRepositoryProvider = BirthdayRepositoryProvider._();

final class BirthdayRepositoryProvider
    extends
        $FunctionalProvider<
          BirthdayRepository,
          BirthdayRepository,
          BirthdayRepository
        >
    with $Provider<BirthdayRepository> {
  const BirthdayRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'birthdayRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$birthdayRepositoryHash();

  @$internal
  @override
  $ProviderElement<BirthdayRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BirthdayRepository create(Ref ref) {
    return birthdayRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BirthdayRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BirthdayRepository>(value),
    );
  }
}

String _$birthdayRepositoryHash() =>
    r'41fe4c400cfce2db58e94cf3231fa0ca636090ca';

@ProviderFor(getTodayBirthdaysUseCase)
const getTodayBirthdaysUseCaseProvider = GetTodayBirthdaysUseCaseProvider._();

final class GetTodayBirthdaysUseCaseProvider
    extends
        $FunctionalProvider<
          GetTodayBirthdaysUseCase,
          GetTodayBirthdaysUseCase,
          GetTodayBirthdaysUseCase
        >
    with $Provider<GetTodayBirthdaysUseCase> {
  const GetTodayBirthdaysUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTodayBirthdaysUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTodayBirthdaysUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTodayBirthdaysUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTodayBirthdaysUseCase create(Ref ref) {
    return getTodayBirthdaysUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTodayBirthdaysUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTodayBirthdaysUseCase>(value),
    );
  }
}

String _$getTodayBirthdaysUseCaseHash() =>
    r'8e93d672760307833a1a2845e756bdd83752e7ef';

@ProviderFor(getUpcomingBirthdaysUseCase)
const getUpcomingBirthdaysUseCaseProvider =
    GetUpcomingBirthdaysUseCaseProvider._();

final class GetUpcomingBirthdaysUseCaseProvider
    extends
        $FunctionalProvider<
          GetUpcomingBirthdaysUseCase,
          GetUpcomingBirthdaysUseCase,
          GetUpcomingBirthdaysUseCase
        >
    with $Provider<GetUpcomingBirthdaysUseCase> {
  const GetUpcomingBirthdaysUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUpcomingBirthdaysUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUpcomingBirthdaysUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetUpcomingBirthdaysUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetUpcomingBirthdaysUseCase create(Ref ref) {
    return getUpcomingBirthdaysUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUpcomingBirthdaysUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUpcomingBirthdaysUseCase>(value),
    );
  }
}

String _$getUpcomingBirthdaysUseCaseHash() =>
    r'38bec271a5ccf71576eff6ea586e914076ad196f';

@ProviderFor(sendBirthdayWishesUseCase)
const sendBirthdayWishesUseCaseProvider = SendBirthdayWishesUseCaseProvider._();

final class SendBirthdayWishesUseCaseProvider
    extends
        $FunctionalProvider<
          SendBirthdayWishesUseCase,
          SendBirthdayWishesUseCase,
          SendBirthdayWishesUseCase
        >
    with $Provider<SendBirthdayWishesUseCase> {
  const SendBirthdayWishesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendBirthdayWishesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendBirthdayWishesUseCaseHash();

  @$internal
  @override
  $ProviderElement<SendBirthdayWishesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SendBirthdayWishesUseCase create(Ref ref) {
    return sendBirthdayWishesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendBirthdayWishesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendBirthdayWishesUseCase>(value),
    );
  }
}

String _$sendBirthdayWishesUseCaseHash() =>
    r'9682b8b3c45d9565c2b525c6283470fa56316fba';

@ProviderFor(TodayBirthdays)
const todayBirthdaysProvider = TodayBirthdaysProvider._();

final class TodayBirthdaysProvider
    extends $AsyncNotifierProvider<TodayBirthdays, List<BirthdayUserEntity>> {
  const TodayBirthdaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayBirthdaysProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayBirthdaysHash();

  @$internal
  @override
  TodayBirthdays create() => TodayBirthdays();
}

String _$todayBirthdaysHash() => r'cd56579938b01cf5179ff382796410a74a49b28c';

abstract class _$TodayBirthdays
    extends $AsyncNotifier<List<BirthdayUserEntity>> {
  FutureOr<List<BirthdayUserEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<BirthdayUserEntity>>,
              List<BirthdayUserEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<BirthdayUserEntity>>,
                List<BirthdayUserEntity>
              >,
              AsyncValue<List<BirthdayUserEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(UpcomingBirthdays)
const upcomingBirthdaysProvider = UpcomingBirthdaysFamily._();

final class UpcomingBirthdaysProvider
    extends
        $AsyncNotifierProvider<UpcomingBirthdays, List<BirthdayUserEntity>> {
  const UpcomingBirthdaysProvider._({
    required UpcomingBirthdaysFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'upcomingBirthdaysProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$upcomingBirthdaysHash();

  @override
  String toString() {
    return r'upcomingBirthdaysProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UpcomingBirthdays create() => UpcomingBirthdays();

  @override
  bool operator ==(Object other) {
    return other is UpcomingBirthdaysProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$upcomingBirthdaysHash() => r'88433083b5da751f8d426a63f6964e8ce403e9fd';

final class UpcomingBirthdaysFamily extends $Family
    with
        $ClassFamilyOverride<
          UpcomingBirthdays,
          AsyncValue<List<BirthdayUserEntity>>,
          List<BirthdayUserEntity>,
          FutureOr<List<BirthdayUserEntity>>,
          int
        > {
  const UpcomingBirthdaysFamily._()
    : super(
        retry: null,
        name: r'upcomingBirthdaysProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UpcomingBirthdaysProvider call({int days = 7}) =>
      UpcomingBirthdaysProvider._(argument: days, from: this);

  @override
  String toString() => r'upcomingBirthdaysProvider';
}

abstract class _$UpcomingBirthdays
    extends $AsyncNotifier<List<BirthdayUserEntity>> {
  late final _$args = ref.$arg as int;
  int get days => _$args;

  FutureOr<List<BirthdayUserEntity>> build({int days = 7});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(days: _$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<BirthdayUserEntity>>,
              List<BirthdayUserEntity>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<BirthdayUserEntity>>,
                List<BirthdayUserEntity>
              >,
              AsyncValue<List<BirthdayUserEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
