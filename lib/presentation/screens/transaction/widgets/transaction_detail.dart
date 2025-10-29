import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/presentation/screens/home/widgets/transaction/transaction_item.dart';
import 'package:money_care/presentation/widgets/dialog/success_dialog.dart';
import 'package:money_care/presentation/widgets/dialog/warm_dialog.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({super.key, required this.isExpense});

  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Chi tiết tiền chi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            TransactionItem(
              onTap: () {},
              isShowDate: true,
              title: 'Du lịch Mộc Châu',
              subtitle: 'Hưởng thụ',
              date: 'Hôm nay',
              color: Colors.green,
              amount: '250.000',
              isShowDivider: false,
              isExpense: isExpense,
            ),

            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.text4,
                    size: 22,
                  ),
                  label: const Text(
                    "Chỉnh sửa",
                    style: TextStyle(
                      color: AppColors.text4,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: AppColors.secondaryNavyBlue,
                        width: 1,
                      ),
                    ),
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => WarningDialog(
                            message: "Bạn có chắc chắn muốn xóa giao dịch này?",
                            onCancel: () => Navigator.pop(context),
                            onConfirm: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder:
                                    (context) => SuccessDialog(
                                      message: "Xóa giao dịch thành công!",
                                      onBack: () => Navigator.pop(context),
                                      onCreateNew: () {},
                                      isShowButton: false,
                                    ),
                              );
                            },
                          ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.text4,
                    size: 22,
                  ),
                  label: const Text(
                    "Xóa",
                    style: TextStyle(
                      color: AppColors.text4,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: AppColors.secondaryNavyBlue,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
