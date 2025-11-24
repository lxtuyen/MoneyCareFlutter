import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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


  bool _isScanning = false;
  final ImagePicker _picker = ImagePicker();


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



  Future<void> _openScanOptions() async {
    if (_isScanning) return;

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Chụp hoá đơn'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Chọn từ thư viện'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (source == null) return;
    await _scanBill(source);
  }

  // Quét hoá đơn -> call API -> auto-fill form
  Future<void> _scanBill(ImageSource source) async {
    final image = await _picker.pickImage(source: source, imageQuality: 80);
    if (image == null) return;

    setState(() => _isScanning = true);

    try {
      final token = StorageService().getToken();

      final uri = Uri.parse('http://localhost:3000/receipt/scan');

      final request = http.MultipartRequest('POST', uri);

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      final bytes = await image.readAsBytes();
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: image.name,
      );
      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body);
        final data = (body['data'] ?? body) as Map<String, dynamic>;

        final int? totalAmount = data['total_amount'];
        final String? dateStr = data['date'];
        final int? categoryId = data['category_id'];
        final String? categoryName = data['category_name'];
        final String? merchantName = data['merchant_name'];

        setState(() {
          if (totalAmount != null) {
            _amountController.text = totalAmount.toString();
          }

          if (dateStr != null) {
            try {
              selectedDate = DateTime.parse(dateStr);
            } catch (_) {}
          }

          if (widget.showCategory && categoryName != null) {
            final categories =
                savingFundController.currentFund.value?.categories ?? [];

            final matched = categories.firstWhere(
              (c) =>
                  c.name.toLowerCase().trim() ==
                  categoryName.toLowerCase().trim(),
              orElse:
                  () => CategoryModel(
                    id: -1,
                    name: "",
                    icon: "default.png", // hoặc "" nếu bạn dùng string rỗng
                  ),
            );

            if (matched.id != -1) {
              selectedCategoryId = matched.id;
              _categoryController.text = matched.name;
            }
          }

          if (merchantName != null && merchantName.trim().isNotEmpty) {
            if (_noteController.text.trim().isEmpty) {
              _noteController.text = merchantName;
            } else if (!_noteController.text.contains(merchantName)) {
              _noteController.text = '${_noteController.text} · $merchantName';
            }
          }
        });

        AppHelperFunction.showSnackBar(
          'Đã quét hoá đơn, kiểm tra lại thông tin trước khi lưu nhé!',
        );
      } else {
        AppHelperFunction.showSnackBar(
          'Quét hoá đơn thất bại (${response.statusCode})',
        );
      }
    } catch (e) {
      AppHelperFunction.showSnackBar('Lỗi quét hoá đơn: $e');
    } finally {
      if (mounted) {
        setState(() => _isScanning = false);
      }
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
                        children: [
                          // Back
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

                          // Title ở giữa
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          // Nút Scan bill bên phải
                          TextButton.icon(
                            onPressed: _isScanning ? null : _openScanOptions,
                            icon:
                                _isScanning
                                    ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                    : const Icon(
                                      Icons.document_scanner_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                            label: const Text(
                              'Scan bill',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ----------- FORM -------------
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ngày giao dịch
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

                          // Số tiền + icon scan ở bên phải (tuỳ chọn)
                          TextFormField(
                            controller: _amountController,
                            decoration: InputDecoration(
                              labelText: "Số tiền",
                              hintText: "Nhập số tiền",
                              prefixIcon: const Icon(Icons.attach_money),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.document_scanner_outlined,
                                ),
                                tooltip: 'Quét hoá đơn',
                                onPressed:
                                    _isScanning ? null : _openScanOptions,
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

                          // Ghi chú
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

            // --------- BUTTON BOTTOM ----------
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
                    // Nút scan bill nhanh ở dưới (dùng chung logic)
                    GestureDetector(
                      onTap: _isScanning ? null : _openScanOptions,
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderPrimary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            _isScanning
                                ? const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Icon(
                                  Icons.document_scanner_outlined,
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
