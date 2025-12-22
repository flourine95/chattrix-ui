class RoutePaths {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp';

  static const String incomingCall = '/incoming-call';
  static const String outgoingCall = '/outgoing-call';
  static const String activeCall = '/call';

  static const String chats = '/';
  static const String contacts = '/contacts';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String settings = '/settings';
  static const String chatView = '/chat/:id';
  static const String newChat = '/new-chat';
  static const String newGroup = '/new-group';
  static const String chatInfo = '/chat/:id/info';
  static const String searchConversations = '/search-conversations';
  static const String scheduledMessages = '/scheduled-messages';
  static const String scheduleMessage = '/schedule-message';
  // chatListDemo removed - production ChatListPage is now used at '/' route
  static const String contactsDemo = '/contacts-demo';
}
