import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money_care/controllers/admin_controller.dart';
import 'package:money_care/controllers/auth_controller.dart';
import 'package:money_care/controllers/chat_controller.dart';
import 'package:money_care/controllers/filter_controller.dart';
import 'package:money_care/controllers/payment_controller.dart';
import 'package:money_care/controllers/pending_transaction_controller.dart';
import 'package:money_care/controllers/saving_fund_controller.dart';
import 'package:money_care/controllers/scan_receipt_controller.dart';
import 'package:money_care/controllers/transaction_controller.dart';
import 'package:money_care/controllers/user_controller.dart';
import 'package:money_care/services/admin_service.dart';
import 'package:money_care/services/api_service.dart';
import 'package:money_care/services/auth_services.dart';
import 'package:money_care/services/chat_service.dart';
import 'package:money_care/services/payment_service.dart';
import 'package:money_care/services/pending_transaction_service.dart';
import 'package:money_care/services/saving_fund_service.dart';
import 'package:money_care/data/storage_service.dart';
import 'package:money_care/services/scan_receipt_service.dart';
import 'package:money_care/services/transaction_service.dart';
import 'package:money_care/services/user_service.dart';

class AppBinding extends Bindings {
  final StorageService storage;

  AppBinding({required this.storage});

  @override
  void dependencies() {
    final apiService = ApiService(
      baseUrl: dotenv.env[kIsWeb ? 'API_LOCALHOST_URL' : 'API_BASE_URL'] ?? '',
    );

    Get.lazyPut(
      () => AuthController(
        authService: AuthService(api: apiService),
        storage: storage,
      ),
      fenix: true,
    );

    Get.lazyPut(
      () => SavingFundController(service: SavingFundService(api: apiService)),
      fenix: true,
    );
    Get.lazyPut(
      () => UserController(
        service: UserService(api: apiService),
        storage: storage,
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => TransactionController(service: TransactionService(api: apiService)),
      fenix: true,
    );
    Get.lazyPut(
      () => ScanReceiptController(service: ScanReceiptService(api: apiService)),
      fenix: true,
    );
    Get.lazyPut(
      () => PendingTransactionController(
        service: PendingTransactionService(api: apiService),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => AdminController(adminService: AdminService(api: apiService)),
      fenix: true,
    );
    Get.lazyPut(
      () => ChatController(chatService: ChatService(api: apiService)),
      fenix: true,
    );
    Get.lazyPut(
      () => PaymentController(service: PayMentService(api: apiService)),
      fenix: true,
    );
    Get.lazyPut(() => FilterController(), fenix: true);
  }
}
