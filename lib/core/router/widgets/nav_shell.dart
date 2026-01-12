import 'package:chattrix_ui/core/router/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NavShell extends StatefulWidget {
  const NavShell({super.key, required this.child});

  final Widget child;

  @override
  State<NavShell> createState() => _NavShellState();
}

class _NavShellState extends State<NavShell> {
  bool _isScrolled = false;

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
        location != RoutePaths.chatInfo &&
        location != RoutePaths.editProfile &&
        location != RoutePaths.settings;
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      // Show shadow when scrolled down
      final shouldShowShadow = notification.metrics.pixels > 0;
      if (shouldShowShadow != _isScrolled) {
        setState(() {
          _isScrolled = shouldShowShadow;
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getCurrentIndex(location);
    final showBottomNav = _shouldShowBottomNav(location);

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: widget.child,
      ),
      bottomNavigationBar: showBottomNav
          ? Container(
              decoration: BoxDecoration(
                boxShadow: _isScrolled
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ]
                    : null,
              ),
              child: NavigationBar(
                selectedIndex: currentIndex,
                onDestinationSelected: (index) {
                  context.go(_navRoutes[index]);
                },
                destinations: _navigationDestinations,
              ),
            )
          : null,
    );
  }
}

