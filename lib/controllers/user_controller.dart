import 'package:get/get.dart';
import 'package:money_care/models/dto/profile_update_dto.dart';
import 'package:money_care/models/user_profile.dart';
import 'package:money_care/services/user_service.dart';

class UserController extends GetxController {
  final UserService service;

  UserController({required this.service});

  var userProfile = Rxn<UserProfileModel>();
  var isLoading = false.obs;

  Future<void> updateProfile(ProfileUpdateDto dto) async {
    try {
      isLoading.value = true;

      final updated = await service.updateMyProfile(dto);
      userProfile.value = updated;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> currentProlife(UserProfileModel profile) async {
    userProfile.value = profile;
  }

  Future<String> addMonthlyIncome(int monthlyIncome) async {
    try {
      isLoading.value = true;

      final message = await service.addMonthlyIncome(monthlyIncome);

      if (userProfile.value != null) {
        userProfile.value = userProfile.value!.copyWith(
          monthlyIncome: monthlyIncome,
        );
        userProfile.refresh();
      }

      return message;
    } finally {
      isLoading.value = false;
    }
  }
}
