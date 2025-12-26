import 'package:get/get.dart';
import 'package:money_care/controllers/transaction_controller.dart';
import 'package:money_care/models/chat_msg.dart';
import 'package:money_care/models/dto/chat_dto.dart';
import 'package:money_care/services/chat_service.dart';

class ChatController extends GetxController {
  final ChatService chatService;

  ChatController({required this.chatService});

  final isLoading = false.obs;
  final errorMessage = RxnString();

  final RxList<ChatMsg> messages = <ChatMsg>[].obs;
  final TransactionController transactionController =
      Get.find<TransactionController>();

  Future<String> send(String text, int userId) async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final dto = ChatDto(message: text, userId: userId);
      final reply = await chatService.sendToChatbot(dto);
      await transactionController.refreshAllData(userId);
      messages.add(ChatMsg(isUser: false, text: reply));
      return reply;
    } catch (e) {
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void addUserMessage(String text) {
    messages.add(ChatMsg(isUser: true, text: text));
  }

  void replaceLastBotMessage(String text) {
    if (messages.isNotEmpty) {
      messages[messages.length - 1] =
          ChatMsg(isUser: false, text: text);
    }
  }

  void clear() => messages.clear();
}
