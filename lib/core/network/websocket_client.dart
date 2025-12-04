/// Core WebSocket client interface for Clean Architecture
/// This abstracts the underlying WebSocket implementation
abstract class WebSocketClient {
  /// Connect to WebSocket server
  Future<void> connect(String url);

  /// Disconnect from WebSocket server
  Future<void> disconnect();

  /// Send a message through WebSocket
  void send(String message);

  /// Stream of incoming messages
  Stream<String> get messageStream;

  /// Stream of connection state
  Stream<bool> get connectionStream;

  /// Check if currently connected
  bool get isConnected;

  /// Dispose resources
  void dispose();
}

