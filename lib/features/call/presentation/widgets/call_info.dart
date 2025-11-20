import 'dart:async';

import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Widget that displays call information at the top of the screen
/// Shows remote user name, call duration, network quality, and connection status
class CallInfo extends HookConsumerWidget {
  const CallInfo({super.key, required this.call});

  final CallEntity call;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = _useCallDuration(call.startTime);
    final networkQuality = ref.watch(networkQualityProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withOpacity(0.6), Colors.transparent],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Remote user name
          Text(
            call.remoteUserId,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Call duration
          Text(_formatDuration(duration), style: const TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 8),

          // Connection status and network quality
          Row(
            children: [
              // Connection status
              _buildStatusIndicator(call.status),
              const SizedBox(width: 16),

              // Network quality indicator
              networkQuality.when(
                data: (quality) => _buildNetworkQualityIndicator(quality),
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(CallStatus status) {
    String statusText;
    Color statusColor;

    switch (status) {
      case CallStatus.initiating:
        statusText = 'Initiating...';
        statusColor = Colors.orange;
        break;
      case CallStatus.ringing:
        statusText = 'Ringing...';
        statusColor = Colors.blue;
        break;
      case CallStatus.connecting:
        statusText = 'Connecting...';
        statusColor = Colors.yellow;
        break;
      case CallStatus.connected:
        statusText = 'Connected';
        statusColor = Colors.green;
        break;
      case CallStatus.disconnecting:
        statusText = 'Disconnecting...';
        statusColor = Colors.orange;
        break;
      case CallStatus.ended:
        statusText = 'Ended';
        statusColor = Colors.grey;
        break;
      case CallStatus.missed:
        statusText = 'Missed';
        statusColor = Colors.red;
        break;
      case CallStatus.rejected:
        statusText = 'Rejected';
        statusColor = Colors.red;
        break;
      case CallStatus.failed:
        statusText = 'Failed';
        statusColor = Colors.red;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: statusColor),
        ),
        const SizedBox(width: 6),
        Text(
          statusText,
          style: TextStyle(color: statusColor, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildNetworkQualityIndicator(NetworkQuality quality) {
    IconData icon;
    Color color;
    String label;

    switch (quality) {
      case NetworkQuality.excellent:
        icon = Icons.signal_cellular_alt;
        color = Colors.green;
        label = 'Excellent';
        break;
      case NetworkQuality.good:
        icon = Icons.signal_cellular_alt_2_bar;
        color = Colors.lightGreen;
        label = 'Good';
        break;
      case NetworkQuality.poor:
        icon = Icons.signal_cellular_alt_1_bar;
        color = Colors.orange;
        label = 'Poor';
        break;
      case NetworkQuality.bad:
        icon = Icons.signal_cellular_connected_no_internet_0_bar;
        color = Colors.red;
        label = 'Bad';
        break;
      case NetworkQuality.veryBad:
        icon = Icons.signal_cellular_connected_no_internet_0_bar;
        color = Colors.red.shade900;
        label = 'Very Bad';
        break;
      case NetworkQuality.unknown:
        icon = Icons.signal_cellular_null;
        color = Colors.grey;
        label = 'Unknown';
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }
}

/// Custom hook to track call duration
Duration _useCallDuration(DateTime startTime) {
  final duration = useState(Duration.zero);

  useEffect(() {
    final timer = Timer.periodic(const Duration(seconds: 1), (_) {
      duration.value = DateTime.now().difference(startTime);
    });

    return timer.cancel;
  }, [startTime]);

  return duration.value;
}
