import 'package:chattrix_ui/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/login_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/otp_verification_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/register_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/call/presentation/pages/call_page.dart';
import 'package:chattrix_ui/features/call/presentation/pages/incoming_call_page.dart';
import 'package:chattrix_ui/features/call/presentation/pages/outgoing_call_page.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/call/presentation/state/call_state.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/chat_info_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/chat_list_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/chat_view_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/new_chat_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/new_group_chat_page.dart';
import 'package:chattrix_ui/features/contacts/presentation/pages/contacts_page.dart';
import 'package:chattrix_ui/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthNotifierWrapper extends ChangeNotifier {
  AuthNotifierWrapper(this._ref) {
    _ref.listen<AuthState>(authNotifierProvider, (_, _) => notifyListeners());
  }

  final Ref _ref;
}

final authNotifierWrapperProvider = Provider<AuthNotifierWrapper>((ref) {
  return AuthNotifierWrapper(ref);
});

class CallNotifierWrapper extends ChangeNotifier {
  CallNotifierWrapper(this._ref) {
    _ref.listen(callProvider, (_, _) => notifyListeners());
  }

  final Ref _ref;
}

final callNotifierWrapperProvider = Provider<CallNotifierWrapper>((ref) {
  return CallNotifierWrapper(ref);
});

class AppRouter {
  static const String loginPath = '/login';
  static const String registerPath = '/register';
  static const String forgotPasswordPath = '/forgot-password';
  static const String otpVerificationPath = '/otp';
  static const String incomingCallPath = '/incoming-call';
  static const String outgoingCallPath = '/outgoing-call';
  static const String activeCallPath = '/call';

  static GoRouter router(WidgetRef ref) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: Listenable.merge([
        ref.watch(authNotifierWrapperProvider),
        ref.watch(callNotifierWrapperProvider),
      ]),
      redirect: (context, state) async {
        final currentLocation = state.matchedLocation;

        // Handle auth redirect first
        final authRedirect = await _handleAuthRedirect(ref, state);
        if (authRedirect != null) {
          return authRedirect;
        }

        // Handle call redirect
        final callRedirect = _handleCallRedirect(ref, currentLocation);
        if (callRedirect != null) {
          return callRedirect;
        }

        return null;
      },
      routes: <RouteBase>[
        // Call routes - MUST be outside ShellRoute to avoid showing bottom nav
        GoRoute(
          path: incomingCallPath,
          name: 'incoming-call',
          builder: (context, state) => const IncomingCallPage(),
        ),

        GoRoute(
          path: outgoingCallPath,
          name: 'outgoing-call',
          builder: (context, state) => const OutgoingCallPage(),
        ),

        GoRoute(
          path: activeCallPath,
          name: 'call',
          builder: (context, state) => const CallPage(),
        ),

        // Auth routes - outside ShellRoute
        GoRoute(
          path: loginPath,
          name: 'login',
          builder: (BuildContext context, GoRouterState state) =>
              const LoginScreen(),
        ),
        GoRoute(
          path: registerPath,
          name: 'register',
          builder: (BuildContext context, GoRouterState state) =>
              const RegisterScreen(),
        ),
        GoRoute(
          path: forgotPasswordPath,
          name: 'forgot-password',
          builder: (BuildContext context, GoRouterState state) =>
              const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: otpVerificationPath,
          name: 'otp',
          builder: (BuildContext context, GoRouterState state) {
            String? email;
            bool isPasswordReset = false;

            if (state.extra is Map) {
              final extraMap = state.extra as Map;
              email = extraMap['email'] as String?;
              isPasswordReset = extraMap['isPasswordReset'] as bool? ?? false;
            }

            return OtpVerificationScreen(
              email: email,
              isPasswordReset: isPasswordReset,
            );
          },
        ),

        // Main app routes with bottom navigation
        ShellRoute(
          builder: (context, state, child) => _NavShell(child: child),
          routes: [
            GoRoute(
              path: '/',
              name: 'chats',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ChatListPage()),
            ),
            GoRoute(
              path: '/contacts',
              name: 'contacts',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ContactsPage()),
            ),
            GoRoute(
              path: '/profile',
              name: 'profile',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfilePage()),
            ),
            GoRoute(
              path: '/chat/:id',
              name: 'chat-view',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                final extra = state.extra as Map<String, dynamic>?;
                final name = extra?['name'] as String?;
                final color = extra?['color'] as Color?;
                return ChatViewPage(chatId: id, name: name, color: color);
              },
            ),
            GoRoute(
              path: '/new-chat',
              name: 'new-chat',
              builder: (context, state) => const NewChatPage(),
            ),
            GoRoute(
              path: '/new-group',
              name: 'new-group',
              builder: (context, state) => const NewGroupChatPage(),
            ),
            GoRoute(
              path: '/chat-info',
              name: 'chat-info',
              builder: (context, state) {
                final conversation = state.extra as Conversation;
                return ChatInfoPage(conversation: conversation);
              },
            ),
          ],
        ),
      ],
    );
  }

  /// Handle authentication redirect logic
  static Future<String?> _handleAuthRedirect(
    WidgetRef ref,
    GoRouterState state,
  ) async {
    final currentLocation = state.matchedLocation;

    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();
    final isGoingToAuth = currentLocation == loginPath ||
        currentLocation == registerPath ||
        currentLocation == forgotPasswordPath ||
        currentLocation == otpVerificationPath;

    if (!isLoggedIn && !isGoingToAuth) {
      return loginPath;
    }

    if (isLoggedIn && isGoingToAuth) {
      return '/';
    }

    return null;
  }

  /// Handle call redirect logic - route to appropriate call page
  static String? _handleCallRedirect(
    WidgetRef ref,
    String currentLocation,
  ) {
    final callState = ref.read(callProvider);

    return callState.when(
      idle: () {
        // If on any call page but idle, go home
        if (currentLocation == incomingCallPath ||
            currentLocation == outgoingCallPath ||
            currentLocation == activeCallPath) {
          return '/';
        }
        return null;
      },
      initiating: (calleeId, callType) {
        if (currentLocation != outgoingCallPath) {
          return outgoingCallPath;
        }
        return null;
      },
      ringing: (invitation) {
        if (currentLocation != incomingCallPath) {
          return incomingCallPath;
        }
        return null;
      },
      connecting: (connection, callType, isOutgoing) {
        if (isOutgoing && currentLocation != outgoingCallPath) {
          return outgoingCallPath;
        } else if (!isOutgoing && currentLocation != activeCallPath) {
          return activeCallPath;
        }
        return null;
      },
      connected: (connection, callType, isOutgoing, isMuted, isVideoEnabled,
          isSpeakerEnabled, isFrontCamera, remoteUid, remoteIsMuted, remoteIsVideoEnabled) {
        if (currentLocation != activeCallPath) {
          return activeCallPath;
        }
        return null;
      },
      ended: (reason) {
        if (currentLocation == incomingCallPath ||
            currentLocation == outgoingCallPath ||
            currentLocation == activeCallPath) {
          return '/';
        }
        return null;
      },
      error: (message) {
        if (currentLocation == incomingCallPath ||
            currentLocation == outgoingCallPath ||
            currentLocation == activeCallPath) {
          return '/';
        }
        return null;
      },
    );
  }
}

class _NavShell extends StatelessWidget {
  const _NavShell({required this.child});

  final Widget child;

  static const _routes = ['/', '/contacts', '/profile'];

  int _indexOfLocation(String location) {
    for (int i = 0; i < _routes.length; i++) {
      if (location == _routes[i]) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexOfLocation(location);

    // Ẩn bottom navigation khi đang ở trong chat detail, new chat, hoặc chat info
    final shouldShowBottomNav = !location.startsWith('/chat/') &&
                                 location != '/new-chat' &&
                                 location != '/new-group' &&
                                 location != '/chat-info';

    return Scaffold(
      body: child,
      bottomNavigationBar: shouldShowBottomNav
          ? NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                context.go(_routes[index]);
              },
              destinations: const [
                NavigationDestination(
                  icon: FaIcon(FontAwesomeIcons.solidComments),
                  label: 'Chats',
                ),
                NavigationDestination(
                  icon: FaIcon(FontAwesomeIcons.addressBook),
                  label: 'Contacts',
                ),
                NavigationDestination(
                  icon: FaIcon(FontAwesomeIcons.user),
                  label: 'Profile',
                ),
              ],
            )
          : null,
    );
  }
}