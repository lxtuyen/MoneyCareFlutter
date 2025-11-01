import 'package:flutter/material.dart';
import 'package:money_care/presentation/widgets/dialog/success_dialog.dart';
import 'package:money_care/presentation/screens/transaction/widgets/transaction/transaction_form.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}
class _IncomeScreenState extends State<IncomeScreen> {
  @override
  Widget build(BuildContext context) {
    return TransactionForm(
      title: "Tiền Thu",
      showCategory: false,
      onSubmit: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => SuccessDialog(
                message: 'Giao dịch đã được lưu thành công',
                onBack: () {
                  Navigator.pop(context);
                },
                onCreateNew: () {
                  Navigator.pop(context);
                },
                isShowButton: true,
              ),
        );
      },
    );
  }
}
