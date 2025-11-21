import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Validates environment variables required for the application
class EnvValidator {
  /// Validate that all required environment variables are present and valid
  static void validate() {
    final appId = dotenv.env['AGORA_APP_ID'];

    if (appId == null || appId.isEmpty) {
      throw Exception(
        'AGORA_APP_ID is not set in .env file. '
        'Please add: AGORA_APP_ID=your_app_id',
      );
    }

    if (appId.length != 32) {
      throw Exception(
        'AGORA_APP_ID appears to be invalid (should be 32 characters). '
        'Current length: ${appId.length}',
      );
    }

    print('[EnvValidator] ✅ AGORA_APP_ID validated: ${appId.substring(0, 8)}...');
  }

  /// Get the Agora App ID from environment variables
  static String getAgoraAppId() {
    final appId = dotenv.env['AGORA_APP_ID'];
    if (appId == null || appId.isEmpty) {
      throw Exception('AGORA_APP_ID not found in environment variables');
    }
    return appId;
  }
}
