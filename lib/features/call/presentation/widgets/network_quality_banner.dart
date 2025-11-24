import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:flutter/material.dart';

/// Widget that displays network quality warnings during calls
/// Shows warning banner for poor network quality and reconnecting indicator
class NetworkQualityBanner extends StatelessWidget {
  const NetworkQualityBanner({super.key, required this.networkQuality, this.isReconnecting = false});

  final NetworkQuality? networkQuality;
  final bool isReconnecting;

  @override
  Widget build(BuildContext context) {
    // Show reconnecting indicator with highest priority
    if (isReconnecting) {
      return _buildBanner(
        context: context,
        icon: Icons.sync,
        message: 'Reconnecting...',
        color: Colors.orange,
        isAnimated: true,
      );
    }

    // Show network quality warnings
    if (networkQuality != null) {
      switch (networkQuality!) {
        case NetworkQuality.poor:
          return _buildBanner(
            context: context,
            icon: Icons.signal_cellular_alt_2_bar,
            message: 'Poor network quality',
            color: Colors.orange,
          );
        case NetworkQuality.bad:
          return _buildBanner(
            context: context,
            icon: Icons.signal_cellular_alt_1_bar,
            message: 'Bad network quality - call may drop',
            color: Colors.deepOrange,
          );
        case NetworkQuality.veryBad:
          return _buildBanner(
            context: context,
            icon: Icons.signal_cellular_connected_no_internet_0_bar,
            message: 'Very poor connection - call unstable',
            color: Colors.red,
          );
        case NetworkQuality.excellent:
        case NetworkQuality.good:
        case NetworkQuality.unknown:
          return const SizedBox.shrink();
      }
    }

    return const SizedBox.shrink();
  }

  Widget _buildBanner({
    required BuildContext context,
    required IconData icon,
    required String message,
    required Color color,
    bool isAnimated = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.9),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAnimated)
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.9)),
              ),
            )
          else
            Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
