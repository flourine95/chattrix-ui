import 'package:chattrix_ui/core/router/agora_call_router_notifier.dart';
import 'package:chattrix_ui/core/router/incoming_call_router_notifier.dart';
import 'package:chattrix_ui/features/agora_call/domain/entities/call_entity.dart' as agora_entity;
import 'package:chattrix_ui/features/agora_call/presentation/pages/active_call_screen.dart';
import 'package:chattrix_ui/features/agora_call/presentation/pages/incoming_call_screen.dart' as agora_incoming;
import 'package:chattrix_ui/features/agora_call/presentation/pages/outgoing_call_screen.dart';
import 'package:chattrix_ui/features/agora_call/presentation/providers/call_state_provider.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/login_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/otp_verification_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/register_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_entity.dart';
import 'package:chattrix_ui/features/call/presentation/pages/call_history_screen.dart';
import 'package:chattrix_ui/features/call/presentation/pages/call_screen.dart';
import 'package:chattrix_ui/features/call/presentation/pages/incoming_call_screen.dart';
import 'package:chattrix_ui/features/call/presentation/pages/waiting_call_screen.dart';
import 'package:chattrix_ui/features/call/presentation/providers/incoming_call_provider.dart';
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

class AppRouter {
  static const String loginPath = '/login';
  static const String registerPath = '/register';
  static const String forgotPasswordPath = '/forgot-password';
  static const String otpVerificationPath = '/otp';

  static GoRouter router(WidgetRef ref) {
    final incomingCallNotifier = ref.watch(incomingCallRouterNotifierProvider);
    final agoraCallNotifier = ref.watch(agoraCallRouterNotifierProvider);

    return GoRouter(
      initialLocation: '/',
      refreshListenable: Listenable.merge([
        ref.watch(authNotifierWrapperProvider),
        incomingCallNotifier,
        agoraCallNotifier,
      ]),
      redirect: (context, state) async {
        debugPrint('🧭 [ROUTER] Redirect check for: ${state.matchedLocation}');

        // Handle auth redirect first
        final authRedirect = await _handleAuthRedirect(ref, state);
        if (authRedirect != null) {
          debugPrint('🧭 [ROUTER] Auth redirect to: $authRedirect');
          return authRedirect;
        }

        // Handle Agora incoming call redirect (higher priority than old call system)
        final agoraCallRedirect = _handleAgoraIncomingCallRedirect(ref, state, agoraCallNotifier);
        if (agoraCallRedirect != null) {
          debugPrint('🧭 [ROUTER] Agora incoming call redirect to: $agoraCallRedirect');
          return agoraCallRedirect;
        }

        // Handle incoming call redirect (old call system)
        final incomingCallRedirect = _handleIncomingCallRedirect(ref, state, incomingCallNotifier);
        if (incomingCallRedirect != null) {
          debugPrint('🧭 [ROUTER] Incoming call redirect to: $incomingCallRedirect');
          return incomingCallRedirect;
        }

        debugPrint('🧭 [ROUTER] No redirect needed');
        return null;
      },
      routes: <RouteBase>[
        ShellRoute(
          builder: (context, state, child) => _NavShell(child: child),
          routes: [
            GoRoute(
              path: '/',
              name: 'chats',
              pageBuilder: (context, state) => const NoTransitionPage(child: ChatListPage()),
            ),
            GoRoute(
              path: '/contacts',
              name: 'contacts',
              pageBuilder: (context, state) => const NoTransitionPage(child: ContactsPage()),
            ),
            GoRoute(
              path: '/profile',
              name: 'profile',
              pageBuilder: (context, state) => const NoTransitionPage(child: ProfilePage()),
            ),
          ],
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

        GoRoute(path: '/new-chat', name: 'new-chat', builder: (context, state) => const NewChatPage()),

        GoRoute(path: '/new-group', name: 'new-group', builder: (context, state) => const NewGroupChatPage()),

        GoRoute(
          path: '/chat-info',
          name: 'chat-info',
          builder: (context, state) {
            final conversation = state.extra as Conversation;
            return ChatInfoPage(conversation: conversation);
          },
        ),

        GoRoute(
          path: '/call/:callId',
          name: 'call',
          builder: (context, state) {
            final callId = state.pathParameters['callId']!;
            final extra = state.extra as Map<String, dynamic>?;
            final remoteUserId = extra?['remoteUserId'] as String? ?? '';
            final callTypeStr = extra?['callType'] as String? ?? 'video';
            final callType = callTypeStr == 'audio' ? CallType.audio : CallType.video;

            return CallScreen(callId: callId, remoteUserId: remoteUserId, callType: callType);
          },
        ),

        GoRoute(
          path: '/incoming-call',
          name: 'incoming-call',
          builder: (context, state) {
            return const IncomingCallScreen();
          },
        ),

        GoRoute(
          path: '/waiting-call/:callId',
          name: 'waiting-call',
          builder: (context, state) {
            final callId = state.pathParameters['callId']!;
            final extra = state.extra as Map<String, dynamic>?;
            final calleeName = extra?['calleeName'] as String? ?? 'Unknown';
            final isVideoCall = extra?['isVideoCall'] as bool? ?? true;
            return WaitingCallScreen(callId: callId, calleeName: calleeName, isVideoCall: isVideoCall);
          },
        ),

        GoRoute(path: '/call-history', name: 'call-history', builder: (context, state) => const CallHistoryScreen()),

        // Agora call routes
        GoRoute(
          path: '/agora-call/outgoing',
          name: 'agora-outgoing-call',
          builder: (context, state) => const OutgoingCallScreen(),
        ),

        GoRoute(
          path: '/agora-call/incoming',
          name: 'agora-incoming-call',
          builder: (context, state) => const agora_incoming.IncomingCallScreen(),
        ),

        GoRoute(
          path: '/agora-call/active',
          name: 'agora-active-call',
          builder: (context, state) => const ActiveCallScreen(),
        ),

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
          builder: (BuildContext context, GoRouterState state) {
            String? email;
            bool isPasswordReset = false;

            if (state.extra is Map) {
              final extraMap = state.extra as Map;
              email = extraMap['email'] as String?;
              isPasswordReset = extraMap['isPasswordReset'] as bool? ?? false;
            }

            return OtpVerificationScreen(email: email, isPasswordReset: isPasswordReset);
          },
        ),
      ],
    );
  }

  /// Handle authentication redirect logic
  static Future<String?> _handleAuthRedirect(WidgetRef ref, GoRouterState state) async {
    final currentLocation = state.matchedLocation;

    // CRITICAL: Never redirect away from active call screens, even for auth
    // This prevents kicking user out of call
    final isOnCallScreen = currentLocation.startsWith('/call/');
    final isOnWaitingCallScreen = currentLocation.startsWith('/waiting-call/');
    final isOnIncomingCallScreen = currentLocation == '/incoming-call';
    final isOnAgoraCallScreen = currentLocation.startsWith('/agora-call/');

    if (isOnCallScreen || isOnWaitingCallScreen || isOnIncomingCallScreen || isOnAgoraCallScreen) {
      debugPrint('🔐 [AUTH REDIRECT] On call screen - BLOCKING auth redirect');
      return null; // Never redirect away from call screens
    }

    final isLoggedIn = await ref.read(isLoggedInUseCaseProvider)();
    final isGoingToAuth =
        currentLocation == loginPath ||
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

  /// Handle Agora incoming call redirect logic
  static String? _handleAgoraIncomingCallRedirect(
    WidgetRef ref,
    GoRouterState state,
    AgoraCallRouterNotifier notifier,
  ) {
    final callState = ref.read(callStateProvider);
    final currentLocation = state.matchedLocation;

    // Extract call entity from AsyncValue using switch expression
    final call = switch (callState) {
      AsyncData(:final value) => value,
      _ => null,
    };

    debugPrint('📞 [AGORA CALL REDIRECT] Current call: ${call?.id ?? 'NULL'}');
    debugPrint('📞 [AGORA CALL REDIRECT] Call status: ${call?.status.name ?? 'NULL'}');
    debugPrint('📞 [AGORA CALL REDIRECT] Current location: $currentLocation');
    debugPrint('📞 [AGORA CALL REDIRECT] Is app in foreground: ${notifier.isAppInForeground}');

    // IMPORTANT: If already on Agora call screens, NEVER redirect away
    final isOnAgoraOutgoingScreen = currentLocation == '/agora-call/outgoing';
    final isOnAgoraIncomingScreen = currentLocation == '/agora-call/incoming';
    final isOnAgoraActiveScreen = currentLocation == '/agora-call/active';

    if (isOnAgoraOutgoingScreen || isOnAgoraIncomingScreen || isOnAgoraActiveScreen) {
      debugPrint("📞 [AGORA CALL REDIRECT] On Agora call screen - BLOCKING all redirects");
      return null; // Block ANY redirect when on Agora call screens
    }

    // Only redirect TO agora-call/incoming if:
    // 1. There's an incoming call (status is RINGING)
    // 2. Not already on the incoming call screen
    // 3. App is in foreground
    if (call != null &&
        call.status == agora_entity.CallStatus.ringing &&
        !isOnAgoraIncomingScreen &&
        notifier.isAppInForeground) {
      debugPrint("📞 [AGORA CALL REDIRECT] Redirecting to /agora-call/incoming");
      return '/agora-call/incoming';
    }

    debugPrint("📞 [AGORA CALL REDIRECT] No redirect needed");
    return null;
  }

  /// Handle incoming call redirect logic
  static String? _handleIncomingCallRedirect(WidgetRef ref, GoRouterState state, IncomingCallRouterNotifier notifier) {
    final currentInvitation = ref.read(currentIncomingCallProvider);
    final currentLocation = state.matchedLocation;

    debugPrint('📞 [INCOMING CALL REDIRECT] Current invitation: ${currentInvitation?.callId ?? 'NULL'}');
    debugPrint('📞 [INCOMING CALL REDIRECT] Current location: $currentLocation');
    debugPrint('📞 [INCOMING CALL REDIRECT] Is app in foreground: ${notifier.isAppInForeground}');

    // IMPORTANT: If already on call screen or waiting call screen, NEVER redirect away
    // This prevents the bug where user gets kicked back to home after accepting call
    final isOnCallScreen = currentLocation.startsWith('/call/');
    final isOnWaitingCallScreen = currentLocation.startsWith('/waiting-call/');
    final isOnIncomingCallScreen = currentLocation == '/incoming-call';

    if (isOnCallScreen || isOnWaitingCallScreen) {
      debugPrint("📞 [INCOMING CALL REDIRECT] On call/waiting screen - BLOCKING all redirects");
      return null; // Block ANY redirect when on call screens
    }

    // Only redirect TO incoming-call if:
    // 1. There's an incoming call invitation
    // 2. Not already on the incoming call screen
    // 3. App is in foreground
    if (currentInvitation != null && !isOnIncomingCallScreen && notifier.isAppInForeground) {
      debugPrint("📞 [INCOMING CALL REDIRECT] Redirecting to /incoming-call");
      return '/incoming-call';
    }

    debugPrint("📞 [INCOMING CALL REDIRECT] No redirect needed");
    return null;
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

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          context.go(_routes[index]);
        },
        destinations: const [
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.solidComments), label: 'Chats'),
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.addressBook), label: 'Contacts'),
          NavigationDestination(icon: FaIcon(FontAwesomeIcons.user), label: 'Profile'),
        ],
      ),
    );
  }
}
