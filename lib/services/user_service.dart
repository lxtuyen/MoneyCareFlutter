import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/dto/profile_update_dto.dart';
import 'package:money_care/models/user_model.dart';
import 'api_service.dart';

class UserService {
  final ApiService api;

  UserService({required this.api});

  Future<UserModel> updateMyProfile(ProfileUpdateDto dto) async {
    final res = await api.patch<UserModel>(
      ApiRoutes.userProfile,
      body: dto.toJson(),
      fromJsonT: (json) => UserModel.fromJsonUpdate(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<String> addMonthlyIncome(int monthlyIncome) async {
    final res = await api.patch<void>(
      ApiRoutes.userProfile,
      body: {'monthlyIncome': monthlyIncome},
    );

    return res.message;
  }
}
