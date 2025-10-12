import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/icon_string.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/presentation/screens/home/widgets/transaction_item.dart';

class TransactionSection extends StatefulWidget {
  const TransactionSection({super.key});

  @override
  State<TransactionSection> createState() => _TransactionSectionState();
}

class _TransactionSectionState extends State<TransactionSection> {
  bool isExpense = true;

  final transactions = [
    {
      "iconColor": Colors.purple,
      "title": "Tiền siêu thị",
      "subtitle": "Chi tiêu hằng ngày",
      "date": "03/06/23",
      "amount": "250.000",
      "type": "expense", // 👈 thêm loại
    },
    {
      "iconColor": Colors.lightBlue,
      "title": "Tiền cà phê",
      "subtitle": "Giải trí",
      "date": "04/06/23",
      "amount": "80.000",
      "type": "expense",
    },
    {
      "iconColor": Colors.green,
      "title": "Lương tháng 6",
      "subtitle": "Công ty ABC",
      "date": "01/06/23",
      "amount": "10.000.000",
      "type": "income",
    },
    {
      "iconColor": Colors.orange,
      "title": "Tiền điện nước",
      "subtitle": "Chi tiêu hằng ngày",
      "date": "02/06/23",
      "amount": "1.200.000",
      "type": "expense",
    },
    {
      "iconColor": Colors.red,
      "title": "Bán đồ cũ",
      "subtitle": "Đồ dùng cá nhân",
      "date": "05/06/23",
      "amount": "500.000",
      "type": "income",
    },
  ];

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundPrimary,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            ),
            child: Row(
              children: [
                _buildTab("Chi", isExpense),
                _buildTab("Thu", !isExpense),
              ],
            ),
          ),
      
          const SizedBox(height: AppSizes.defaultSpace),
      
          if (transactions.isEmpty)
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    AppIcons.emptyFolder,
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  const Text(
                    'Không có giao dịch nào gần đây',
                    style: TextStyle(fontSize: 16, color: AppColors.text5),
                  ),
                ],
              ),
            )
          else
            ...transactions.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TransactionItem(
                  title: item["title"] as String,
                  amount: item["amount"] as String,
                  iconColor: item["iconColor"] as Color,
                  subtitle: item["subtitle"] as String,
                  date: item["date"] as String,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Expanded _buildTab(String label, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isExpense = (label == "Chi")),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
