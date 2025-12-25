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
const conversationSettingsDataSourceProvider =
    ConversationSettingsDataSourceProvider._();

final class ConversationSettingsDataSourceProvider
    extends
        $FunctionalProvider<
          ConversationSettingsDataSource,
          ConversationSettingsDataSource,
          ConversationSettingsDataSource
        >
    with $Provider<ConversationSettingsDataSource> {
  const ConversationSettingsDataSourceProvider._()
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
  $ProviderElement<ConversationSettingsDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConversationSettingsDataSource create(Ref ref) {
    return conversationSettingsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConversationSettingsDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConversationSettingsDataSource>(
        value,
      ),
    );
  }
}

String _$conversationSettingsDataSourceHash() =>
    r'c1ba7bd25bb032337c29e58e9d13fa730c807156';

@ProviderFor(ConversationSettings)
const conversationSettingsProvider = ConversationSettingsFamily._();

final class ConversationSettingsProvider
    extends
        $AsyncNotifierProvider<
          ConversationSettings,
          ConversationSettingsModel?
        > {
  const ConversationSettingsProvider._({
    required ConversationSettingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'conversationSettingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$conversationSettingsHash();

  @override
  String toString() {
    return r'conversationSettingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ConversationSettings create() => ConversationSettings();

  @override
  bool operator ==(Object other) {
    return other is ConversationSettingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$conversationSettingsHash() =>
    r'9e4f6833b1e64af9ad238a0cef61a20869c0061d';

final class ConversationSettingsFamily extends $Family
    with
        $ClassFamilyOverride<
          ConversationSettings,
          AsyncValue<ConversationSettingsModel?>,
          ConversationSettingsModel?,
          FutureOr<ConversationSettingsModel?>,
          String
        > {
  const ConversationSettingsFamily._()
    : super(
        retry: null,
        name: r'conversationSettingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ConversationSettingsProvider call(String conversationId) =>
      ConversationSettingsProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'conversationSettingsProvider';
}

abstract class _$ConversationSettings
    extends $AsyncNotifier<ConversationSettingsModel?> {
  late final _$args = ref.$arg as String;
  String get conversationId => _$args;

  FutureOr<ConversationSettingsModel?> build(String conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ConversationSettingsModel?>,
              ConversationSettingsModel?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ConversationSettingsModel?>,
                ConversationSettingsModel?
              >,
              AsyncValue<ConversationSettingsModel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
