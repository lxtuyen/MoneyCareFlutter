import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money_care/controllers/auth_controller.dart';
import 'package:money_care/controllers/notification_controller.dart';
import 'package:money_care/controllers/saving_fund_controller.dart';
import 'package:money_care/controllers/scan_receipt_controller.dart';
import 'package:money_care/controllers/transaction_controller.dart';
import 'package:money_care/controllers/user_controller.dart';
import 'package:money_care/services/api_service.dart';
import 'package:money_care/services/auth_services.dart';
import 'package:money_care/services/notification_service.dart';
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
    final apiService = ApiService(baseUrl: dotenv.env['API_BASE_URL'] ?? '');

    final authService = AuthService(api: apiService);

    Get.lazyPut(
      () => AuthController(authService: authService, storage: storage),
      fenix: true,
    );

    Get.lazyPut(
      () => SavingFundController(service: SavingFundService(api: apiService)),
      fenix: true,
    );
    Get.lazyPut(
      () => UserController(service: UserService(api: apiService)),
      fenix: true,
    );
    Get.lazyPut(
      () => TransactionController(service: TransactionService(api: apiService)),
      fenix: true,
    );
    Get.lazyPut(
      () =>
          NotificationController(service: NotificationService(api: apiService)),
      fenix: true,
    );
    Get.lazyPut(
      () =>
          ScanReceiptController(service: ScanReceiptService(api: apiService)),
      fenix: true,
    );
  }
}
