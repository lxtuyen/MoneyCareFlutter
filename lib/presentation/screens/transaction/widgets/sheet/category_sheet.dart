import 'package:flutter/material.dart';
import 'package:money_care/model/category.dart';
import 'package:money_care/presentation/screens/transaction/widgets/category_item.dart';

class CategorySheet extends StatefulWidget {
final List<CategoryModel> categories;
  final String? selectedCategoryInit;

  const CategorySheet({
    super.key,
    required this.categories,
        this.selectedCategoryInit,

  });

  @override
  State<CategorySheet> createState() => _CategorySheetState();
}

class _CategorySheetState extends State<CategorySheet> {
    String? selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selectedCategoryInit;
  }

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
              const Text('Phân loại',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widget.categories.map((item) {
                      final isSelected = selectedCategory == item.name;

                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedCategory = item.name);
                          Navigator.pop(context, item.name);
                        },
                        child: CategoryItem(
                          title: item.name,
                          percentage: item.percentage,
                          //icon: item.icon,
                          isSelected: isSelected,
                        ),
                      );
                    }).toList(),
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