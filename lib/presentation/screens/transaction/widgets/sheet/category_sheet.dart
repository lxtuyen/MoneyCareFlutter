import 'package:flutter/material.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/presentation/screens/transaction/widgets/category_item.dart';
import 'package:money_care/presentation/screens/transaction/widgets/sheet/edit_category_sheet.dart';

class CategorySheet extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CategorySheet({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Phân loại',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, thickness: 1, color: Colors.grey),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // TODO: xử lý thêm phân loại mới
                    },
                    icon: const Icon(Icons.add, size: 20, color: AppColors.text1),
                    label: const Text(
                      'Tạo phân loại mới',
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text1,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return EditCategorySheet(categories: categories);
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Chỉnh sửa',
                      style: TextStyle(
                        color: AppColors.buttonPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.5,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Text(
                'Danh sách phân loại',
                style: TextStyle(fontSize: 15.5),
              ),
              const SizedBox(height: 20),

              // Danh sách category
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: categories.map((item) {
                        return GestureDetector(
                          onTap: () => Navigator.pop(context, item['name']),
                          child: CategoryItem(
                            title: item['name'],
                            percent: item['percent'],
                            icon: item['icon'],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
