import 'package:get/get.dart';
import 'package:money_care/models/dto/user_update_dto.dart';
import 'package:money_care/models/response/admin_user_stats.dart';
import 'package:money_care/models/response/user_response.dart';
import 'package:money_care/services/admin_service.dart';

class AdminController extends GetxController {
  final AdminService adminService;

  AdminController({required this.adminService});

  final isLoadingStats = false.obs;
  final isUpdatingUser = false.obs;
  final isLoadingUser = false.obs;

  final adminUserStats = Rxn<AdminUserStats>();
  final listUsers = RxList<UserResponse>();

  final errorMessage = RxnString();

  Future<void> fetchAdminUserStats() async {
    try {
      isLoadingStats.value = true;
      errorMessage.value = null;

      final stats = await adminService.getAdminUserStats();
      adminUserStats.value = stats;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingStats.value = false;
    }
  }

  Future<void> fetchListUsers() async {
    try {
      isLoadingUser.value = true;
      errorMessage.value = null;
      final users = await adminService.getListUsers();
      listUsers.value = users;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingUser.value = false;
    }
  }

  Future<void> updateUser(int userId, UserUpdateDto dto) async {
    try {
      isUpdatingUser.value = true;
      errorMessage.value = null;

      final updatedUser = await adminService.updateUser(userId, dto);

      final index = listUsers.indexWhere((u) => u.id == updatedUser.id);

      if (index != -1) {
        listUsers[index] = updatedUser;
        listUsers.refresh();
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isUpdatingUser.value = false;
    }
  }
}
