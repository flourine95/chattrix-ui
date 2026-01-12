import 'package:chattrix_ui/core/router/redirect_guards.dart';
import 'package:chattrix_ui/core/router/route_config.dart';
import 'package:chattrix_ui/core/router/route_paths.dart';
import 'package:chattrix_ui/core/router/router_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppRouter {
  static const String loginPath = RoutePaths.login;
  static const String registerPath = RoutePaths.register;
  static const String forgotPasswordPath = RoutePaths.forgotPassword;
  static const String otpVerificationPath = RoutePaths.otpVerification;
  static const String incomingCallPath = RoutePaths.incomingCall;
  static const String outgoingCallPath = RoutePaths.outgoingCall;
  static const String activeCallPath = RoutePaths.activeCall;

  static GoRouter router(WidgetRef ref) {
    return GoRouter(
      initialLocation: RoutePaths.chats, // Production chat list page
      refreshListenable: Listenable.merge([
        ref.watch(authNotifierWrapperProvider),
        ref.watch(callNotifierWrapperProvider),
      ]),
      redirect: (context, state) async {
        final authRedirect = await AuthRedirectGuard.redirect(ref, state);
        if (authRedirect != null) return authRedirect;

        final callRedirect = CallRedirectGuard.redirect(ref, state.matchedLocation);
        if (callRedirect != null) return callRedirect;

        return null;
      },
      routes: RouteConfig.allRoutes,
    );
  }
}
