import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/dto/user_update_dto.dart';
import 'package:money_care/models/response/admin_user_stats.dart';
import 'package:money_care/models/response/user_response.dart';
import 'api_service.dart';

class AdminService {
  final ApiService api;

  AdminService({required this.api});

    Future<UserResponse> updateUser(int userId,UserUpdateDto dto) async {
    final res = await api.patch<UserResponse>(
      '${ApiRoutes.users}/$userId',
      body: dto.toJson(),
      fromJsonT: (json) => UserResponse.fromJson(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<AdminUserStats> getAdminUserStats() async {
    final res = await api.get<AdminUserStats>(
      ApiRoutes.stats,
      fromJsonT: (json) => AdminUserStats.fromJson(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }
  Future<List<UserResponse>> getListUsers() async {
    final res = await api.get<List<UserResponse>>(
      ApiRoutes.users,
      fromJsonT: (json) {
        final list = json as List<dynamic>;
        return list.map((e) => UserResponse.fromJson(e)).toList();
      },
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }
}
