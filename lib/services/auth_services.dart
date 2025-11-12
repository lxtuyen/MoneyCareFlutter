import 'package:money_care/core/constants/api_routes.dart';
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

    final token = res['accessToken'];
    final userJson = res['user'];

    if (token == null || userJson == null) {
      throw Exception(res['message'] ?? 'Login thất bại');
    }

    return UserModel.fromJson(userJson, token);
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

    return res['message'] ?? 'Không rõ thông báo';
  }
}
