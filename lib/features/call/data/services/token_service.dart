import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
  import 'package:chattrix_ui/features/call/data/services/call_logger.dart';

/// Service responsible for managing Agora authentication tokens
///
/// This service handles:
/// - Fetching tokens from the backend server
/// - Token refresh logic
/// - Token expiration handling
class TokenService {
  final Dio _dio;

  TokenService({required Dio dio}) : _dio = dio;

  /// Fetches a new Agora token from the backend server
  ///
  /// The backend will:
  /// 1. Validate the JWT token from Authorization header
  /// 2. Extract user ID from the JWT
  /// 3. Generate a numeric UID from the user ID
  /// 4. Create an Agora token with the specified channel and role
  ///
  /// Parameters:
  /// - [channelId]: The Agora channel ID for which to generate the token
  /// - [role]: The role of the user ('publisher' or 'subscriber')
  /// - [expirationSeconds]: Token expiration time (default: 3600, max: 86400)
  ///
  /// Returns:
  /// - Right({token, uid, channelId, expiresAt}) on success
  /// - Left(Failure) on error
  Future<Either<Failure, Map<String, dynamic>>> fetchToken({
    required String channelId,
    String role = 'publisher',
    int expirationSeconds = 3600,
  }) async {
    CallLogger.logInfo('Fetching Agora token for channel: $channelId, role: $role');

    try {
      // Validate inputs (Subtask 2.3)
      if (channelId.isEmpty) {
        CallLogger.logError('Validation failed: Channel ID is empty');
        return const Left(Failure.validation(message: 'Channel ID cannot be empty'));
      }

      if (!['publisher', 'subscriber'].contains(role)) {
        CallLogger.logError('Validation failed: Invalid role: $role');
        return const Left(Failure.validation(message: 'Role must be either "publisher" or "subscriber"'));
      }

      if (expirationSeconds < 60 || expirationSeconds > 86400) {
        CallLogger.logError('Validation failed: Invalid expiration: $expirationSeconds');
        return const Left(Failure.validation(message: 'Expiration must be between 60 and 86400 seconds'));
      }

      CallLogger.logDebug('Sending request to: ${ApiConstants.agoraTokenGenerate}');
      CallLogger.logDebug('Request body: {channelId: $channelId, role: $role, expirationSeconds: $expirationSeconds}');

      final response = await _dio.post(
        ApiConstants.agoraTokenGenerate,
        data: {'channelId': channelId, 'role': role, 'expirationSeconds': expirationSeconds},
      );

      CallLogger.logDebug('Response status: ${response.statusCode}');
      CallLogger.logDebug('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];

        if (data == null) {
          CallLogger.logError('Invalid response format: missing data field');
          return const Left(
            Failure.server(message: 'Invalid response format from server', errorCode: 'INVALID_RESPONSE_FORMAT'),
          );
        }

        final token = data['token'] as String?;
        final uid = data['uid'] as int?;
        final expiresAt = data['expiresAt'] as String?;

        if (token == null || token.isEmpty) {
          CallLogger.logError('Invalid response: token is missing or empty');
          return const Left(Failure.server(message: 'Token is missing in response', errorCode: 'MISSING_TOKEN'));
        }

        if (uid == null) {
          CallLogger.logError('Invalid response: uid is missing');
          return const Left(Failure.server(message: 'UID is missing in response', errorCode: 'MISSING_UID'));
        }

        CallLogger.logInfo('Token fetched successfully. UID: $uid, Expires: $expiresAt');

        return Right({'token': token, 'uid': uid, 'channelId': channelId, 'expiresAt': expiresAt});
      } else {
        final message = response.data['error']?['message'] ?? 'Failed to fetch token';
        final errorCode = response.data['error']?['code'] ?? 'TOKEN_FETCH_FAILED';

        CallLogger.logError('Token fetch failed: $message (Code: $errorCode)');

        return Left(Failure.server(message: message, errorCode: errorCode));
      }
    } on DioException catch (e) {
      CallLogger.logError('DioException while fetching token: ${e.message}');
      CallLogger.logError('Response: ${e.response?.data}');
      return Left(_handleDioError(e));
    } catch (e, stackTrace) {
      CallLogger.logError('Unexpected error while fetching token: $e', error: e, stackTrace: stackTrace);
      return Left(Failure.unknown(message: 'Unexpected error while fetching token: ${e.toString()}'));
    }
  }

  /// Refreshes an existing Agora token
  ///
  /// Parameters:
  /// - [channelId]: The Agora channel ID
  /// - [oldToken]: The old token (for backend validation)
  ///
  /// Returns:
  /// - Right({token, uid, channelId, expiresAt}) on success
  /// - Left(Failure) on error
  Future<Either<Failure, Map<String, dynamic>>> refreshToken({
    required String channelId,
    required String oldToken,
  }) async {
    CallLogger.logInfo('Refreshing Agora token for channel: $channelId');

    try {
      CallLogger.logDebug('Sending request to: ${ApiConstants.agoraTokenRefresh}');
      CallLogger.logDebug('Request body: {channelId: $channelId, oldToken: [REDACTED]}');

      final response = await _dio.post(
        ApiConstants.agoraTokenRefresh,
        data: {'channelId': channelId, 'oldToken': oldToken},
      );

      CallLogger.logDebug('Response status: ${response.statusCode}');
      CallLogger.logDebug('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final token = data['token'] as String?;
        final uid = data['uid'] as int?;
        final expiresAt = data['expiresAt'] as String?;

        if (token == null || uid == null) {
          CallLogger.logError('Invalid token refresh response: missing token or uid');
          return const Left(
            Failure.server(message: 'Invalid token refresh response', errorCode: 'INVALID_REFRESH_RESPONSE'),
          );
        }

        CallLogger.logInfo('Token refreshed successfully. UID: $uid, Expires: $expiresAt');

        return Right({'token': token, 'uid': uid, 'channelId': channelId, 'expiresAt': expiresAt});
      } else {
        final message = response.data['error']?['message'] ?? 'Failed to refresh token';
        final errorCode = response.data['error']?['code'] ?? 'TOKEN_REFRESH_FAILED';

        CallLogger.logError('Token refresh failed: $message (Code: $errorCode)');

        return Left(Failure.server(message: message, errorCode: errorCode));
      }
    } on DioException catch (e) {
      CallLogger.logError('DioException while refreshing token: ${e.message}');
      CallLogger.logError('Response: ${e.response?.data}');
      return Left(_handleDioError(e));
    } catch (e, stackTrace) {
      CallLogger.logError('Unexpected error while refreshing token: $e', error: e, stackTrace: stackTrace);
      return Left(Failure.unknown(message: 'Unexpected error while refreshing token: ${e.toString()}'));
    }
  }

  /// Handles token expiration events
  ///
  /// This method should be called when the Agora SDK triggers a token
  /// expiration callback. It attempts to refresh the token.
  ///
  /// Parameters:
  /// - [channelId]: The Agora channel ID
  /// - [oldToken]: The old token that expired
  ///
  /// Returns:
  /// - Right(tokenData) on successful refresh
  /// - Left(TokenExpiredFailure) if refresh fails
  Future<Either<Failure, Map<String, dynamic>>> handleTokenExpiration({
    required String channelId,
    required String oldToken,
  }) async {
    final result = await refreshToken(channelId: channelId, oldToken: oldToken);

    return result.fold((failure) {
      CallLogger.logError('Failed to refresh expired token: ${failure.toString()}');
      return Left(Failure.tokenExpired(message: 'Failed to refresh expired token: ${failure.toString()}'));
    }, (tokenData) => Right(tokenData));
  }

  /// Converts Dio errors to appropriate Failure types
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        CallLogger.logError('Connection timeout: ${error.message}');
        return const Failure.network(message: 'Connection timeout. Please check your internet connection.');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final errorData = error.response?.data;
        final message = errorData?['error']?['message'] ?? errorData?['message'] ?? 'Request failed';
        final errorCode = errorData?['error']?['code'] ?? errorData?['errorCode'];

        CallLogger.logError('Bad response: Status $statusCode, Message: $message');

        if (statusCode == 401) {
          return Failure.unauthorized(message: 'Authentication failed. Please login again.', errorCode: errorCode);
        } else if (statusCode == 403) {
          return Failure.forbidden(
            message: 'Access denied. You do not have permission to perform this action.',
            errorCode: errorCode,
          );
        } else if (statusCode == 404) {
          return Failure.notFound(
            message: 'Endpoint not found. Please check if the backend is running correctly.',
            errorCode: errorCode,
          );
        } else if (statusCode == 400) {
          return Failure.validation(message: message);
        } else if (statusCode != null && statusCode >= 500) {
          return Failure.server(message: 'Server error. Please try again later.', errorCode: errorCode);
        } else {
          return Failure.server(message: message, errorCode: errorCode);
        }

      case DioExceptionType.cancel:
        CallLogger.logWarning('Request was cancelled');
        return const Failure.unknown(message: 'Request was cancelled');

      case DioExceptionType.connectionError:
        final baseUrl = error.requestOptions.baseUrl;
        CallLogger.logError('Connection error: Cannot connect to $baseUrl');
        return Failure.network(message: 'Cannot connect to server. Please check if the backend is running at $baseUrl');

      case DioExceptionType.unknown:
      default:
        final message = error.message ?? 'Unknown network error';
        CallLogger.logError('Unknown error: $message');
        return Failure.network(message: 'Network error: $message');
    }
  }
}
