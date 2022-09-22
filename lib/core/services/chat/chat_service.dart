import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import '../../services/chat/chat_firebase_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage?> save(String text, ChatUser user);

  factory ChatService() {
    return ChatFirebaseService();
  }
}
