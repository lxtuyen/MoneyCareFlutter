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

  Future<String?> login(String email, String password) async {
    try {
      isLoading.value = true;

      final res = await authService.login(email, password);

      user.value = res;
      await storage.saveUserInfo(res.toJson());
      await storage.saveToken(res.accessToken!);

      return null;
    } catch (e) {
      return e.toString();
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
      return await authService.register(email, password, firstName, lastName);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      isLoading.value = true;

      final res = await authService.forgotPassword(email);

      await storage.writeString('user_email', email);

      return res;
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> verifyOtp(String otp) async {
    try {
      isLoading.value = true;

      final email = storage.readString('user_email');
      final res = await authService.verifyOtp(email!, otp);

      return res;
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> resetPassword(String newPassword) async {
    try {
      isLoading.value = true;

      final email = storage.readString('user_email');
      final res = await authService.resetPassword(email!, newPassword);

      await storage.remove('user_email');

      return res;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    user.value = null;
    await storage.logout();
  }
}
