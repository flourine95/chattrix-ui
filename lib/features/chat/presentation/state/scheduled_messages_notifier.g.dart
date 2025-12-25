// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'scheduled_messages_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for scheduled messages list
///
/// Manages the state of scheduled messages with filtering by status

@ProviderFor(ScheduledMessagesNotifier)
const scheduledMessagesProvider = ScheduledMessagesNotifierFamily._();

/// Notifier for scheduled messages list
///
/// Manages the state of scheduled messages with filtering by status
final class ScheduledMessagesNotifierProvider
    extends
        $AsyncNotifierProvider<
          ScheduledMessagesNotifier,
          List<ScheduledMessage>
        > {
  /// Notifier for scheduled messages list
  ///
  /// Manages the state of scheduled messages with filtering by status
  const ScheduledMessagesNotifierProvider._({
    required ScheduledMessagesNotifierFamily super.from,
    required ({int conversationId, String status}) super.argument,
  }) : super(
         retry: null,
         name: r'scheduledMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$scheduledMessagesNotifierHash();

  @override
  String toString() {
    return r'scheduledMessagesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ScheduledMessagesNotifier create() => ScheduledMessagesNotifier();

  @override
  bool operator ==(Object other) {
    return other is ScheduledMessagesNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$scheduledMessagesNotifierHash() =>
    r'2cc2427f40a4d9ba33109f210022687b22cbf45a';

/// Notifier for scheduled messages list
///
/// Manages the state of scheduled messages with filtering by status

final class ScheduledMessagesNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ScheduledMessagesNotifier,
          AsyncValue<List<ScheduledMessage>>,
          List<ScheduledMessage>,
          FutureOr<List<ScheduledMessage>>,
          ({int conversationId, String status})
        > {
  const ScheduledMessagesNotifierFamily._()
    : super(
        retry: null,
        name: r'scheduledMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Notifier for scheduled messages list
  ///
  /// Manages the state of scheduled messages with filtering by status

  ScheduledMessagesNotifierProvider call({
    required int conversationId,
    String status = 'PENDING',
  }) => ScheduledMessagesNotifierProvider._(
    argument: (conversationId: conversationId, status: status),
    from: this,
  );

  @override
  String toString() => r'scheduledMessagesProvider';
}

/// Notifier for scheduled messages list
///
/// Manages the state of scheduled messages with filtering by status

abstract class _$ScheduledMessagesNotifier
    extends $AsyncNotifier<List<ScheduledMessage>> {
  late final _$args = ref.$arg as ({int conversationId, String status});
  int get conversationId => _$args.conversationId;
  String get status => _$args.status;

  FutureOr<List<ScheduledMessage>> build({
    required int conversationId,
    String status = 'PENDING',
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      conversationId: _$args.conversationId,
      status: _$args.status,
    );
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ScheduledMessage>>, List<ScheduledMessage>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ScheduledMessage>>,
                List<ScheduledMessage>
              >,
              AsyncValue<List<ScheduledMessage>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
