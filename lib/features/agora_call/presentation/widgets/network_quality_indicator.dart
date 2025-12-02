import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Widget displaying network quality indicator
/// Shows connection quality with color-coded icon
/// Requirement 7.5: Show network quality indicator
class NetworkQualityIndicator extends StatelessWidget {
  final QualityType quality;

  const NetworkQualityIndicator({super.key, required this.quality});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final qualityInfo = _getQualityInfo(quality);

    // Don't show indicator for unknown or excellent quality
    if (quality == QualityType.qualityUnknown || quality == QualityType.qualityExcellent) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: qualityInfo.color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: qualityInfo.color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(FontAwesomeIcons.wifi, size: 14, color: qualityInfo.color),
          const SizedBox(width: 6),
          Text(
            qualityInfo.label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: qualityInfo.color,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  /// Get quality information (color and label) based on quality type
  _QualityInfo _getQualityInfo(QualityType quality) {
    switch (quality) {
      case QualityType.qualityExcellent:
        return const _QualityInfo(color: Colors.green, label: 'Excellent');
      case QualityType.qualityGood:
        return const _QualityInfo(color: Colors.lightGreen, label: 'Good');
      case QualityType.qualityPoor:
        return const _QualityInfo(color: Colors.orange, label: 'Poor');
      case QualityType.qualityBad:
        return const _QualityInfo(color: Colors.red, label: 'Bad');
      case QualityType.qualityVbad:
        return const _QualityInfo(color: Colors.red, label: 'Very Bad');
      case QualityType.qualityDown:
        return const _QualityInfo(color: Colors.red, label: 'Disconnected');
      default:
        return const _QualityInfo(color: Colors.grey, label: 'Unknown');
    }
  }
}

/// Quality information data class
class _QualityInfo {
  final Color color;
  final String label;

  const _QualityInfo({required this.color, required this.label});
}
