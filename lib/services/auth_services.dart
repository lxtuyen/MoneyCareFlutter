import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService api;

  AuthService({required this.api});

  Future<UserModel> login(String email, String password) async {
    final res = await api.post<UserModel>(
      ApiRoutes.login,
      body: {
        'email': email,
        'password': password,
      },
      fromJsonT: (json) => UserModel.fromJson(
        json['user'],
        json['accessToken'],
      ),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<String> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    final res = await api.post<void>(
      ApiRoutes.register,
      body: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
    );

    return res.message;
  }

  Future<String> forgotPassword(String email) async {
    final res = await api.post<void>(
      ApiRoutes.forgotPassword,
      body: {'email': email},
    );

    return res.message;
  }

  Future<String> verifyOtp(String email, String otp) async {
    final res = await api.post<void>(
      ApiRoutes.verifyOtp,
      body: {
        'email': email,
        'otp': otp,
      },
    );

    return res.message;
  }

  Future<String> resetPassword(String email, String newPassword) async {
    final res = await api.post<void>(
      ApiRoutes.resetPassword,
      body: {
        'email': email,
        'newPassword': newPassword,
      },
    );

    return res.message;
  }
}
