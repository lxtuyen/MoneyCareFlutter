import 'package:money_care/models/category_model.dart';

class SavingFundModel {
  final int id;
  final String name;
  bool? isSelected;
  final List<CategoryModel> categories;

  SavingFundModel({
    required this.id,
    required this.name,
    required this.categories,
    this.isSelected
  });
  factory SavingFundModel.fromMap(Map<String, dynamic> json) {
    return SavingFundModel(
      id: json['id'],
      name: json['name'],
      isSelected: json['is_selected'],
      categories:
          json['categories'] != null
              ? List<CategoryModel>.from(
                json['categories'].map((x) => CategoryModel.fromJson(x)),
              )
              : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_selected': isSelected,
      'categories': categories.map((e) => e.toJson()).toList(),
    };
  }
}
