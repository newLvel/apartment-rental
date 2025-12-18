import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:apartment_rental/features/authentication/presentation/providers/auth_provider.dart';

class OwnerProfileScreen extends ConsumerStatefulWidget {
  const OwnerProfileScreen({super.key});

  @override
  ConsumerState<OwnerProfileScreen> createState() => _OwnerProfileScreenState();
}

class _OwnerProfileScreenState extends ConsumerState<OwnerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final currentUser = authState.value;

    return Scaffold(
      appBar: AppBar(title: const Text('Owner Profile')),
      body: currentUser == null
          ? const Center(child: Text('Not logged in.'))
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(radius: 50, child: Icon(Icons.business_center, size: 50)),
                    const SizedBox(height: 16),
                    Text(currentUser.name, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Text(currentUser.email, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
                    const SizedBox(height: 40),
                    ListTile(
                      leading: const Icon(Icons.edit_outlined),
                      title: const Text('Edit Profile'),
                      onTap: () {
                        context.push('/edit_profile', extra: currentUser);
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text('Logout', style: TextStyle(color: Colors.red)),
                      onTap: () async {
                        await ref.read(authNotifierProvider.notifier).logout();
                        if (mounted) {
                          context.go('/login');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
