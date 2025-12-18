import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants.dart';
import '../../data/datasources/chat_local_datasource.dart';
import '../../data/models/chat_model.dart';
import '../../domain/entities/chat_entities.dart';
import 'package:apartment_rental/features/authentication/presentation/providers/auth_provider.dart';

part 'chat_providers.g.dart';

@riverpod
ChatLocalDataSource chatLocalDataSource(ChatLocalDataSourceRef ref) {
  return ChatLocalDataSourceImpl(
    Hive.box<ChatConversationModel>(AppConstants.conversationBox),
    Hive.box<ChatMessageModel>(AppConstants.messageBox),
  );
}

@riverpod
Stream<List<ChatConversation>> conversations(ConversationsRef ref) {
  final authUser = ref.watch(authNotifierProvider).value;
  if (authUser == null) return Stream.value([]);
  
  final dataSource = ref.watch(chatLocalDataSourceProvider);
  final conversationBox = Hive.box<ChatConversationModel>(AppConstants.conversationBox);

  // Create a stream that emits immediately and then on any change.
  return conversationBox.watch().map((event) {
    return dataSource.getConversations(authUser.id);
  }).asyncMap((future) async {
    final models = await future;
    return models.map((m) {
      final otherId = m.participantIds.firstWhere((id) => id != authUser.id, orElse: () => '');
      return ChatConversation(
        id: m.id,
        participantIds: m.participantIds,
        otherUserName: 'User $otherId',
        otherUserImage: '',
        lastMessage: m.lastMessage,
        timestamp: m.timestamp,
        unreadCount: 0,
      );
    }).toList();
  });
}

@riverpod
Stream<List<ChatMessage>> messages(MessagesRef ref, String conversationId) {
  final dataSource = ref.watch(chatLocalDataSourceProvider);
  return Stream.fromFuture(dataSource.getMessages(conversationId))
      .map((models) => models.map((m) => ChatMessage(
        id: m.id,
        senderId: m.senderId,
        text: m.text,
        timestamp: m.timestamp,
        isMe: m.senderId == ref.watch(authNotifierProvider).value?.id
      )).toList()..sort((a, b) => a.timestamp.compareTo(b.timestamp)))
      .asBroadcastStream();
}

@riverpod
class ChatController extends _$ChatController {
  @override
  FutureOr<void> build() {}

  Future<void> sendMessage(String text, String conversationId) async {
    final senderId = ref.read(authNotifierProvider).value?.id;
    if (senderId == null) return;
    
    final message = ChatMessageModel(
      id: const Uuid().v4(),
      conversationId: conversationId,
      senderId: senderId,
      text: text,
      timestamp: DateTime.now(),
    );
    await ref.read(chatLocalDataSourceProvider).sendMessage(message);
    ref.invalidate(messagesProvider(conversationId));
    ref.invalidate(conversationsProvider);
  }

  Future<String> getOrCreateConversation(String otherUserId) async {
    final myId = ref.read(authNotifierProvider).value?.id;
    if (myId == null) throw Exception('Not logged in');
    
    final dataSource = ref.read(chatLocalDataSourceProvider);
    final conversations = await dataSource.getConversations(myId);
    
    final existing = conversations.where((c) => c.participantIds.contains(otherUserId));
    if (existing.isNotEmpty) {
      return existing.first.id;
    }
    
    final newConversation = ChatConversationModel(
      id: const Uuid().v4(),
      participantIds: [myId, otherUserId],
      lastMessage: 'Conversation started',
      timestamp: DateTime.now(),
    );
    await dataSource.startConversation(newConversation);
    ref.invalidate(conversationsProvider);
    return newConversation.id;
  }
}
