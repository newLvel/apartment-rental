import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: '/filters',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FilterScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ClientScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/client_home',
            builder: (context, state) => const ClientHomeScreen(),
          ),
          GoRoute(
            path: '/client_bookings', 
            builder: (context, state) => const TenantDashboardScreen(),
          ),
          GoRoute(
            path: '/client_chats',
            builder: (context, state) => const ChatListScreen(),
          ),
          GoRoute(
            path: '/client_chat/:chatId',
            builder: (context, state) {
              final chatId = state.pathParameters['chatId']!;
              final name = state.uri.queryParameters['name'] ?? 'Chat';
              return ChatScreen(chatId: chatId, userName: name);
            },
          ),
          GoRoute(
            path: '/client_profile',
            builder: (context, state) => const ClientProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/tenant_property_management/:apartmentId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
           final apartmentId = state.pathParameters['apartmentId']!;
           return TenantPropertyManagementScreen(apartmentId: apartmentId);
        },
      ),
      GoRoute(
        path: '/owner_home',
        builder: (context, state) => const OwnerHomeScreen(),
      ),
      GoRoute(
        path: '/add_property',
        builder: (context, state) => const AddPropertyScreen(),
      ),
      GoRoute(
        path: '/details/:apartmentId',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final apartmentId = state.pathParameters['apartmentId']!;
          final isOwnerView = state.uri.queryParameters['fromOwner'] == 'true';
          return ApartmentDetailsScreen(apartmentId: apartmentId, isOwnerView: isOwnerView);
        },
      ),
    ],
  );
});
