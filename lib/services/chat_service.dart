import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/dto/chat_dto.dart';
import 'api_service.dart';

class ChatService {
  final ApiService api;

  ChatService({required this.api});

    Future<String> sendToChatbot(ChatDto dto) async {
    final res = await api.post<String>(
      ApiRoutes.chatbot,
      body: dto.toJson(),
    );

    if (!res.success) {
      throw Exception(res.message);
    }

    return res.message;
  }
}
