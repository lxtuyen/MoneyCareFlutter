import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/utils/date_picker_util.dart';
import 'package:money_care/model/category_model.dart';
import 'package:money_care/presentation/screens/transaction/widgets/input/amount_input.dart';
import 'package:money_care/presentation/screens/transaction/widgets/input/note_input.dart';
import 'package:money_care/presentation/screens/transaction/widgets/sheet/category_sheet.dart';

class TransactionForm extends StatefulWidget {
  final String title;
  final bool showCategory;
  final List<CategoryModel>? categoryList; 
  final VoidCallback onSubmit;

  const TransactionForm({
    super.key,
    required this.title,
    this.showCategory = true,
    this.categoryList,
    required this.onSubmit
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('vi', null);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
  }
  

  Future<void> _selectDate() async {
    final picked = await pickSingleDate(context);
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  void _showCategorySheet(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
      
          (context) => CategorySheet(categories: widget.categoryList ?? []),
    );

    if (selected != null) {
      setState(() {
        _categoryController.text = selected;
      });
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
                  // Header
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),

                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 22),
                        ],
                      ),
                    ),
                  ),

                  
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _selectDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.borderPrimary,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        const SizedBox(height: 20),

                        AmountInput(
                          controller: _amountController,
                          label: 'Nhập số tiền',
                          hintText: '0 đ',
                          onChanged: (value) {},
                        ),

                        if (widget.showCategory) ...[
                          const SizedBox(height: 20),
                          const Text(
                            'Phân loại',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: _categoryController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: 'Phân loại',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                            ),
                            onTap: () => _showCategorySheet(context),
                          ),
                        ],

                        const SizedBox(height: 20),
                        NoteInput(
                          controller: _noteController,
                          label: 'Ghi chú',
                          hintText: 'Nhập ghi chú...',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Thanh dưới cùng
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderPrimary),
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
                          ),
                          onPressed: widget.onSubmit,
                          child: const Text(
                            'Cập nhật',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
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
