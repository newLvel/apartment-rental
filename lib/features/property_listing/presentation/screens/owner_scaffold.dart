import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OwnerScaffold extends StatelessWidget {
  final Widget child;

  const OwnerScaffold({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Messages',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/owner_home')) {
      return 0;
    }
    if (location.startsWith('/chats')) {
      return 1;
    }
    if (location.startsWith('/owner_profile')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/owner_home');
        break;
      case 1:
        // Assuming /chats is the unified chat screen
        GoRouter.of(context).go('/chats'); 
        break;
      case 2:
        GoRouter.of(context).go('/owner_profile');
        break;
    }
  }
}
