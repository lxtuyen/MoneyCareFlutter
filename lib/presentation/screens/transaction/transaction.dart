import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIOSActionSheet(context);
    });
  }

  void _showIOSActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Lựa chọn',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.text4,
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã chọn: Tiền thu')),
              );
            },
            child: const Text(
              'Tiền Chi',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.text1,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã chọn: Tiền chi')),
              );
            },
            child: const Text(
              'Tiền Thu',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.text1,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Hủy bỏ',
            style: TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thu - Chi')),
      body: const Center(
        child: Text('Trang giao dịch mặc định'),
      ),
    );
  }
}
