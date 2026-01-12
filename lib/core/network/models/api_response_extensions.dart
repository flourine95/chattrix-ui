import 'package:chattrix_ui/core/errors/exceptions.dart';
import 'package:chattrix_ui/core/network/models/api_response.dart';

extension ApiResponseUtils<T> on ApiResponse<T> {
  T getDataOrThrow() {
    if (success) {
      if (data != null) {
        return data!;
      }

      return data as T;
    }

    throw ServerException(message: message ?? 'Unknown error occurred', errorCode: code);
  }
}
