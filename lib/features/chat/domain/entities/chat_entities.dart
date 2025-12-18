class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMe;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}

class ChatConversation {
  final String id;
  final List<String> participantIds; // Added
  final String otherUserName;
  final String otherUserImage;
  final String lastMessage;
  final DateTime timestamp; // Changed from lastMessageTime
  final int unreadCount;

  const ChatConversation({
    required this.id,
    required this.participantIds, // Added
    required this.otherUserName,
    required this.otherUserImage,
    required this.lastMessage,
    required this.timestamp, // Changed from lastMessageTime
    required this.unreadCount,
  });
}
