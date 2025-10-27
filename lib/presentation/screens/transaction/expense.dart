import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:money_care/model/category_model.dart';
import 'package:money_care/presentation/widgets/dialog/success_dialog.dart';
import 'package:money_care/presentation/screens/transaction/widgets/transaction/transaction_form.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedValue;

final List<CategoryModel> categories = [
  const CategoryModel(name: 'Cần thiết', percent: '55%', icon: Icons.shopping_bag),
  const CategoryModel(name: 'Đào tạo', percent: '10%', icon: Icons.school),
  const CategoryModel(name: 'Hưởng thụ', percent: '10%', icon: Icons.spa),
  const CategoryModel(name: 'Tiết kiệm', percent: '10%', icon: Icons.savings),
  const CategoryModel(name: 'Từ thiện', percent: '5%', icon: Icons.volunteer_activism),
];


  final List<String> phanLoaiList = ['Thu nhập', 'Chi tiêu', 'Tiết kiệm'];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('vi', null);
  }

  @override
  Widget build(BuildContext context) {
    return TransactionForm(
      title: "Tiền Chi",
      showCategory: true,
      categoryList: categories,
      onSubmit: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => SuccessDialog(
                message: 'Lưu thành công',
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
