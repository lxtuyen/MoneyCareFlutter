import 'package:get/get.dart';
import 'package:money_care/services/auth_services.dart';
import '../data/storage_service.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final AuthService authService;
  final StorageService storage;

  AuthController({required this.authService, required this.storage});

  var user = Rxn<UserModel>();
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final u = await authService.login(email, password);

      user.value = u;

      await storage.saveUserInfo(u.toJson().toString());

      await storage.saveToken(u.accessToken);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      isLoading.value = true;
      final res = await authService.register(
        email,
        password,
        firstName,
        lastName,
      );
      return res;
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    user.value = null;
    await storage.logout();
  }
}
