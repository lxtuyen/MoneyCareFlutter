import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/utils/date_picker_util.dart';
import 'package:money_care/presentation/model/category_model.dart';
import 'package:money_care/presentation/model/transcation_model.dart';
import 'package:money_care/presentation/screens/transaction/widgets/input/amount_input.dart';
import 'package:money_care/presentation/screens/transaction/widgets/input/note_input.dart';
import 'package:money_care/presentation/screens/transaction/widgets/sheet/category_sheet.dart';

class Edit_Expense extends StatefulWidget {
  final TransactionModel item;

  const Edit_Expense({super.key, required this.item});

  @override
  State<Edit_Expense> createState() => _Edit_ExpenseState();
}

class _Edit_ExpenseState extends State<Edit_Expense> {
  late DateTime selectedDate;
  XFile? selectedImage;

  final picker = ImagePicker();

  final categories = const [
    CategoryModel(name: 'Cần thiết', percent: '55%', icon: Icons.shopping_bag),
    CategoryModel(name: 'Đào tạo', percent: '10%', icon: Icons.school),
    CategoryModel(name: 'Hưởng thụ', percent: '10%', icon: Icons.spa),
    CategoryModel(name: 'Tiết kiệm', percent: '10%', icon: Icons.savings),
    CategoryModel(name: 'Từ thiện', percent: '5%', icon: Icons.volunteer_activism),
  ];

  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.item.date;
    amountController.text = widget.item.amount;
    noteController.text = widget.item.subtitle ?? '';
    categoryController.text = widget.item.category?.name ?? '';
  }

  Future<void> pickImage(ImageSource source) async {
    Navigator.pop(context);
    final image = await picker.pickImage(source: source, imageQuality: 80);
    if (image != null) setState(() => selectedImage = image);
  }

  void showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: const Text("Chụp ảnh"),
              onTap: () => pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.primary),
              title: const Text("Chọn từ thư viện"),
              onTap: () => pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    final date = await pickSingleDate(context);
    if (date != null) setState(() => selectedDate = date);
  }

  void showCategorySheet() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CategorySheet(
        categories: categories,
        selectedCategoryInit: widget.item.category?.name,
      ),
    );

    if (selected != null) {
      setState(() => categoryController.text = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 160),
              child: Column(
                children: [
                  Container(
                    height: 165,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _BackButton(),
                          Text(
                            'Chỉnh sửa',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 22),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DatePicker(selectedDate: selectedDate, onTap: selectDate),
                        const SizedBox(height: 20),
                        AmountInput(
                          controller: amountController,
                          label: "Nhập số tiền",
                          hintText: "0 đ",
                        ),
                        const SizedBox(height: 20),
                        const Text("Phân loại", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        TextField(
                          controller: categoryController,
                          readOnly: true,
                          onTap: showCategorySheet,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                        const SizedBox(height: 20),
                        NoteInput(
                          controller: noteController,
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
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, -2))
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: showImagePickerSheet,
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderPrimary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: selectedImage == null
                            ? const Icon(Icons.image_outlined, color: Colors.grey)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(selectedImage!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size.fromHeight(55),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Cập nhật",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
    );
  }
}

class _DatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onTap;

  const _DatePicker({required this.selectedDate, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderPrimary),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, color: AppColors.primary),
                const SizedBox(width: 10),
                Text(DateFormat('EEEE, dd/MM/yy', 'vi').format(selectedDate)),
              ],
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
