import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money_care/controllers/auth_controller.dart';
import 'package:money_care/controllers/notification_controller.dart';
import 'package:money_care/controllers/saving_fund_controller.dart';
import 'package:money_care/controllers/transaction_controller.dart';
import 'package:money_care/controllers/user_controller.dart';
import 'package:money_care/services/api_service.dart';
import 'package:money_care/services/auth_services.dart';
import 'package:money_care/services/notification_service.dart';
import 'package:money_care/services/saving_fund_service.dart';
import 'package:money_care/data/storage_service.dart';
import 'package:money_care/services/transaction_service.dart';
import 'package:money_care/services/user_service.dart';

class AppBinding extends Bindings {
  final StorageService storage;

  AppBinding({required this.storage});

  @override
  void dependencies() {
    final apiService = ApiService(baseUrl: _resolveBaseUrl());

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
  }

  String _resolveBaseUrl() {
    final envUrl = dotenv.env['API_BASE_URL'] ?? '';
    if (envUrl.isEmpty) return '';

    if (kIsWeb) return envUrl; // web dùng localhost ok
    if (Platform.isAndroid && envUrl.contains('localhost')) {
      return envUrl.replaceFirst('localhost', '10.0.2.2');
    }
    return envUrl;
  }
}
