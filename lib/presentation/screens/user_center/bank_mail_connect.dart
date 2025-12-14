import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/utils/Helper/helper_functions.dart';

class BankMailConnectScreen extends StatefulWidget {
  const BankMailConnectScreen({super.key});

  @override
  State<BankMailConnectScreen> createState() => _BankMailConnectScreenState();
}

class _BankMailConnectScreenState extends State<BankMailConnectScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;

  @override
  void dispose() {
    bankNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> onConnectBankMail() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final dto = {
        "bankName": bankNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text,
      };

      await Future.delayed(const Duration(seconds: 1));

      AppHelperFunction.showSnackBar("Kết nối email ngân hàng thành công");
      Get.back();
    } catch (e) {
      AppHelperFunction.showSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kết nối email ngân hàng")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),

                  const Text(
                    "Thông tin email ngân hàng",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text1,
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Bank name
                  TextFormField(
                    controller: bankNameController,
                    decoration: const InputDecoration(
                      labelText: "Tên ngân hàng",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? "Vui lòng nhập tên ngân hàng" : null,
                  ),
                  const SizedBox(height: 16),

                  /// Email
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email ngân hàng",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Vui lòng nhập email";
                      }
                      if (!GetUtils.isEmail(v)) {
                        return "Email không hợp lệ";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  /// Password
                  Obx(() {
                    return TextFormField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible.value,
                      decoration: InputDecoration(
                        labelText: "Mật khẩu email",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () =>
                              isPasswordVisible.value = !isPasswordVisible.value,
                        ),
                      ),
                      validator: (v) =>
                          v == null || v.length < 6
                              ? "Mật khẩu tối thiểu 6 ký tự"
                              : null,
                    );
                  }),
                  const SizedBox(height: 24),

                  /// Submit button
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading.value ? null : onConnectBankMail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                "Kết nối",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
