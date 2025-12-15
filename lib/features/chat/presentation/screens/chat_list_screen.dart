import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/chat_entities.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final conversations = [
      ChatConversation(
        id: '1',
        otherUserName: 'John Doe (Landlord)',
        otherUserImage: '',
        lastMessage: 'When can I move in?',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        unreadCount: 2,
      ),
      ChatConversation(
        id: '2',
        otherUserName: 'Maintenance Crew',
        otherUserImage: '',
        lastMessage: 'Ticket #MS0213 resolved.',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        unreadCount: 0,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final chat = conversations[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(chat.otherUserName[0]),
            ),
            title: Text(chat.otherUserName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              chat.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: chat.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                color: chat.unreadCount > 0 ? Colors.black : Colors.grey,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (chat.unreadCount > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE85D32),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${chat.unreadCount}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
              ],
            ),
            onTap: () {
              context.push('/chat/${chat.id}?name=${Uri.encodeComponent(chat.otherUserName)}');
            },
          );
        },
      ),
    );
  }
}
