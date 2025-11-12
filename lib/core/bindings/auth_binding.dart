import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:money_care/controllers/auth_controller.dart';
import 'package:money_care/services/auth_services.dart';
import '../../services/api_service.dart';
import '../../data/storage_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    final storage = StorageService();
    storage.init();

    final apiService = ApiService(baseUrl: dotenv.env['API_BASE_URL'] ?? '');

    final authService = AuthService(apiService: apiService);

    Get.lazyPut(
      () => AuthController(authService: authService, storage: storage),
    );
  }
}
