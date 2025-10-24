import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/presentation/widgets/choice_chip/choice_chips.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({
    super.key,
    required this.title,
    required this.items,
    required this.onApply,
    this.multiSelect = false,
  });

  final String title;
  final List<String> items;
  final bool multiSelect;
  final ValueChanged<List<String>> onApply;

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  final Set<String> _selectedItems = {};
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _pickDateRange(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      initialDateRange: startDate != null && endDate != null
          ? DateTimeRange(start: startDate!, end: endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });

      final formatted =
          "Tùy chỉnh: ${DateFormat('dd/MM/yyyy').format(startDate!)} - ${DateFormat('dd/MM/yyyy').format(endDate!)}";

      setState(() {
        if (widget.multiSelect) {
          // thêm (nếu đã có chuỗi tùy chỉnh cũ, xóa nó trước)
          _selectedItems.removeWhere((s) => s.startsWith("Tùy chỉnh"));
          _selectedItems.add(formatted);
        } else {
          // thay thế lựa chọn duy nhất bằng chuỗi tùy chỉnh
          _selectedItems
            ..clear()
            ..add(formatted);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: widget.items.map((item) {
          // Kiểm tra item có phải là phần "Tùy chỉnh" hay không
          final bool isCustomItem = item.toLowerCase().contains('tùy chỉnh');

          // Nếu đã có một chuỗi "Tùy chỉnh: ..." trong _selectedItems, hiển thị chuỗi đó thay cho item gốc
          final String customSelectedText =
              _selectedItems.firstWhere((s) => s.startsWith('Tùy chỉnh'), orElse: () => '');

          final String displayText = (isCustomItem && customSelectedText.isNotEmpty)
              ? customSelectedText
              : item;

          final bool isSelected = isCustomItem
              ? _selectedItems.any((s) => s.startsWith('Tùy chỉnh'))
              : _selectedItems.contains(item);

          return CustomChoiceChip(
            text: displayText,
            isSelected: isSelected,
            onSelected: (selected) async {
              if (isCustomItem) {
                // mở DateRangePicker khi nhấn vào "Tùy chỉnh..."
                await _pickDateRange(context);
              } else {
                setState(() {
                  if (widget.multiSelect) {
                    // toggle chọn nhiều
                    if (selected) {
                      _selectedItems.add(item);
                    } else {
                      _selectedItems.remove(item);
                    }
                  } else {
                    // chỉ chọn 1: clear rồi add (hoặc bỏ chọn nếu selected == false)
                    _selectedItems.clear();
                    if (selected) {
                      _selectedItems.add(item);
                    }
                  }
                });
              }
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Hủy",
            style: TextStyle(color: AppColors.text3),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onApply(_selectedItems.toList());
          },
          child: const Text(
            "Áp dụng",
            style: TextStyle(color: AppColors.text3),
          ),
        ),
      ],
    );
  }
}
