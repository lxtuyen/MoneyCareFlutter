import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_care/controllers/saving_fund_controller.dart';
import 'package:money_care/controllers/transaction_controller.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/utils/Helper/helper_functions.dart';
import 'package:money_care/core/utils/validatiors/validation.dart';
import 'package:money_care/data/storage_service.dart';
import 'package:money_care/models/category_model.dart';
import 'package:money_care/models/dto/transaction_create_dto.dart';
import 'package:money_care/models/saving_fund_model.dart';
import 'package:money_care/models/user_model.dart';
import 'package:money_care/models/transaction_model.dart';
import 'package:money_care/presentation/screens/transaction/widgets/sheet/category_sheet.dart';

class TransactionForm extends StatefulWidget {
  final String title;
  final bool showCategory;
  final VoidCallback onSubmit;
  final TransactionModel? item;

  const TransactionForm({
    super.key,
    required this.title,
    this.showCategory = true,
    required this.onSubmit,
    this.item,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  int? selectedCategoryId;
  final TransactionController transactionController =
      Get.find<TransactionController>();
  final SavingFundController savingFundController =
      Get.find<SavingFundController>();

  late int userId;
  late SavingFundModel savingFunds;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('vi', null);
    initData();

    if (widget.item != null) {
      final item = widget.item!;

      selectedDate = item.transactionDate!;
      _amountController.text = item.amount.toString();
      _categoryController.text = item.category?.name ?? "";
      _noteController.text = item.note ?? "";
    }
  }

  Future<void> initData() async {
    Map<String, dynamic> userInfoJson = StorageService().getUserInfo()!;
    UserModel user = UserModel.fromJson(userInfoJson, '');
    savingFundController.loadFundById(user.savingFund!.id);
    setState(() {
      userId = user.id;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
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

  void _showCategorySheet(BuildContext context) async {
    final selected = await showModalBottomSheet<CategoryModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Obx(() {
          if (savingFundController.isLoading.value ||
              savingFundController.currentFund.value == null) {
            return const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final categories = savingFundController.currentFund.value!.categories;

          return CategorySheet(categories: categories);
        });
      },
    );

    if (selected != null) {
      setState(() {
        selectedCategoryId = selected.id;
        _categoryController.text = selected.name;
      });
    }
  }

  Future<void> _createTransaction() async {
    if (_formKey.currentState!.validate()) {
      try {
        final dto = TransactionCreateDto(
          amount: int.parse(_amountController.text),
          type: widget.showCategory ? "expense" : "income",
          note: _noteController.text.trim(),
          categoryId: selectedCategoryId,
          transactionDate: selectedDate,
          userId: userId,
        );
        await transactionController.createTransaction(dto);
        Get.back();
        AppHelperFunction.showSnackBar('Tạo giao dịch thành công');
      } catch (e) {
        AppHelperFunction.showSnackBar(e.toString());
      }
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
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Get.back();
                              } else {
                                Get.toNamed('/home');
                              }
                            },
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
                    child: Form(
                      key: _formKey,
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
                          TextFormField(
                            controller: _amountController,
                            decoration: InputDecoration(
                              labelText: "Số tiền",
                              hintText: "Nhập số tiền",
                              prefixIcon: const Icon(Icons.attach_money),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),

                            keyboardType: TextInputType.number,
                            validator:
                                (value) => AppValidator.validateAmount(value),
                          ),

                          if (widget.showCategory) ...[
                            const SizedBox(height: 20),
                            const Text(
                              'Phân loại',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            TextFormField(
                              controller: _categoryController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                hintText: 'Phân loại',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.keyboard_arrow_down),
                              ),
                              validator:
                                  (value) =>
                                      AppValidator.validateCategory(value),
                              onTap: () => _showCategorySheet(context),
                            ),
                          ],

                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _noteController,
                            decoration: InputDecoration(
                              labelText: "Ghi chú",
                              hintText: "Nhập ghi chú (không bắt buộc)",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            validator:
                                (value) => AppValidator.validateNote(value),
                          ),
                        ],
                      ),
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
                      child: Obx(() {
                        return ElevatedButton(
                          onPressed:
                              transactionController.isLoading.value
                                  ? null
                                  : _createTransaction,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50), // chiều cao
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child:
                              transactionController.isLoading.value
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    widget.item == null ? 'Tạo' : 'Cập nhật',
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                        );
                      }),
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
