import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/presentation/screens/admin/widgets/widges_users/account_type_switch.dart';
import 'package:money_care/presentation/screens/admin/widgets/widges_users/header_menu_button.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> users = [
    {
      'name': 'Nguyễn Văn A',
      'date': '01/10/2024',
      'status': 'Yes',
      'accountType': 'VIP',
    },
    {
      'name': 'Trần Thị B',
      'date': '05/10/2024',
      'status': 'No',
      'accountType': 'Free',
    },
    {
      'name': 'Lê Văn C',
      'date': '20/10/2024',
      'status': 'No',
      'accountType': 'Free',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ===== HEADER =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // --- MENU BUTTONS: Dashboard / Người dùng ---
                  Row(
                    children: [
                      HeaderMenuButton(
                        label: 'Dashboard',
                        isActive: false,
                        onTap: () {
                          context.go('/dashboard');
                        },
                      ),
                      const SizedBox(width: 8),
                      HeaderMenuButton(
                        label: 'Người dùng',
                        isActive: true, // đang ở Users
                        onTap: () {},
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Admin',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ===== NỀN XANH + CONTENT =====
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFFE4F3F9),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ô search
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Title
                      const Text(
                        'Danh sách người dùng',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text1,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // ===== BẢNG NGƯỜI DÙNG (4 CỘT CHIA ĐỀU) =====
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // trừ nhẹ margin 32 cho đẹp
                            final double colWidth =
                                (constraints.maxWidth - 32) / 4;

                            return DataTable(
                              headingRowHeight: 40,
                              dataRowMinHeight: 38,
                              dataRowMaxHeight: 44,
                              columnSpacing: 0,
                              horizontalMargin: 16,
                              headingRowColor: MaterialStateProperty.all(
                                Colors.grey[300],
                              ),
                              columns: [
                                DataColumn(
                                  label: SizedBox(
                                    width: colWidth,
                                    child: const Text(
                                      'Họ và tên',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: colWidth,
                                    child: const Text(
                                      'Ngày đăng ký',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: colWidth,
                                    child: const Text(
                                      'Trạng thái',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: colWidth,
                                    child: const Text(
                                      'Loại tài khoản',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows:
                                  users
                                      .map(
                                        (u) => DataRow(
                                          cells: [
                                            DataCell(
                                              SizedBox(
                                                width: colWidth,
                                                child: Text(u['name']!),
                                              ),
                                            ),
                                            DataCell(
                                              SizedBox(
                                                width: colWidth,
                                                child: Text(u['date']!),
                                              ),
                                            ),
                                            DataCell(
                                              SizedBox(
                                                width: colWidth,
                                                child: Text(u['status']!),
                                              ),
                                            ),
                                            DataCell(
                                              SizedBox(
                                                width: colWidth,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: AccountTypeSwitch(
                                                    isVip:
                                                        (u['accountType'] ?? '')
                                                            .toLowerCase() ==
                                                        'vip',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
