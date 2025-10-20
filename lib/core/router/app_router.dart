import 'package:chattrix_ui/features/auth/presentation/pages/debug_token_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/login_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/otp_verification_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/register_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/chat_list_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/chat_view_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/new_chat_page.dart';
import 'package:chattrix_ui/features/contacts/presentation/pages/contacts_page.dart';
import 'package:chattrix_ui/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthNotifierWrapper extends ChangeNotifier {
  AuthNotifierWrapper(this._ref) {
    _ref.listen<AuthState>(authNotifierProvider, (_, __) => notifyListeners());
  }

  final Ref _ref;
}

final authNotifierWrapperProvider = Provider<AuthNotifierWrapper>((ref) {
  return AuthNotifierWrapper(ref);
});

class AppRouter {
  static const String loginPath = '/login';
  static const String registerPath = '/register';
  static const String forgotPasswordPath = '/forgot-password';
  static const String otpVerificationPath = '/otp';

  static GoRouter router(WidgetRef ref) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: ref.watch(authNotifierWrapperProvider),
      redirect: (context, state) async {
        // Check if user is logged in
        final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();
        final isGoingToAuth =
            state.matchedLocation == loginPath ||
            state.matchedLocation == registerPath ||
            state.matchedLocation == forgotPasswordPath ||
            state.matchedLocation == otpVerificationPath;

        // Nếu chưa login và không đang đi đến auth screen -> redirect đến login
        if (!isLoggedIn && !isGoingToAuth) {
          return loginPath;
        }

        // Nếu đã login và đang ở auth screen -> redirect về home
        if (isLoggedIn && isGoingToAuth) {
          return '/';
        }

        return null; // Không redirect
      },
      routes: <RouteBase>[
        // Shell with bottom navigation
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
          ],
        ),

        // Chat view route
        GoRoute(
          path: '/chat/:id',
          name: 'chat-view',
          builder: (context, state) {
            final id = state.pathParameters['id']!;

            // Lấy extra nếu có
            final extra = state.extra as Map<String, dynamic>?;

            final name = extra?['name'] as String?;
            final color = extra?['color'] as Color?;

            return ChatViewPage(
              chatId: id,
              name: name,
              color: color,
            );
          },
        ),

        // New chat route
        GoRoute(
          path: '/new-chat',
          name: 'new-chat',
          builder: (context, state) => const NewChatPage(),
        ),

        // Debug Token route
        GoRoute(
          path: '/debug-token',
          name: 'debug-token',
          builder: (context, state) => const DebugTokenScreen(),
        ),

        // Auth routes
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
      ],
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
    // default to Chats for any nested routes
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexOfLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
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
      ),
    );
  }
}
