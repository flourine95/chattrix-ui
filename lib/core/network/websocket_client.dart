abstract class WebSocketClient {
  Future<void> connect(String url);

  Future<void> disconnect();

  void send(String message);

  Stream<String> get messageStream;

  Stream<bool> get connectionStream;

  bool get isConnected;

  void dispose();
}
