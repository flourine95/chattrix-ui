// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'events_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventsRepository)
const eventsRepositoryProvider = EventsRepositoryProvider._();

final class EventsRepositoryProvider
    extends
        $FunctionalProvider<
          EventsRepository,
          EventsRepository,
          EventsRepository
        >
    with $Provider<EventsRepository> {
  const EventsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsRepositoryHash();

  @$internal
  @override
  $ProviderElement<EventsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventsRepository create(Ref ref) {
    return eventsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventsRepository>(value),
    );
  }
}

String _$eventsRepositoryHash() => r'5b0ac7421c6ece34ebc04822741c11a0881a0362';

@ProviderFor(EventsList)
const eventsListProvider = EventsListFamily._();

final class EventsListProvider
    extends $AsyncNotifierProvider<EventsList, List<EventEntity>> {
  const EventsListProvider._({
    required EventsListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'eventsListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventsListHash();

  @override
  String toString() {
    return r'eventsListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventsList create() => EventsList();

  @override
  bool operator ==(Object other) {
    return other is EventsListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventsListHash() => r'7c4197d2f90a761a5f66ad70821821c120810119';

final class EventsListFamily extends $Family
    with
        $ClassFamilyOverride<
          EventsList,
          AsyncValue<List<EventEntity>>,
          List<EventEntity>,
          FutureOr<List<EventEntity>>,
          String
        > {
  const EventsListFamily._()
    : super(
        retry: null,
        name: r'eventsListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventsListProvider call(String conversationId) =>
      EventsListProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'eventsListProvider';
}

abstract class _$EventsList extends $AsyncNotifier<List<EventEntity>> {
  late final _$args = ref.$arg as String;
  String get conversationId => _$args;

  FutureOr<List<EventEntity>> build(String conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<List<EventEntity>>, List<EventEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<EventEntity>>, List<EventEntity>>,
              AsyncValue<List<EventEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
