import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthNotifierWrapper extends ChangeNotifier {
  AuthNotifierWrapper(this._ref) {
    _ref.listen<AuthState>(authNotifierProvider, (_, _) => notifyListeners());
  }

  final Ref _ref;
}

final authNotifierWrapperProvider = Provider<AuthNotifierWrapper>((ref) {
  return AuthNotifierWrapper(ref);
});

class CallNotifierWrapper extends ChangeNotifier {
  CallNotifierWrapper(this._ref) {
    _ref.listen(callProvider, (_, _) => notifyListeners());
  }

  final Ref _ref;
}

final callNotifierWrapperProvider = Provider<CallNotifierWrapper>((ref) {
  return CallNotifierWrapper(ref);
});

