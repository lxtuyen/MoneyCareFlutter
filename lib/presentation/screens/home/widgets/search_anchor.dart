import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/sizes.dart';
import 'package:money_care/presentation/screens/home/widgets/transaction_item.dart';

class SearchAnchorCustom extends StatefulWidget {
  const SearchAnchorCustom({super.key});

  @override
  State<SearchAnchorCustom> createState() => _SearchAnchorCustomState();
}

class _SearchAnchorCustomState extends State<SearchAnchorCustom> {
  final SearchController _searchController = SearchController();

  // 🧩 Dữ liệu giả test
  final List<Map<String, dynamic>> _searchResults = [
    {
      'id': '1',
      'title': 'Tiền siêu thị',
      'subtitle': 'Chi tiêu hằng ngày',
      'date': DateTime(2025, 10, 17),
      'amount': '250.000',
      'iconColor': Colors.purple,
    },
    {
      'id': '2',
      'title': 'Học tiếng anh',
      'subtitle': 'Đào tạo',
      'date': DateTime(2025, 10, 17),
      'amount': '250.000',
      'iconColor': Colors.lightBlue,
    },
    {
      'id': '3',
      'title': 'Tiền tiết kiệm',
      'subtitle': 'Tiết kiệm',
      'date': DateTime(2025, 10, 16),
      'amount': '250.000',
      'iconColor': Colors.pink,
    },
    {
      'id': '4',
      'title': 'Du lịch Mộc Châu',
      'subtitle': 'Hưởng thụ',
      'date': DateTime(2025, 10, 16),
      'amount': '250.000',
      'iconColor': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SearchAnchor.bar(
        barHintText: 'Nhập tên giao dịch',
        viewHintText: 'Tìm kiếm giao dịch',
        searchController: _searchController,
        suggestionsBuilder: (context, controller) {
          final query = controller.text.toLowerCase();
      
          final filtered = _searchResults.where((item) {
            return query.isEmpty ||
                item['title'].toString().toLowerCase().contains(query) ||
                item['subtitle'].toString().toLowerCase().contains(query);
          }).toList();
      
          if (filtered.isEmpty) {
            return [const Center(child: Text('Không tìm thấy giao dịch nào'))];
          }
      
          final Map<String, List<Map<String, dynamic>>> groupedByDate = {};
          for (var item in filtered) {
            final date = item['date'] as DateTime;
            final key = '${date.year}-${date.month}-${date.day}';
            groupedByDate.putIfAbsent(key, () => []).add(item);
          }
      
          final sortedKeys = groupedByDate.keys.toList()
            ..sort((a, b) {
              final da = DateTime.parse(a.replaceAll('-', ' ').replaceAll(' ', '-'));
              final db = DateTime.parse(b.replaceAll('-', ' ').replaceAll(' ', '-'));
              return db.compareTo(da);
            });
      
          final now = DateTime.now();
          final List<Widget> widgets = [];
      
          for (var key in sortedKeys) {
            final items = groupedByDate[key]!;
            final parts = key.split('-');
            final date = DateTime(
              int.parse(parts[0]),
              int.parse(parts[1]),
              int.parse(parts[2]),
            );
      
            String dateLabel;
            if (date.year == now.year &&
                date.month == now.month &&
                date.day == now.day) {
              dateLabel = 'Hôm nay';
            } else {
              dateLabel = '${date.day}/${date.month}/${date.year}';
            }
      
            widgets.add(
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  dateLabel,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.text5,
                    fontSize: AppSizes.fontSizeSm,
                  ),
                ),
              ),
            );
      
            for (var item in items) {
              widgets.add(Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TransactionItem(
                  title: item['title'],
                  subtitle: item['subtitle'],
                  date:
                      '${item['date'].day}/${item['date'].month}/${item['date'].year}',
                  iconColor: item['iconColor'],
                  amount: item['amount'],
                  onTap: () => context.push('/detail/${item['id']}'),
                ),
              ));
            }
          }
          return widgets;
        },
      ),
    );
  }
}
