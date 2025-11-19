import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/user_profile.dart';
import 'api_service.dart';

class UserService {
  final ApiService api;

  UserService({required this.api});

  Future<UserProfileModel> getUser(int id) async {
    final res = await api.get<UserProfileModel>(
      ApiRoutes.userProfile,
      fromJsonT: (json) => UserProfileModel.fromJson(json),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<UserProfileModel> updateMyProfile(
    String? firstName,
    String? lastName,
    int? monthlyIncome,
  ) async {
    final res = await api.patch<UserProfileModel>(
      ApiRoutes.userProfile,
      body: {
        'firstName': firstName,
        'lastName': lastName,
        'monthlyIncome': monthlyIncome,
      },
      fromJsonT: (json) => UserProfileModel.fromJson(json),
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
