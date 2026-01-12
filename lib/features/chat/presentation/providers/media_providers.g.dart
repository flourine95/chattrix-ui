// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'media_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider to fetch media from a conversation
///
/// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, VOICE, LINK
/// Supports date filtering: startDate, endDate

@ProviderFor(conversationMedia)
const conversationMediaProvider = ConversationMediaFamily._();

/// Provider to fetch media from a conversation
///
/// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, VOICE, LINK
/// Supports date filtering: startDate, endDate

final class ConversationMediaProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MediaItem>>,
          List<MediaItem>,
          FutureOr<List<MediaItem>>
        >
    with $FutureModifier<List<MediaItem>>, $FutureProvider<List<MediaItem>> {
  /// Provider to fetch media from a conversation
  ///
  /// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, VOICE, LINK
  /// Supports date filtering: startDate, endDate
  const ConversationMediaProvider._({
    required ConversationMediaFamily super.from,
    required (
      int, {
      int limit,
      List<String>? types,
      DateTime? startDate,
      DateTime? endDate,
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
  $FutureProviderElement<List<MediaItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MediaItem>> create(Ref ref) {
    final argument =
        this.argument
            as (
              int, {
              int limit,
              List<String>? types,
              DateTime? startDate,
              DateTime? endDate,
            });
    return conversationMedia(
      ref,
      argument.$1,
      limit: argument.limit,
      types: argument.types,
      startDate: argument.startDate,
      endDate: argument.endDate,
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

String _$conversationMediaHash() => r'55f1d3882429b2ff56bf75c0c28d38d81b4742ad';

/// Provider to fetch media from a conversation
///
/// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, VOICE, LINK
/// Supports date filtering: startDate, endDate

final class ConversationMediaFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<MediaItem>>,
          (
            int, {
            int limit,
            List<String>? types,
            DateTime? startDate,
            DateTime? endDate,
          })
        > {
  const ConversationMediaFamily._()
    : super(
        retry: null,
        name: r'conversationMediaProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider to fetch media from a conversation
  ///
  /// Supports multiple media types: IMAGE, VIDEO, FILE, AUDIO, VOICE, LINK
  /// Supports date filtering: startDate, endDate

  ConversationMediaProvider call(
    int conversationId, {
    int limit = 100,
    List<String>? types,
    DateTime? startDate,
    DateTime? endDate,
  }) => ConversationMediaProvider._(
    argument: (
      conversationId,
      limit: limit,
      types: types,
      startDate: startDate,
      endDate: endDate,
    ),
    from: this,
  );

  @override
  String toString() => r'conversationMediaProvider';
}
