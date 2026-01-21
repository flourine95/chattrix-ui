// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'media_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider to fetch media from a conversation using the new Media Search API
///
/// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, LINK
/// Supports date filtering: startDate, endDate
/// Supports pagination with cursor

@ProviderFor(conversationMedia)
final conversationMediaProvider = ConversationMediaFamily._();

/// Provider to fetch media from a conversation using the new Media Search API
///
/// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, LINK
/// Supports date filtering: startDate, endDate
/// Supports pagination with cursor

final class ConversationMediaProvider
    extends
        $FunctionalProvider<
          AsyncValue<MediaSearchResult>,
          MediaSearchResult,
          FutureOr<MediaSearchResult>
        >
    with
        $FutureModifier<MediaSearchResult>,
        $FutureProvider<MediaSearchResult> {
  /// Provider to fetch media from a conversation using the new Media Search API
  ///
  /// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, LINK
  /// Supports date filtering: startDate, endDate
  /// Supports pagination with cursor
  ConversationMediaProvider._({
    required ConversationMediaFamily super.from,
    required (
      int, {
      int limit,
      List<String>? types,
      DateTime? startDate,
      DateTime? endDate,
      int? cursor,
    })
    super.argument,
  }) : super(
         retry: null,
         name: r'conversationMediaProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$conversationMediaHash();

  @override
  String toString() {
    return r'conversationMediaProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<MediaSearchResult> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MediaSearchResult> create(Ref ref) {
    final argument =
        this.argument
            as (
              int, {
              int limit,
              List<String>? types,
              DateTime? startDate,
              DateTime? endDate,
              int? cursor,
            });
    return conversationMedia(
      ref,
      argument.$1,
      limit: argument.limit,
      types: argument.types,
      startDate: argument.startDate,
      endDate: argument.endDate,
      cursor: argument.cursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationMediaProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$conversationMediaHash() => r'd9eb052ba120b982d19eea666c2951a8a2136252';

/// Provider to fetch media from a conversation using the new Media Search API
///
/// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, LINK
/// Supports date filtering: startDate, endDate
/// Supports pagination with cursor

final class ConversationMediaFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<MediaSearchResult>,
          (
            int, {
            int limit,
            List<String>? types,
            DateTime? startDate,
            DateTime? endDate,
            int? cursor,
          })
        > {
  ConversationMediaFamily._()
    : super(
        retry: null,
        name: r'conversationMediaProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to fetch media from a conversation using the new Media Search API
  ///
  /// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, LINK
  /// Supports date filtering: startDate, endDate
  /// Supports pagination with cursor

  ConversationMediaProvider call(
    int conversationId, {
    int limit = 100,
    List<String>? types,
    DateTime? startDate,
    DateTime? endDate,
    int? cursor,
  }) => ConversationMediaProvider._(
    argument: (
      conversationId,
      limit: limit,
      types: types,
      startDate: startDate,
      endDate: endDate,
      cursor: cursor,
    ),
    from: this,
  );

  @override
  String toString() => r'conversationMediaProvider';
}

/// Provider to fetch media statistics only

@ProviderFor(conversationMediaStatistics)
final conversationMediaStatisticsProvider =
    ConversationMediaStatisticsFamily._();

/// Provider to fetch media statistics only

final class ConversationMediaStatisticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MediaStatistics>,
          MediaStatistics,
          FutureOr<MediaStatistics>
        >
    with $FutureModifier<MediaStatistics>, $FutureProvider<MediaStatistics> {
  /// Provider to fetch media statistics only
  ConversationMediaStatisticsProvider._({
    required ConversationMediaStatisticsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'conversationMediaStatisticsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$conversationMediaStatisticsHash();

  @override
  String toString() {
    return r'conversationMediaStatisticsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MediaStatistics> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MediaStatistics> create(Ref ref) {
    final argument = this.argument as int;
    return conversationMediaStatistics(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationMediaStatisticsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$conversationMediaStatisticsHash() =>
    r'240a72273f07508abe255f1a3d7ef7994fcac8da';

/// Provider to fetch media statistics only

final class ConversationMediaStatisticsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MediaStatistics>, int> {
  ConversationMediaStatisticsFamily._()
    : super(
        retry: null,
        name: r'conversationMediaStatisticsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to fetch media statistics only

  ConversationMediaStatisticsProvider call(int conversationId) =>
      ConversationMediaStatisticsProvider._(
        argument: conversationId,
        from: this,
      );

  @override
  String toString() => r'conversationMediaStatisticsProvider';
}
