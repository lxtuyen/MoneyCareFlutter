// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:money_care/core/constants/colors.dart';
// import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/bottom_circle.dart';
// import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/overview_card.dart';
// import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/top_category_card.dart';
// import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/top_revenue_card.dart';
// import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/user_stats_grid.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   bool _isWeekSelected = true; // <-- state phải nằm ở đây

//   @override
//   Widget build(BuildContext context) {
//     final sectionTitleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
//       fontWeight: FontWeight.w600,
//       color: AppColors.text1,
//     );

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // ===== NỘI DUNG CHÍNH: HEADER + SCROLL =====
//             Column(
//               children: [
//                 // ===== HEADER =====
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'PERSONAL FINANCE ADMIN',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 0.5,
//                         ),
//                       ),

//                       Row(
//                         children: [
//                           const CircleAvatar(
//                             radius: 18,
//                             backgroundColor: Colors.grey,
//                             child: Icon(Icons.person, color: Colors.white),
//                           ),
//                           const SizedBox(width: 8),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: const [
//                               Text(
//                                 'Admin',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // ===== NỀN MÀU XANH NHẸ + NỘI DUNG CUỘN =====
//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     color: const Color(0xFFE4F3F9),
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ).copyWith(
//                         bottom:
//                             120, // chừa chỗ để không bị 2 nút tròn che mất nội dung
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // ===== TỔNG KẾT + CHART =====
//                           Text('Tổng kết', style: sectionTitleStyle),
//                           const SizedBox(height: 8),
//                           BuildOverviewCard(
//                             isWeekSelected: _isWeekSelected,
//                             onWeekTap: () {
//                               setState(() {
//                                 _isWeekSelected = true;
//                               });
//                             },
//                             onMonthTap: () {
//                               setState(() {
//                                 _isWeekSelected = false;
//                               });
//                             },
//                           ),

//                           const SizedBox(height: 16),

//                           // ===== THỐNG KÊ NGƯỜI DÙNG =====
//                           Text('Thống kê người dùng', style: sectionTitleStyle),
//                           const SizedBox(height: 8),
//                           BuildUserStatsGrid(),

//                           const SizedBox(height: 16),

//                           // ===== TOP HẠNG MỤC CHI =====
//                           Text(
//                             'Top hạng mục chi từ tất cả các người dùng',
//                             style: sectionTitleStyle,
//                           ),
//                           const SizedBox(height: 8),
//                           TopCategoryCard(),

//                           const SizedBox(height: 16),

//                           // ===== TOP HẠNG MỤC THU =====
//                           Text(
//                             'Top hạng mục thu từ tất cả các người dùng',
//                             style: sectionTitleStyle,
//                           ),
//                           const SizedBox(height: 8),
//                           TopRevenueCard(),

//                           const SizedBox(height: 32),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // ===== BOTTOM NAV 2 NÚT TRÒN CỐ ĐỊNH =====
//             Positioned(
//               left: 0,
//               right: 0,
//               bottom: 24,
//               child: Center(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 32,
//                     vertical: 12,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(
//                       32,
//                     ), // bo tròn hình “viên thuốc”
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.08),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         children: [
//                           BuildBottomCircle(
//                             icon: Icons.dashboard_rounded,
//                             isActive: true,
//                             onTap: () {},
//                           ),
//                           const SizedBox(height: 6),
//                           const Text(
//                             'Dashboard',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: 40),
//                       Column(
//                         children: [
//                           BuildBottomCircle(
//                             icon: Icons.people_alt_outlined,
//                             isActive: false,
//                             onTap: () {
//                               context.go('/users');
//                             },
//                           ),
//                           const SizedBox(height: 6),
//                           const Text(
//                             'Người dùng',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/overview_card.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/top_category_card.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/top_revenue_card.dart';
import 'package:money_care/presentation/screens/admin/widgets/widgets_dashboard/user_stats_grid.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isWeekSelected = true; // <-- state phải nằm ở đây

  @override
  Widget build(BuildContext context) {
    final sectionTitleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.text1,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // ===== NỘI DUNG CHÍNH: HEADER + SCROLL =====
            Column(
              children: [
                // ===== HEADER =====
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ---- MENU BUTTONS (Dashboard / Người dùng) ----
                      Row(
                        children: [
                          _HeaderMenuButton(
                            label: 'Dashboard',
                            isActive: true,
                            onTap: () {
                              // đang ở dashboard, không làm gì
                            },
                          ),
                          const SizedBox(width: 8),
                          _HeaderMenuButton(
                            label: 'Người dùng',
                            isActive: false,
                            onTap: () {
                              context.go('/users');
                            },
                          ),
                        ],
                      ),

                      // ---- AVATAR ADMIN ----
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
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
                    ],
                  ),
                ),

                // ===== NỀN MÀU XANH NHẸ + NỘI DUNG CUỘN =====
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFFE4F3F9),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ).copyWith(
                        bottom:
                            120, // chừa chỗ để không bị 2 nút tròn che mất nội dung
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ===== TỔNG KẾT + CHART =====
                          Text('Tổng kết', style: sectionTitleStyle),
                          const SizedBox(height: 8),
                          BuildOverviewCard(
                            isWeekSelected: _isWeekSelected,
                            onWeekTap: () {
                              setState(() {
                                _isWeekSelected = true;
                              });
                            },
                            onMonthTap: () {
                              setState(() {
                                _isWeekSelected = false;
                              });
                            },
                          ),

                          const SizedBox(height: 16),

                          // ===== THỐNG KÊ NGƯỜI DÙNG =====
                          Text('Thống kê người dùng', style: sectionTitleStyle),
                          const SizedBox(height: 8),
                          BuildUserStatsGrid(),

                          const SizedBox(height: 16),

                          // ===== TOP HẠNG MỤC CHI =====
                          Text(
                            'Top hạng mục chi từ tất cả các người dùng',
                            style: sectionTitleStyle,
                          ),
                          const SizedBox(height: 8),
                          TopCategoryCard(),

                          const SizedBox(height: 16),

                          // ===== TOP HẠNG MỤC THU =====
                          Text(
                            'Top hạng mục thu từ tất cả các người dùng',
                            style: sectionTitleStyle,
                          ),
                          const SizedBox(height: 8),
                          TopRevenueCard(),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ====== NÚT MENU HEADER (Dashboard / Người dùng) ======
class _HeaderMenuButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _HeaderMenuButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
