// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'conversation_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(conversationSettingsDataSource)
final conversationSettingsDataSourceProvider =
    ConversationSettingsDataSourceProvider._();

final class ConversationSettingsDataSourceProvider
    extends
        $FunctionalProvider<
          ConversationSettingsDatasourceImpl,
          ConversationSettingsDatasourceImpl,
          ConversationSettingsDatasourceImpl
        >
    with $Provider<ConversationSettingsDatasourceImpl> {
  ConversationSettingsDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'conversationSettingsDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$conversationSettingsDataSourceHash();

  @$internal
  @override
  $ProviderElement<ConversationSettingsDatasourceImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConversationSettingsDatasourceImpl create(Ref ref) {
    return conversationSettingsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConversationSettingsDatasourceImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConversationSettingsDatasourceImpl>(
        value,
      ),
    );
  }
}

String _$conversationSettingsDataSourceHash() =>
    r'0e959c20c0e49ca99d0474afc21d64733bd0a4c0';

@ProviderFor(conversationSettingsRepository)
final conversationSettingsRepositoryProvider =
    ConversationSettingsRepositoryProvider._();

final class ConversationSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          ConversationSettingsRepository,
          ConversationSettingsRepository,
          ConversationSettingsRepository
        >
    with $Provider<ConversationSettingsRepository> {
  ConversationSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'conversationSettingsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$conversationSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ConversationSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConversationSettingsRepository create(Ref ref) {
    return conversationSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConversationSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConversationSettingsRepository>(
        value,
      ),
    );
  }
}

String _$conversationSettingsRepositoryHash() =>
    r'6db6b308a92f4d39b00345cb9fa78f918e4e212f';

@ProviderFor(ConversationSettingsNotifier)
final conversationSettingsProvider = ConversationSettingsNotifierFamily._();

final class ConversationSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          ConversationSettingsNotifier,
          ConversationSettings?
        > {
  ConversationSettingsNotifierProvider._({
    required ConversationSettingsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'conversationSettingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$conversationSettingsNotifierHash();

  @override
  String toString() {
    return r'conversationSettingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ConversationSettingsNotifier create() => ConversationSettingsNotifier();

  @override
  bool operator ==(Object other) {
    return other is ConversationSettingsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$conversationSettingsNotifierHash() =>
    r'986a2170262c6082d2fed284a22e7d4ee7daf401';

final class ConversationSettingsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ConversationSettingsNotifier,
          AsyncValue<ConversationSettings?>,
          ConversationSettings?,
          FutureOr<ConversationSettings?>,
          int
        > {
  ConversationSettingsNotifierFamily._()
    : super(
        retry: null,
        name: r'conversationSettingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ConversationSettingsNotifierProvider call(int conversationId) =>
      ConversationSettingsNotifierProvider._(
        argument: conversationId,
        from: this,
      );

  @override
  String toString() => r'conversationSettingsProvider';
}

abstract class _$ConversationSettingsNotifier
    extends $AsyncNotifier<ConversationSettings?> {
  late final _$args = ref.$arg as int;
  int get conversationId => _$args;

  FutureOr<ConversationSettings?> build(int conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<ConversationSettings?>, ConversationSettings?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ConversationSettings?>,
                ConversationSettings?
              >,
              AsyncValue<ConversationSettings?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
