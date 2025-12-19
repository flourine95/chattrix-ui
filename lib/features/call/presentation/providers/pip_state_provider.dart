import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pip_state_provider.g.dart';

/// Provider to manage Picture-in-Picture state
@Riverpod(keepAlive: true)
class PipState extends _$PipState {
  @override
  bool build() => false;

  void enable() => state = true;
  void disable() => state = false;
  void toggle() => state = !state;
}

/// Provider to manage PiP position
@Riverpod(keepAlive: true)
class PipPosition extends _$PipPosition {
  @override
  ({double x, double y}) build() => (x: 20, y: 100);

  void update(double x, double y) => state = (x: x, y: y);
}
