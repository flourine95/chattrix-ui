import 'package:chattrix_ui/core/router/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NavShell extends StatelessWidget {
  const NavShell({super.key, required this.child});

  final Widget child;

  static const _navRoutes = [
    RoutePaths.chats,
    RoutePaths.contacts,
    RoutePaths.profile,
  ];

  static const _navigationDestinations = [
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
  ];

  int _getCurrentIndex(String location) {
    for (int i = 0; i < _navRoutes.length; i++) {
      if (location == _navRoutes[i]) return i;
    }
    return 0;
  }

  bool _shouldShowBottomNav(String location) {
    return !location.startsWith('/chat/') &&
        location != RoutePaths.newChat &&
        location != RoutePaths.newGroup &&
        location != RoutePaths.chatInfo;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getCurrentIndex(location);
    final showBottomNav = _shouldShowBottomNav(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: showBottomNav
          ? NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                context.go(_navRoutes[index]);
              },
              destinations: _navigationDestinations,
            )
          : null,
    );
  }
}

