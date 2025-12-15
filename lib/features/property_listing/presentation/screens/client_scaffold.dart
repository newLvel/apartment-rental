import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClientScaffold extends StatelessWidget {
  final Widget child;

  const ClientScaffold({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
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
    if (location.startsWith('/client_home')) {
      return 0;
    }
    if (location.startsWith('/client_bookings')) {
      return 1;
    }
    if (location.startsWith('/client_profile')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/client_home');
        break;
      case 1:
        GoRouter.of(context).go('/client_bookings');
        break;
      case 2:
        GoRouter.of(context).go('/client_profile');
        break;
    }
  }
}
