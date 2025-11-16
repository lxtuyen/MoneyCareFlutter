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

      final apiRes = await authService.login(email, password);

      user.value = apiRes;

      await storage.saveUserInfo(apiRes.toJson());
      await storage.saveToken(apiRes.accessToken);
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
      final apiRes = await authService.register(email, password, firstName, lastName);
      return apiRes;
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      isLoading.value = true;
      final apiRes = await authService.forgotPassword(email);
      await storage.writeString('user_email', email);
      return apiRes;
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> verifyOtp(String otp) async {
    try {
      isLoading.value = true;
      final userEmail = await storage.readString('user_email');
      final apiRes = await authService.verifyOtp(userEmail!, otp);
      return apiRes;
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> resetPassword(String newPassword) async {
    try {
      isLoading.value = true;
      final userEmail = await storage.readString('user_email');
      final apiRes = await authService.resetPassword(userEmail!, newPassword);
      await storage.remove('user_email');
      return apiRes;
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    user.value = null;
    await storage.logout();
  }
}
