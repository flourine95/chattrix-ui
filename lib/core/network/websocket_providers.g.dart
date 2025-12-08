// GENERATED CODE - DO NOT MODIFY BY HAND

// dart format off
// coverage:ignore-file


part of 'websocket_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 2. WebSocket Client
/// Sử dụng @Riverpod(keepAlive: true) để tạo Singleton (tương đương Provider gốc không có autoDispose)

@ProviderFor(webSocketClient)
const webSocketClientProvider = WebSocketClientProvider._();

/// 2. WebSocket Client
/// Sử dụng @Riverpod(keepAlive: true) để tạo Singleton (tương đương Provider gốc không có autoDispose)

final class WebSocketClientProvider
    extends
        $FunctionalProvider<WebSocketClient, WebSocketClient, WebSocketClient>
    with $Provider<WebSocketClient> {
  /// 2. WebSocket Client
  /// Sử dụng @Riverpod(keepAlive: true) để tạo Singleton (tương đương Provider gốc không có autoDispose)
  const WebSocketClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSocketClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSocketClientHash();

  @$internal
  @override
  $ProviderElement<WebSocketClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WebSocketClient create(Ref ref) {
    return webSocketClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocketClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocketClient>(value),
    );
  }
}

String _$webSocketClientHash() => r'ec6251da86914721d6ace6cf1245aac3de72ec19';

/// 3. Message Router

@ProviderFor(webSocketMessageRouter)
const webSocketMessageRouterProvider = WebSocketMessageRouterProvider._();

/// 3. Message Router

final class WebSocketMessageRouterProvider
    extends
        $FunctionalProvider<
          WebSocketMessageRouter,
          WebSocketMessageRouter,
          WebSocketMessageRouter
        >
    with $Provider<WebSocketMessageRouter> {
  /// 3. Message Router
  const WebSocketMessageRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSocketMessageRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSocketMessageRouterHash();

  @$internal
  @override
  $ProviderElement<WebSocketMessageRouter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WebSocketMessageRouter create(Ref ref) {
    return webSocketMessageRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocketMessageRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocketMessageRouter>(value),
    );
  }
}

String _$webSocketMessageRouterHash() =>
    r'fc596012397fd8a219eaa65b550dcd3b0dac9c08';

/// 4. Connection Manager

@ProviderFor(webSocketConnectionManager)
const webSocketConnectionManagerProvider =
    WebSocketConnectionManagerProvider._();

/// 4. Connection Manager

final class WebSocketConnectionManagerProvider
    extends
        $FunctionalProvider<
          WebSocketConnectionManager,
          WebSocketConnectionManager,
          WebSocketConnectionManager
        >
    with $Provider<WebSocketConnectionManager> {
  /// 4. Connection Manager
  const WebSocketConnectionManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSocketConnectionManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSocketConnectionManagerHash();

  @$internal
  @override
  $ProviderElement<WebSocketConnectionManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WebSocketConnectionManager create(Ref ref) {
    return webSocketConnectionManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocketConnectionManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocketConnectionManager>(value),
    );
  }
}

String _$webSocketConnectionManagerHash() =>
    r'b3ddaafa421d7b871a4e5c5f29fc7e006263b554';

/// 5. WebSocket Service

@ProviderFor(webSocketService)
const webSocketServiceProvider = WebSocketServiceProvider._();

/// 5. WebSocket Service

final class WebSocketServiceProvider
    extends
        $FunctionalProvider<
          WebSocketService,
          WebSocketService,
          WebSocketService
        >
    with $Provider<WebSocketService> {
  /// 5. WebSocket Service
  const WebSocketServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webSocketServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webSocketServiceHash();

  @$internal
  @override
  $ProviderElement<WebSocketService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WebSocketService create(Ref ref) {
    return webSocketService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocketService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocketService>(value),
    );
  }
}

String _$webSocketServiceHash() => r'e39a9d9f9ada76d10d3416c86d0c66226cf19653';
