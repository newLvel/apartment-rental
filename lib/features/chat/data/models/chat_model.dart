import 'package:hive/hive.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 4)
class ChatConversationModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List<String> participantIds;
  @HiveField(2)
  final String lastMessage;
  @HiveField(3)
  final DateTime timestamp;

  ChatConversationModel({
    required this.id,
    required this.participantIds,
    required this.lastMessage,
    required this.timestamp,
  });
}

@HiveType(typeId: 5)
class ChatMessageModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String conversationId;
  @HiveField(2)
  final String senderId;
  @HiveField(3)
  final String text;
  @HiveField(4)
  final DateTime timestamp;

  ChatMessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.text,
    required this.timestamp,
  });
}
