// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'giphy_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Giphy Service Provider

@ProviderFor(giphyService)
const giphyServiceProvider = GiphyServiceProvider._();

/// Giphy Service Provider

final class GiphyServiceProvider
    extends $FunctionalProvider<GiphyService, GiphyService, GiphyService>
    with $Provider<GiphyService> {
  /// Giphy Service Provider
  const GiphyServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'giphyServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$giphyServiceHash();

  @$internal
  @override
  $ProviderElement<GiphyService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GiphyService create(Ref ref) {
    return giphyService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GiphyService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GiphyService>(value),
    );
  }
}

String _$giphyServiceHash() => r'c38878392d5b1b762e9c2b8d00897dd29a0c62a0';

/// Trending Stickers Provider

@ProviderFor(trendingStickers)
const trendingStickersProvider = TrendingStickersProvider._();

/// Trending Stickers Provider

final class TrendingStickersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GiphySticker>>,
          List<GiphySticker>,
          FutureOr<List<GiphySticker>>
        >
    with
        $FutureModifier<List<GiphySticker>>,
        $FutureProvider<List<GiphySticker>> {
  /// Trending Stickers Provider
  const TrendingStickersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trendingStickersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trendingStickersHash();

  @$internal
  @override
  $FutureProviderElement<List<GiphySticker>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<GiphySticker>> create(Ref ref) {
    return trendingStickers(ref);
  }
}

String _$trendingStickersHash() => r'7d13d186002043e56754cdf4e500cf823a7fc581';

/// Search Stickers Provider

@ProviderFor(searchStickers)
const searchStickersProvider = SearchStickersFamily._();

/// Search Stickers Provider

final class SearchStickersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GiphySticker>>,
          List<GiphySticker>,
          FutureOr<List<GiphySticker>>
        >
    with
        $FutureModifier<List<GiphySticker>>,
        $FutureProvider<List<GiphySticker>> {
  /// Search Stickers Provider
  const SearchStickersProvider._({
    required SearchStickersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchStickersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchStickersHash();

  @override
  String toString() {
    return r'searchStickersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<GiphySticker>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<GiphySticker>> create(Ref ref) {
    final argument = this.argument as String;
    return searchStickers(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchStickersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchStickersHash() => r'eb25f4d07bdad91a4f3dae12df350eb48f131947';

/// Search Stickers Provider

final class SearchStickersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<GiphySticker>>, String> {
  const SearchStickersFamily._()
    : super(
        retry: null,
        name: r'searchStickersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Search Stickers Provider

  SearchStickersProvider call(String query) =>
      SearchStickersProvider._(argument: query, from: this);

  @override
  String toString() => r'searchStickersProvider';
}

/// Category Stickers Provider

@ProviderFor(categoryStickers)
const categoryStickersProvider = CategoryStickersFamily._();

/// Category Stickers Provider

final class CategoryStickersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GiphySticker>>,
          List<GiphySticker>,
          FutureOr<List<GiphySticker>>
        >
    with
        $FutureModifier<List<GiphySticker>>,
        $FutureProvider<List<GiphySticker>> {
  /// Category Stickers Provider
  const CategoryStickersProvider._({
    required CategoryStickersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'categoryStickersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryStickersHash();

  @override
  String toString() {
    return r'categoryStickersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<GiphySticker>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<GiphySticker>> create(Ref ref) {
    final argument = this.argument as String;
    return categoryStickers(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryStickersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryStickersHash() => r'fc09ef3d9689a657f2bdd967f812a82cc48f323f';

/// Category Stickers Provider

final class CategoryStickersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<GiphySticker>>, String> {
  const CategoryStickersFamily._()
    : super(
        retry: null,
        name: r'categoryStickersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Category Stickers Provider

  CategoryStickersProvider call(String category) =>
      CategoryStickersProvider._(argument: category, from: this);

  @override
  String toString() => r'categoryStickersProvider';
}
