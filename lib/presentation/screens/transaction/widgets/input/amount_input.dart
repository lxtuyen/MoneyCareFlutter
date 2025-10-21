import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_care/core/constants/colors.dart';

class AmountInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final void Function(String)? onChanged;

  const AmountInput({
    super.key,
    required this.controller,
    this.label = 'Nhập số tiền',
    this.hintText = '0 đ',
    this.onChanged,
  });

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  void _formatCurrency(String value) {
    String digits = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) {
      widget.controller.text = '';
      return;
    }

    final formatter = NumberFormat('#,###', 'vi_VN');
    final newValue = formatter.format(int.parse(digits));
    widget.controller.value = TextEditingValue(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length),
    );

    if (widget.onChanged != null) {
      widget.onChanged!(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          onChanged: _formatCurrency,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.borderPrimary,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.borderPrimary,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
