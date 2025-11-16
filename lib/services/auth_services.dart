import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/api_response.dart';
import '../models/user_model.dart';
import 'api_service.dart';
class AuthService {
  final ApiService apiService;

  AuthService({required this.apiService});

  Future<UserModel> login(String email, String password) async {
    final res = await apiService.post(ApiRoutes.login, {
      'email': email,
      'password': password,
    });

    final apiRes = ApiResponse.fromMap(res, (data) => UserModel.fromJson(data['user'], data['accessToken']));

    if (apiRes.data == null) {
      throw Exception(apiRes.message ?? 'Login thất bại');
    }

    return apiRes.data!;
  }

  Future<String> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    final res = await apiService.post(ApiRoutes.register, {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    });

    final apiRes = ApiResponse.fromMap(res, (_) => null);

    return apiRes.message ?? 'Không rõ thông báo';
  }

  Future<String> forgotPassword(String email) async {
    final res = await apiService.post(ApiRoutes.forgotPassword, {
      'email': email,
    });

    final apiRes = ApiResponse.fromMap(res, (_) => null);

    return apiRes.message ?? 'Không rõ thông báo';
  }

  Future<String> verifyOtp(String email, String otp) async {
    final res = await apiService.post(ApiRoutes.verifyOtp, {
      'email': email,
      'otp': otp
    });

    final apiRes = ApiResponse.fromMap(res, (_) => null);

    return apiRes.message ?? 'Không rõ thông báo';
  }

  Future<String> resetPassword(
    String email,
    String newPassword,
  ) async {
    final res = await apiService.post(ApiRoutes.resetPassword, {
      'email': email,
      'newPassword': newPassword,
    });

    final apiRes = ApiResponse.fromMap(res, (_) => null);

    return apiRes.message ?? 'Không rõ thông báo';
  }
}
