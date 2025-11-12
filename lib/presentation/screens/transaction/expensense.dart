import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_care/presentation/screens/transaction/widgets/notification.dart';
import 'package:money_care/presentation/screens/transaction/widgets/transaction/transaction_form.dart';

class ExpensenseHomescreen extends StatefulWidget {
  const ExpensenseHomescreen({super.key});

  @override
  State<ExpensenseHomescreen> createState() => _ExpensenseHomescreenState();
}

class _ExpensenseHomescreenState extends State<ExpensenseHomescreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TransactionForm(
      title: "Tiền Chi",
      showCategory: true,
      onSubmit: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => SuccessNotification(
                message: 'Lưu thành công',
                onBack: () {
                  Get.back();
                },
                onCreateNew: () {
                  Get.back();
                },
              ),
        );
      },
    );
  }
}
