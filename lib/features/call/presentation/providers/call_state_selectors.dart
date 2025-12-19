import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/call_notifier.dart';
import '../state/call_state.dart';

part 'call_state_selectors.g.dart';

/// Optimized selector providers using Notifier pattern
/// Riverpod automatically caches and only notifies when values change
/// keepAlive prevents disposal during navigation

@Riverpod(keepAlive: true)
class IsCallConnectedNotifier extends _$IsCallConnectedNotifier {
  @override
  bool build() {
    final state = ref.watch(callProvider);
    return state.maybeWhen(connected: (_, _, _, _, _, _, _, _, _, _) => true, orElse: () => false);
  }
}

@Riverpod(keepAlive: true)
class IsMutedNotifier extends _$IsMutedNotifier {
  @override
  bool build() {
    final state = ref.watch(callProvider);
    return state.maybeWhen(connected: (_, _, _, isMuted, _, _, _, _, _, _) => isMuted, orElse: () => false);
  }
}

@Riverpod(keepAlive: true)
class IsVideoEnabledNotifier extends _$IsVideoEnabledNotifier {
  @override
  bool build() {
    final state = ref.watch(callProvider);
    return state.maybeWhen(
      connected: (_, _, _, _, isVideoEnabled, _, _, _, _, _) => isVideoEnabled,
      orElse: () => false,
    );
  }
}

@Riverpod(keepAlive: true)
class IsSpeakerEnabledNotifier extends _$IsSpeakerEnabledNotifier {
  @override
  bool build() {
    final state = ref.watch(callProvider);
    return state.maybeWhen(
      connected: (_, _, _, _, _, isSpeakerEnabled, _, _, _, _) => isSpeakerEnabled,
      orElse: () => true,
    );
  }
}

@Riverpod(keepAlive: true)
class RemoteIsMutedNotifier extends _$RemoteIsMutedNotifier {
  @override
  bool build() {
    final state = ref.watch(callProvider);
    return state.maybeWhen(connected: (_, _, _, _, _, _, _, _, remoteIsMuted, _) => remoteIsMuted, orElse: () => false);
  }
}

@Riverpod(keepAlive: true)
class RemoteIsVideoEnabledNotifier extends _$RemoteIsVideoEnabledNotifier {
  @override
  bool build() {
    final state = ref.watch(callProvider);
    return state.maybeWhen(
      connected: (_, _, _, _, _, _, _, _, _, remoteIsVideoEnabled) => remoteIsVideoEnabled,
      orElse: () => false,
    );
  }
}

@Riverpod(keepAlive: true)
class RemoteUidNotifier extends _$RemoteUidNotifier {
  @override
  int? build() {
    final state = ref.watch(callProvider);
    return state.maybeWhen(connected: (_, _, _, _, _, _, _, remoteUid, _, _) => remoteUid, orElse: () => null);
  }
}
