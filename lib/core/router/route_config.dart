import 'package:chattrix_ui/core/router/route_paths.dart';
import 'package:chattrix_ui/core/router/widgets/nav_shell.dart';
import 'package:chattrix_ui/core/router/widgets/router_setup.dart';
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
import 'package:chattrix_ui/features/chat/presentation/pages/chat_view_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/new_chat_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/new_group_chat_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/search_conversations_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/schedule_message_page.dart';
import 'package:chattrix_ui/features/chat/presentation/pages/scheduled_messages_page.dart';
import 'package:chattrix_ui/features/contacts/presentation/pages/contacts_page.dart';
import 'package:chattrix_ui/features/contacts/presentation/pages/contacts_demo_page.dart';
import 'package:chattrix_ui/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:chattrix_ui/features/profile/presentation/pages/profile_page.dart';
import 'package:chattrix_ui/features/profile/presentation/pages/settings_page.dart';
import 'package:chattrix_ui/features/poll/presentation/pages/create_poll_page.dart';
import 'package:chattrix_ui/features/poll/presentation/pages/poll_detail_page.dart';
import 'package:chattrix_ui/features/invite_links/presentation/pages/invite_links_page.dart';
import 'package:chattrix_ui/features/invite_links/presentation/pages/invite_link_info_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteConfig {
  static List<RouteBase> get callRoutes => [
    GoRoute(
      path: RoutePaths.incomingCall,
      name: 'incoming-call',
      builder: (context, state) => RouterSetup(child: const IncomingCallPage()),
    ),
    GoRoute(
      path: RoutePaths.outgoingCall,
      name: 'outgoing-call',
      builder: (context, state) => RouterSetup(child: const OutgoingCallPage()),
    ),
    GoRoute(
      path: RoutePaths.activeCall,
      name: 'call',
      builder: (context, state) => RouterSetup(child: const CallPage()),
    ),
  ];

  static List<RouteBase> get authRoutes => [
    GoRoute(path: RoutePaths.login, name: 'login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: RoutePaths.register, name: 'register', builder: (context, state) => const RegisterScreen()),
    GoRoute(
      path: RoutePaths.forgotPassword,
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(path: RoutePaths.otpVerification, name: 'otp', builder: (context, state) => _buildOtpScreen(state)),
  ];

  static ShellRoute get mainRoutes => ShellRoute(
    builder: (context, state, child) => RouterSetup(child: NavShell(child: child)),
    routes: [
      GoRoute(
        path: RoutePaths.chats,
        name: 'chats',
        pageBuilder: (context, state) => const NoTransitionPage(child: ChatListPage()),
      ),
      GoRoute(
        path: RoutePaths.contacts,
        name: 'contacts',
        pageBuilder: (context, state) => const NoTransitionPage(child: ContactsPage()),
      ),
      GoRoute(
        path: RoutePaths.profile,
        name: 'profile',
        pageBuilder: (context, state) => const NoTransitionPage(child: ProfilePage()),
      ),
      GoRoute(path: RoutePaths.chatView, name: 'chat-view', builder: (context, state) => _buildChatViewPage(state)),
      GoRoute(path: RoutePaths.newChat, name: 'new-chat', builder: (context, state) => const NewChatPage()),
      GoRoute(path: RoutePaths.newGroup, name: 'new-group', builder: (context, state) => const NewGroupChatPage()),
      GoRoute(path: RoutePaths.chatInfo, name: 'chat-info', builder: (context, state) => _buildChatInfoPage(state)),
      GoRoute(
        path: RoutePaths.searchConversations,
        name: 'search-conversations',
        builder: (context, state) => const SearchConversationsPage(),
      ),
    ],
  );

  static List<RouteBase> get scheduleRoutes => [
    GoRoute(
      path: RoutePaths.scheduledMessages,
      name: 'scheduled-messages',
      builder: (context, state) => RouterSetup(child: const ScheduledMessagesPage()),
    ),
    GoRoute(
      path: RoutePaths.scheduleMessage,
      name: 'schedule-message',
      builder: (context, state) => RouterSetup(child: _buildScheduleMessagePage(state)),
    ),
  ];

  static List<RouteBase> get profileRoutes => [
    GoRoute(path: RoutePaths.editProfile, name: 'edit-profile', builder: (context, state) => const EditProfilePage()),
    GoRoute(path: RoutePaths.settings, name: 'settings', builder: (context, state) => const SettingsPage()),
    // Demo routes removed - production pages are now used in mainRoutes
    GoRoute(
      path: RoutePaths.contactsDemo,
      name: 'contacts-demo',
      builder: (context, state) => const ContactListDemoPage(),
    ),
  ];

  static List<RouteBase> get pollRoutes => [
    GoRoute(
      path: RoutePaths.createPoll,
      name: 'create-poll',
      builder: (context, state) => RouterSetup(child: _buildCreatePollPage(state)),
    ),
    GoRoute(
      path: RoutePaths.pollDetail,
      name: 'poll-detail',
      builder: (context, state) => RouterSetup(child: _buildPollDetailPage(state)),
    ),
  ];

  static List<RouteBase> get inviteLinkRoutes => [
    GoRoute(
      path: RoutePaths.inviteLinks,
      name: 'invite-links',
      builder: (context, state) => RouterSetup(child: _buildInviteLinksPage(state)),
    ),
    GoRoute(
      path: RoutePaths.inviteLinkInfo,
      name: 'invite-link-info',
      builder: (context, state) => RouterSetup(child: _buildInviteLinkInfoPage(state)),
    ),
  ];

  static List<RouteBase> get allRoutes => [
    ...callRoutes,
    ...authRoutes,
    ...profileRoutes,
    ...scheduleRoutes,
    ...pollRoutes,
    ...inviteLinkRoutes,
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

    return OtpVerificationScreen(email: email, isPasswordReset: isPasswordReset);
  }

  static Widget _buildChatViewPage(GoRouterState state) {
    final id = state.pathParameters['id']!;
    int? highlightMessageId;

    if (state.extra is Map) {
      final extraMap = state.extra as Map;
      highlightMessageId = extraMap['highlightMessageId'] as int?;
    }

    return ChatViewPage(chatId: id, highlightMessageId: highlightMessageId);
  }

  static Widget _buildChatInfoPage(GoRouterState state) {
    final conversation = state.extra as Conversation;
    return ChatInfoPage(conversation: conversation);
  }

  static Widget _buildScheduleMessagePage(GoRouterState state) {
    if (state.extra is Map) {
      final extraMap = state.extra as Map;
      final conversationId = extraMap['conversationId'] as int?;
      final existingMessage = extraMap['existingMessage'];

      return ScheduleMessagePage(conversationId: conversationId ?? 0, existingMessage: existingMessage);
    }

    return const ScheduleMessagePage(conversationId: 0);
  }

  static Widget _buildCreatePollPage(GoRouterState state) {
    final id = state.pathParameters['id']!;
    final conversationId = int.parse(id);
    return CreatePollPage(conversationId: conversationId);
  }

  static Widget _buildPollDetailPage(GoRouterState state) {
    final pollId = int.parse(state.pathParameters['pollId']!);
    return PollDetailPage(pollId: pollId);
  }

  static Widget _buildInviteLinksPage(GoRouterState state) {
    if (state.extra is Map) {
      final extraMap = state.extra as Map;
      final conversationId = extraMap['conversationId'] as int;
      final conversationName = extraMap['conversationName'] as String;

      return InviteLinksPage(conversationId: conversationId, conversationName: conversationName);
    }

    throw Exception('Missing required parameters for invite links page');
  }

  static Widget _buildInviteLinkInfoPage(GoRouterState state) {
    final token = state.pathParameters['token']!;
    return InviteLinkInfoPage(token: token);
  }
}
