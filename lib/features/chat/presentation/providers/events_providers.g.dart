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
final eventsRepositoryProvider = EventsRepositoryProvider._();

final class EventsRepositoryProvider
    extends
        $FunctionalProvider<
          EventsRepository,
          EventsRepository,
          EventsRepository
        >
    with $Provider<EventsRepository> {
  EventsRepositoryProvider._()
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
final eventsListProvider = EventsListFamily._();

final class EventsListProvider
    extends $AsyncNotifierProvider<EventsList, List<EventEntity>> {
  EventsListProvider._({
    required EventsListFamily super.from,
    required int super.argument,
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

String _$eventsListHash() => r'dd4a7e96bb6dbc28638fdcf241df35eb461df7d5';

final class EventsListFamily extends $Family
    with
        $ClassFamilyOverride<
          EventsList,
          AsyncValue<List<EventEntity>>,
          List<EventEntity>,
          FutureOr<List<EventEntity>>,
          int
        > {
  EventsListFamily._()
    : super(
        retry: null,
        name: r'eventsListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventsListProvider call(int conversationId) =>
      EventsListProvider._(argument: conversationId, from: this);

  @override
  String toString() => r'eventsListProvider';
}

abstract class _$EventsList extends $AsyncNotifier<List<EventEntity>> {
  late final _$args = ref.$arg as int;
  int get conversationId => _$args;

  FutureOr<List<EventEntity>> build(int conversationId);
  @$mustCallSuper
  @override
  void runBuild() {
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
    element.handleCreate(ref, () => build(_$args));
  }
}
