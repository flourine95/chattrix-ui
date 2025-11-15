import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:flutter/cupertino.dart';

void main() {
  final jsonResponse = {
    "success": false,
    "message": "Validation failed",
    "errors": [
      {"field": "email", "code": "INVALID_EMAIL", "message": "Email is invalid"},
      {"field": "password", "code": "TOO_SHORT", "message": "Password too short"},
    ],
  };

  final errors = (jsonResponse['errors'] as List).map((e) => ValidationError.fromJson(e)).toList();

  for (final err in errors) {
    debugPrint(err.errorCode);
  }
}
