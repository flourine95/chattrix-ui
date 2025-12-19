import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'call_control_state_providers.g.dart';

/// Separate state providers for call controls
/// Each provider manages its own state independently to prevent unnecessary rebuilds

@Riverpod(keepAlive: true)
class IsMutedState extends _$IsMutedState {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void set(bool value) => state = value;
}

@Riverpod(keepAlive: true)
class IsVideoEnabledState extends _$IsVideoEnabledState {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void set(bool value) => state = value;
}

@Riverpod(keepAlive: true)
class IsSpeakerEnabledState extends _$IsSpeakerEnabledState {
  @override
  bool build() => true;

  void toggle() => state = !state;
  void set(bool value) => state = value;
}

@Riverpod(keepAlive: true)
class IsFrontCameraState extends _$IsFrontCameraState {
  @override
  bool build() => true;

  void toggle() => state = !state;
  void set(bool value) => state = value;
}

@Riverpod(keepAlive: true)
class RemoteIsMutedState extends _$RemoteIsMutedState {
  @override
  bool build() => false;

  void set(bool value) => state = value;
}

@Riverpod(keepAlive: true)
class RemoteIsVideoEnabledState extends _$RemoteIsVideoEnabledState {
  @override
  bool build() => false;

  void set(bool value) => state = value;
}

@Riverpod(keepAlive: true)
class RemoteUidState extends _$RemoteUidState {
  @override
  int? build() => null;

  void set(int? value) => state = value;
}
