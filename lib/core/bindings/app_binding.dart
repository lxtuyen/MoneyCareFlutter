import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:money_care/controllers/auth_controller.dart';
import 'package:money_care/controllers/saving_fund_controller.dart';
import 'package:money_care/services/api_service.dart';
import 'package:money_care/services/auth_services.dart';
import 'package:money_care/services/saving_fund_service.dart';
import 'package:money_care/data/storage_service.dart';

class AppBinding extends Bindings {
  final StorageService storage;

  AppBinding({required this.storage});

  @override
  void dependencies() {
    final apiService = ApiService(
      baseUrl: dotenv.env['API_BASE_URL'] ?? '',
    );

    final authService = AuthService(apiService: apiService);

    Get.lazyPut(
      () => AuthController(authService: authService, storage: storage),
      fenix: true,
    );

    Get.lazyPut(
      () => SavingFundController(
        service: SavingFundService(apiService: apiService),
        //storage: storage,
      ),
      fenix: true,
    );
  }
}
