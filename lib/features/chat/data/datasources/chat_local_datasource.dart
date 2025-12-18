import 'package:hive_flutter/hive_flutter.dart';
import '../models/chat_model.dart';

abstract class ChatLocalDataSource {
  Future<List<ChatConversationModel>> getConversations(String userId);
  Future<List<ChatMessageModel>> getMessages(String conversationId);
  Future<void> sendMessage(ChatMessageModel message);
  Future<ChatConversationModel> startConversation(ChatConversationModel conversation);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final Box<ChatConversationModel> conversationBox;
  final Box<ChatMessageModel> messageBox;

  ChatLocalDataSourceImpl(this.conversationBox, this.messageBox);

  @override
  Future<List<ChatConversationModel>> getConversations(String userId) async {
    return conversationBox.values.where((c) => c.participantIds.contains(userId)).toList();
  }

  @override
  Future<List<ChatMessageModel>> getMessages(String conversationId) async {
    return messageBox.values.where((m) => m.conversationId == conversationId).toList();
  }

  @override
  Future<void> sendMessage(ChatMessageModel message) async {
    await messageBox.put(message.id, message);
    // Update conversation's last message
    final conversation = conversationBox.get(message.conversationId);
    if (conversation != null) {
      final updatedConversation = ChatConversationModel(
        id: conversation.id,
        participantIds: conversation.participantIds,
        lastMessage: message.text,
        timestamp: message.timestamp,
      );
      await conversationBox.put(conversation.id, updatedConversation);
    }
  }

  @override
  Future<ChatConversationModel> startConversation(ChatConversationModel conversation) async {
    await conversationBox.put(conversation.id, conversation);
    return conversation;
  }
}
