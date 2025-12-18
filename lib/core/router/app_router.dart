import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:apartment_rental/features/authentication/presentation/providers/auth_provider.dart';
import 'package:apartment_rental/features/property_listing/presentation/screens/client_home_screen.dart';
import 'package:apartment_rental/features/property_listing/presentation/screens/client_scaffold.dart';
import 'package:apartment_rental/features/property_listing/presentation/screens/apartment_details_screen.dart';
import 'package:apartment_rental/features/splash/presentation/screens/splash_screen.dart';
import 'package:apartment_rental/features/authentication/presentation/screens/login_screen.dart';
import 'package:apartment_rental/features/property_listing/presentation/screens/owner_home_screen.dart';
import 'package:apartment_rental/features/profile/presentation/screens/client_profile_screen.dart';
import 'package:apartment_rental/features/property_listing/presentation/screens/add_property_screen.dart';
import 'package:apartment_rental/features/authentication/presentation/screens/registration_screen.dart';
import 'package:apartment_rental/features/property_listing/presentation/screens/filter_screen.dart';
import 'package:apartment_rental/features/tenant_dashboard/presentation/screens/tenant_dashboard_screen.dart';
import 'package:apartment_rental/features/tenant_dashboard/presentation/screens/tenant_property_management_screen.dart';
import 'package:apartment_rental/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:apartment_rental/features/chat/presentation/screens/chat_screen.dart';
import 'package:apartment_rental/features/property_management/presentation/screens/owner_property_management_screen.dart';
import 'package:apartment_rental/features/property_listing/presentation/screens/owner_scaffold.dart';
import 'package:apartment_rental/features/profile/presentation/screens/owner_profile_screen.dart';
import 'package:apartment_rental/features/property_listing/presentation/providers/property_providers.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _clientShellNavigatorKey = GlobalKey<NavigatorState>();
final _ownerShellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = authState.value != null;
      final isLoggingIn = state.uri.path == '/login' || state.uri.path == '/register';

      // If user is not logged in and not on an auth page, redirect to login
      if (!isLoggedIn && !isLoggingIn && state.uri.path != '/splash') {
        return '/login';
      }

      // If user is logged in and tries to access login/register, redirect to home
      if (isLoggedIn && isLoggingIn) {
        final userRole = authState.value!.role;
        return userRole == 'owner' ? '/owner_home' : '/client_home';
      }

      return null; // No redirect needed
    },
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/register', builder: (context, state) => const RegistrationScreen()),
      
      GoRoute(path: '/filters', parentNavigatorKey: _rootNavigatorKey, builder: (context, state) => const FilterScreen()),

      // Client Shell
      ShellRoute(
        navigatorKey: _clientShellNavigatorKey,
        builder: (context, state, child) => ClientScaffold(child: child),
        routes: [
          GoRoute(path: '/client_home', builder: (context, state) => const ClientHomeScreen()),
          GoRoute(path: '/client_bookings', builder: (context, state) => const TenantDashboardScreen()),
          GoRoute(path: '/client_profile', builder: (context, state) => const ClientProfileScreen()),
        ],
      ),

      // Owner Shell
      ShellRoute(
        navigatorKey: _ownerShellNavigatorKey,
        builder: (context, state, child) => OwnerScaffold(child: child),
        routes: [
          GoRoute(path: '/owner_home', builder: (context, state) => const OwnerHomeScreen()),
          GoRoute(path: '/owner_profile', builder: (context, state) => const OwnerProfileScreen()),
        ],
      ),

      // Top-level routes (no shell)
      GoRoute(
        path: '/tenant_property_management/:apartmentId', parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => TenantPropertyManagementScreen(apartmentId: state.pathParameters['apartmentId']!),
      ),
      GoRoute(
        path: '/add_property', parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => AddPropertyScreen(apartment: state.extra as dynamic),
      ),
      GoRoute(
        path: '/edit_property/:apartmentId', parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => AddPropertyScreen(key: ValueKey(state.pathParameters['apartmentId']!), apartment: state.extra as dynamic),
      ),
      GoRoute(
        path: '/owner_property_management/:apartmentId', parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => OwnerPropertyManagementScreen(apartmentId: state.pathParameters['apartmentId']!),
      ),
      GoRoute(
        path: '/chats', parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ChatListScreen(),
      ),
      GoRoute(
        path: '/chat/:chatId', parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ChatScreen(chatId: state.pathParameters['chatId']!, userName: state.uri.queryParameters['name'] ?? 'Chat'),
      ),
      GoRoute(
        path: '/details/:apartmentId', parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ApartmentDetailsScreen(apartmentId: state.pathParameters['apartmentId']!, isOwnerView: state.uri.queryParameters['fromOwner'] == 'true'),
      ),
    ],
  );
});
