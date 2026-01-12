import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pip_state_provider.g.dart';

/// Provider to manage Picture-in-Picture state
@Riverpod(keepAlive: true)
class PipState extends _$PipState {
  GoRouter? _router;

  @override
  bool build() => false;

  void enable() => state = true;
  void disable() => state = false;
  void toggle() => state = !state;

  /// Set the router instance for navigation
  void setRouter(GoRouter router) {
    _router = router;
  }

  /// Expand from PiP to full screen
  void expandToFullScreen(String callRoute) {
    debugPrint('[PiP] Expanding to full screen');
    if (_router != null) {
      _router!.go(callRoute);
      debugPrint('[PiP] Navigated to $callRoute');
      disable();
    } else {
      debugPrint('[PiP] Router not set, cannot navigate');
    }
  }
}

/// Provider to manage PiP position
@Riverpod(keepAlive: true)
class PipPosition extends _$PipPosition {
  @override
  ({double x, double y}) build() => (x: 20, y: 100);

  void update(double x, double y) => state = (x: x, y: y);
}
