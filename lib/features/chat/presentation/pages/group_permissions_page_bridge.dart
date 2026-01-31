// Bridge file to avoid Dart compiler bug with GroupPermissionsPage
// This file can import GroupPermissionsPage and re-export it

import 'package:chattrix_ui/features/chat/presentation/pages/group_permissions_page.dart';
import 'package:flutter/material.dart';

/// Bridge widget to navigate to GroupPermissionsPage
/// This avoids the compiler bug when importing directly in other files
Widget buildGroupPermissionsPage(int conversationId) {
  return GroupPermissionsPage(conversationId: conversationId);
}
