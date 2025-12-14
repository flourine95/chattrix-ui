import 'package:chattrix_ui/core/router/route_paths.dart';
import 'package:chattrix_ui/core/router/widgets/nav_shell.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/login_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/otp_verification_screen.dart';
import 'package:chattrix_ui/features/auth/presentation/pages/register_screen.dart';
import 'package:chattrix_ui/features/call/presentation/pages/call_page.dart';
import 'package:chattrix_ui/features/call/presentation/pages/incoming_call_page.dart';
import 'package:chattrix_ui/features/call/presentation/pages/outgoing_call_page.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/chat_info_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/chat_list_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/chat_list_demo_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/chat_view_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/new_chat_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/new_group_chat_page.dart';
import 'package:chattrix_ui/features/contacts/presentation/pages/contacts_page.dart';
import 'package:chattrix_ui/features/contacts/presentation/pages/contacts_demo_page.dart';
import 'package:chattrix_ui/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:chattrix_ui/features/profile/presentation/pages/profile_page.dart';
import 'package:chattrix_ui/features/profile/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  static List<RouteBase> get callRoutes => [
        GoRoute(
          path: RoutePaths.incomingCall,
          name: 'incoming-call',
          builder: (context, state) => const IncomingCallPage(),
        ),
        GoRoute(
          path: RoutePaths.outgoingCall,
          name: 'outgoing-call',
          builder: (context, state) => const OutgoingCallPage(),
        ),
        GoRoute(
          path: RoutePaths.activeCall,
          name: 'call',
          builder: (context, state) => const CallPage(),
        ),
      ];

  static List<RouteBase> get authRoutes => [
        GoRoute(
          path: RoutePaths.login,
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: RoutePaths.register,
          name: 'register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: RoutePaths.forgotPassword,
          name: 'forgot-password',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: RoutePaths.otpVerification,
          name: 'otp',
          builder: (context, state) => _buildOtpScreen(state),
        ),
      ];

  static ShellRoute get mainRoutes => ShellRoute(
        builder: (context, state, child) => NavShell(child: child),
        routes: [
          GoRoute(
            path: RoutePaths.chats,
            name: 'chats',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ChatListPage()),
          ),
          GoRoute(
            path: RoutePaths.contacts,
            name: 'contacts',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ContactsPage()),
          ),
          GoRoute(
            path: RoutePaths.profile,
            name: 'profile',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfilePage()),
          ),
          GoRoute(
            path: RoutePaths.chatView,
            name: 'chat-view',
            builder: (context, state) => _buildChatViewPage(state),
          ),
          GoRoute(
            path: RoutePaths.newChat,
            name: 'new-chat',
            builder: (context, state) => const NewChatPage(),
          ),
          GoRoute(
            path: RoutePaths.newGroup,
            name: 'new-group',
            builder: (context, state) => const NewGroupChatPage(),
          ),
          GoRoute(
            path: RoutePaths.chatInfo,
            name: 'chat-info',
            builder: (context, state) => _buildChatInfoPage(state),
          ),
        ],
      );

  static List<RouteBase> get profileRoutes => [
        GoRoute(
          path: RoutePaths.editProfile,
          name: 'edit-profile',
          builder: (context, state) => const EditProfilePage(),
        ),
        GoRoute(
          path: RoutePaths.settings,
          name: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: RoutePaths.chatListDemo,
          name: 'chat-list-demo',
          builder: (context, state) => const ChatListPagePreview(),
        ),
        GoRoute(
          path: RoutePaths.contactsDemo,
          name: 'contacts-demo',
          builder: (context, state) => const ContactListDemoPage(),
        ),
      ];

  static List<RouteBase> get allRoutes => [
        ...callRoutes,
        ...authRoutes,
        ...profileRoutes,
        mainRoutes,
      ];

  static Widget _buildOtpScreen(GoRouterState state) {
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
  }

  static Widget _buildChatViewPage(GoRouterState state) {
    final id = state.pathParameters['id']!;
    final extra = state.extra as Map<String, dynamic>?;
    final name = extra?['name'] as String?;
    final color = extra?['color'] as Color?;
    return ChatViewPage(chatId: id, name: name, color: color);
  }

  static Widget _buildChatInfoPage(GoRouterState state) {
    final conversation = state.extra as Conversation;
    return ChatInfoPage(conversation: conversation);
  }
}

