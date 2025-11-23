import 'package:chattrix_ui/features/call/data/services/call_logger.dart';

/// Utility class for validating channel ID format
/// Expected format: channel_{timestamp}_{userId1}_{userId2}
class ChannelIdValidator {
  // Regular expression to match the expected channel ID format
  // Format: channel_{timestamp}_{userId1}_{userId2}
  // - timestamp: numeric (milliseconds since epoch)
  // - userId1 and userId2: non-empty alphanumeric strings with underscores/hyphens
  static final RegExp _channelIdPattern = RegExp(r'^channel_\d+_[\w-]+_[\w-]+$');

  /// Validates if a channel ID matches the expected format
  /// Returns true if valid, false otherwise
  /// Logs a warning if the format doesn't match
  static bool validate(String channelId) {
    final isValid = _channelIdPattern.hasMatch(channelId);

    if (!isValid) {
      CallLogger.logWarning(
        'Channel ID format validation failed: "$channelId" does not match expected pattern "channel_{timestamp}_{userId1}_{userId2}"',
      );
    } else {
      CallLogger.logDebug('Channel ID format validated successfully: $channelId');
    }

    return isValid;
  }

  /// Validates and logs the channel ID format
  /// This is a convenience method that always returns the channel ID
  /// but logs a warning if the format is invalid
  static String validateAndLog(String channelId) {
    validate(channelId);
    return channelId;
  }

  /// Extracts components from a valid channel ID
  /// Returns a map with 'timestamp', 'userId1', and 'userId2' keys
  /// Returns null if the channel ID format is invalid
  static Map<String, String>? extractComponents(String channelId) {
    if (!_channelIdPattern.hasMatch(channelId)) {
      return null;
    }

    // Split by underscore
    final parts = channelId.split('_');

    // Expected format: ['channel', timestamp, userId1, userId2, ...]
    if (parts.length < 4) {
      return null;
    }

    return {'timestamp': parts[1], 'userId1': parts[2], 'userId2': parts[3]};
  }
}
