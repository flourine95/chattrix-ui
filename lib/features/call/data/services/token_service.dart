import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:chattrix_ui/core/constants/api_constants.dart';
import 'package:chattrix_ui/core/errors/failures.dart';

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
  /// Parameters:
  /// - [channelId]: The Agora channel ID for which to generate the token
  /// - [uid]: The user ID (UID) for the Agora channel
  /// - [role]: The role of the user (optional, defaults to 'publisher')
  ///
  /// Returns:
  /// - Right(token) on success
  /// - Left(Failure) on error
  Future<Either<Failure, String>> fetchToken({
    required String channelId,
    required int uid,
    String role = 'publisher',
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.agoraToken,
        data: {'channelName': channelId, 'uid': uid, 'role': role},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data['token'] as String?;

        if (token == null || token.isEmpty) {
          return const Left(
            Failure.server(message: 'Invalid token response from server', errorCode: 'INVALID_TOKEN_RESPONSE'),
          );
        }

        return Right(token);
      } else {
        return Left(
          Failure.server(
            message: response.data['message'] ?? 'Failed to fetch token',
            errorCode: response.data['errorCode'] ?? 'TOKEN_FETCH_FAILED',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(Failure.unknown(message: 'Unexpected error while fetching token: ${e.toString()}'));
    }
  }

  /// Refreshes an existing Agora token
  ///
  /// This method is called when a token is about to expire or has expired.
  /// It fetches a new token from the backend server.
  ///
  /// Parameters:
  /// - [channelId]: The Agora channel ID
  /// - [uid]: The user ID (UID) for the Agora channel
  ///
  /// Returns:
  /// - Right(token) on success
  /// - Left(Failure) on error
  Future<Either<Failure, String>> refreshToken({required String channelId, required int uid}) async {
    // Token refresh uses the same endpoint as initial fetch
    // The backend generates a new token with a fresh expiration time
    return fetchToken(channelId: channelId, uid: uid);
  }

  /// Handles token expiration events
  ///
  /// This method should be called when the Agora SDK triggers a token
  /// expiration callback. It attempts to refresh the token.
  ///
  /// Parameters:
  /// - [channelId]: The Agora channel ID
  /// - [uid]: The user ID (UID) for the Agora channel
  ///
  /// Returns:
  /// - Right(token) on successful refresh
  /// - Left(TokenExpiredFailure) if refresh fails
  Future<Either<Failure, String>> handleTokenExpiration({required String channelId, required int uid}) async {
    final result = await refreshToken(channelId: channelId, uid: uid);

    return result.fold(
      (failure) => Left(Failure.tokenExpired(message: 'Failed to refresh expired token: ${failure.toString()}')),
      (token) => Right(token),
    );
  }

  /// Converts Dio errors to appropriate Failure types
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network(message: 'Connection timeout while fetching token');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data['message'] ?? 'Failed to fetch token';
        final errorCode = error.response?.data['errorCode'];

        if (statusCode == 401) {
          return Failure.unauthorized(message: message, errorCode: errorCode);
        } else if (statusCode == 403) {
          return Failure.forbidden(message: message, errorCode: errorCode);
        } else if (statusCode == 404) {
          return Failure.notFound(message: message, errorCode: errorCode);
        } else {
          return Failure.server(message: message, errorCode: errorCode);
        }

      case DioExceptionType.cancel:
        return const Failure.unknown(message: 'Token fetch request was cancelled');

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
      default:
        return Failure.network(message: 'Network error while fetching token: ${error.message}');
    }
  }
}
