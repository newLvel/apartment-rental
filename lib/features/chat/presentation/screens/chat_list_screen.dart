import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/chat_providers.dart';
import 'package:apartment_rental/features/authentication/presentation/providers/auth_provider.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: conversationsAsync.when(
        data: (conversations) {
          if (conversations.isEmpty) {
            return const Center(child: Text('No conversations yet.'));
          }
          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final chat = conversations[index];
              // In a real app, you would fetch the other user's details.
              // For this POC, we'll just display a placeholder name.
              final otherUserId = chat.participantIds.firstWhere((id) => id != ref.read(authNotifierProvider).value?.id);
              final userName = 'User $otherUserId'; 

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text(userName[0]),
                ),
                title: Text(userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  chat.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  '${chat.timestamp.hour}:${chat.timestamp.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  context.push('/chat/${chat.id}?name=${Uri.encodeComponent(userName)}');
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
