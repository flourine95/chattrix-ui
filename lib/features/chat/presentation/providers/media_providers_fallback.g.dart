// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'media_providers_fallback.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fallback provider that extracts media from messages if API doesn't work

@ProviderFor(conversationMediaFallback)
const conversationMediaFallbackProvider = ConversationMediaFallbackFamily._();

/// Fallback provider that extracts media from messages if API doesn't work

final class ConversationMediaFallbackProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MediaItem>>,
          List<MediaItem>,
          FutureOr<List<MediaItem>>
        >
    with $FutureModifier<List<MediaItem>>, $FutureProvider<List<MediaItem>> {
  /// Fallback provider that extracts media from messages if API doesn't work
  const ConversationMediaFallbackProvider._({
    required ConversationMediaFallbackFamily super.from,
    required (int, {int limit}) super.argument,
  }) : super(
         retry: null,
         name: r'conversationMediaFallbackProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$conversationMediaFallbackHash();

  @override
  String toString() {
    return r'conversationMediaFallbackProvider'
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
    final argument = this.argument as (int, {int limit});
    return conversationMediaFallback(ref, argument.$1, limit: argument.limit);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationMediaFallbackProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$conversationMediaFallbackHash() =>
    r'ad29560d893c67a4b79289a80a5062c6b98e86ce';

/// Fallback provider that extracts media from messages if API doesn't work

final class ConversationMediaFallbackFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<MediaItem>>,
          (int, {int limit})
        > {
  const ConversationMediaFallbackFamily._()
    : super(
        retry: null,
        name: r'conversationMediaFallbackProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Fallback provider that extracts media from messages if API doesn't work

  ConversationMediaFallbackProvider call(int conversationId, {int limit = 6}) =>
      ConversationMediaFallbackProvider._(
        argument: (conversationId, limit: limit),
        from: this,
      );

  @override
  String toString() => r'conversationMediaFallbackProvider';
}
