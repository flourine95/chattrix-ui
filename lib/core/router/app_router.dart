import 'package:chattrix_ui/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/login_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/otp_verification_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/register_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String loginPath = '/login';
  static const String registerPath = '/register';
  static const String forgotPasswordPath = '/forgot-password';
  static const String otpVerificationPath = '/otp';

  static final GoRouter router = GoRouter(
    initialLocation: loginPath,
    routes: <GoRoute>[
      GoRoute(
        path: loginPath,
        name: 'login',
        builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
      ),
      GoRoute(
        path: registerPath,
        name: 'register',
        builder: (BuildContext context, GoRouterState state) => const RegisterScreen(),
      ),
      GoRoute(
        path: forgotPasswordPath,
        name: 'forgot-password',
        builder: (BuildContext context, GoRouterState state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: otpVerificationPath,
        name: 'otp',
        builder: (BuildContext context, GoRouterState state) => const OtpVerificationScreen(),
      ),
    ],
  );
}
