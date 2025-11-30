import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:money_care/controllers/saving_fund_controller.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/utils/Helper/helper_functions.dart';
import 'package:money_care/core/utils/validatiors/validation.dart';
import 'package:money_care/data/storage_service.dart';
import 'package:money_care/models/category_model.dart';
import 'package:money_care/models/dto/saving_fund_dto.dart';
import 'package:money_care/models/user_model.dart';

class CreateSavingFund extends StatefulWidget {
  const CreateSavingFund({super.key});

  @override
  State<CreateSavingFund> createState() => _CreateSavingFundState();
}

class _CreateSavingFundState extends State<CreateSavingFund> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final SavingFundController _controller = Get.find<SavingFundController>();
  late int userId;

  @override
  void initState() {
    super.initState();
    initUserInfo();
  }

  Future<void> initUserInfo() async {
    Map<String, dynamic> userInfoJson = StorageService().getUserInfo()!;
    UserModel user = UserModel.fromJson(userInfoJson, '');
    setState(() {
      userId = user.id;
    });
  }

  final List<CategoryModel> _categories = [
    CategoryModel(icon: 'charity_icon', name: "Ăn uống"),
    CategoryModel(icon: 'pleasure_icon', name: "Mua sắm"),
    CategoryModel(icon: 'savings_icon', name: "Di chuyển"),

    CategoryModel(icon: 'essential_icon', name: "Hóa đơn"),
    CategoryModel(icon: 'education_icon', name: "Giáo dục"),
    CategoryModel(icon: 'freedom_icon', name: "Khác"),
  ];

  Future<void> _createSavingFund() async {
    if (_formKey.currentState!.validate()) {
      final int totalPercentage = _categories.fold(
        0,
        (sum, cat) => sum + cat.percentage,
      );

      if (totalPercentage != 100) {
        AppHelperFunction.showSnackBar(
          'Tổng phần trăm phải là 100%. Hiện tại là $totalPercentage%',
        );
        return;
      }
      try {
        final dto = SavingFundDto(
          categories: _categories,
          name: _nameController.text.trim(),
          id: userId,
        );
        await _controller.createFund(dto);

        Get.back();
        AppHelperFunction.showSnackBar('Tạo quỹ thành công');
      } catch (e) {
        AppHelperFunction.showSnackBar(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo quỹ tiết kiệm'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên quỹ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => AppValidator.validateName(value),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final cat = _categories[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'icons/${cat.icon}.svg',
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                cat.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                initialValue: cat.percentage.toString(),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  suffixText: '%',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    cat.percentage = int.tryParse(value) ?? 0;
                                  });
                                },
                                validator:
                                    (value) =>
                                        AppValidator.validatePercentage(value),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Obx(() {
                return ElevatedButton(
                  onPressed:
                      _controller.isLoadingFunds.value ? null : _createSavingFund,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child:
                      _controller.isLoadingFunds.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            'Tạo quỹ',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
  