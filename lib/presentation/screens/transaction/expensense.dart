import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:money_care/core/constants/colors.dart';
 import 'package:money_care/presentation/screens/transaction/widgets/amount_input.dart';
import 'package:money_care/presentation/screens/transaction/widgets/editcategory.dart';
import 'package:money_care/presentation/screens/transaction/widgets/note_input.dart';

class ExpensenseHomescreen extends StatefulWidget {
  const ExpensenseHomescreen({super.key});

  @override
  State<ExpensenseHomescreen> createState() => _ExpensenseHomescreenState();
}

class _ExpensenseHomescreenState extends State<ExpensenseHomescreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedValue;
  File? _selectedImage;
  final TextEditingController _categoryController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();
  final List<Map<String, dynamic>> categories = [
    {'name': 'Cần thiết', 'percent': '55%', 'icon': Icons.shopping_bag},
    {'name': 'Đào tạo', 'percent': '10%', 'icon': Icons.school},
    {'name': 'Hưởng thụ', 'percent': '10%', 'icon': Icons.spa},
    {'name': 'Tiết kiệm', 'percent': '10%', 'icon': Icons.savings},
    {'name': 'Từ thiện', 'percent': '5%', 'icon': Icons.volunteer_activism},
  ];

  final List<String> phanLoaiList = ['Thu nhập', 'Chi tiêu', 'Tiết kiệm'];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('vi', null);
  }

  void _showCategorySheet(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.50,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Phân loại',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1, thickness: 1, color: Colors.grey),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.black87,
                        ),
                        label: const Text(
                          'Tạo phân loại mới',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerLeft,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(context: context,  
                            isScrollControlled: true,

                           builder: (context){
                            return CategoryEditSheet(
                              categories: categories, 
                     
                            );
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Chỉnh sửa',
                          style: TextStyle(
                            color: AppColors.buttonPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Text(
                    'Danh sách phân loại',
                    style: TextStyle(fontSize: 15.5),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        scrollbars: false, // 👈 Ẩn thanh cuộn
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children:
                              categories.map((item) {
                                return GestureDetector(
                                  onTap:
                                      () =>
                                          Navigator.pop(context, item['name']),
                                  child: _categoryItem(
                                    item['name'],
                                    item['percent'],
                                    item['icon'],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (selected != null) {
      setState(() {
        _categoryController.text = selected;
      });
    }
  }

  Widget _categoryItem(String title, String percent, IconData icon) {
    return Container(
      width: 145,
      height: 105,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.deepPurple, size: 28),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            percent,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 160),
              child: Column(
                children: [
                  // ===== HEADER =====
                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        Container(
                          height: 165,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => context.pop('/home'),
                                ),
                                const Text(
                                  'Tiền Thu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 48),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 110,
                          left: 16,
                          right: 16,
                          child: Container(
                            height: 65,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 13,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: _selectDate,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_outlined,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        DateFormat(
                                          'EEEE, dd/MM/yy',
                                          'vi',
                                        ).format(selectedDate),
                                        style: const TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ===== FORM =====
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Nhập số tiền ---
                        AmountInput(
                          controller: _amountController,
                          label: 'Nhập số tiền',
                          hintText: '0 đ',
                          onChanged: (value) {},
                        ),

                        const SizedBox(height: 20),

                        const Text('Phân Loại', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),

                        TextField(
                          controller: _categoryController,
                          readOnly: true,

                          decoration: const InputDecoration(
                            // Viền mặc định (khi chưa focus)
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xFFBDBDBD), // xám nhạt
                                width: 1,
                              ),
                            ),

                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 16,
                            ),
                            hintText: 'Phân loại',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),

                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 188, 186, 186),
                                width: 1,
                              ),
                            ),

                            suffixIcon: Icon(Icons.keyboard_arrow_down),
                          ),
                          onTap: () => _showCategorySheet(context),
                        ),

                        const SizedBox(height: 20),

                        NoteInput(
                          controller: TextEditingController(),
                          label: 'Ghi chú',
                          hintText: 'Nhập ghi chú...',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter, // 👈 luôn dính mép dưới
              child: Container(
                margin: const EdgeInsets.only(bottom: 10), // 👈 nhích lên 10px

                width: double.infinity, // 👈 kéo full chiều ngang
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- Gợi ý tiền ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (final amount in ['100,000', '200,000', '300,000'])
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: OutlinedButton(
                                onPressed: () {
                                  _amountController.text = amount;
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side: BorderSide(
                                    color: AppColors.borderPrimary,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  amount,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.image_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Cập nhật',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
