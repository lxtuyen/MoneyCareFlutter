import 'package:money_care/models/category_model.dart';

class SavingFundDto {
  final String? name;
  final List<CategoryModel>? categories;
  final int? id;

  SavingFundDto({this.name, this.categories, this.id});

  // Map<String, dynamic> toJsonCreate() {
  //   return {
  //     'name': name,
  //     'categories': categories!.map((e) => e.toJson()).toList(),
  //     'userId': id,
  //   };
  // }
  // Map<String, dynamic> toJsonUpdate() {
  //   return {
  //     'name': name,
  //     'categories': categories!.map((e) => e.toJson()).toList(),
  //   };
  // }
  Map<String, dynamic> toJsonCreate() {
  return {
    'name': name,
    'userId': id,
    'categories': categories!.map((c) => {
      'name': c.name,               // bắt buộc
      'percentage': c.percentage,   // bắt buộc
      'icon': c.icon,               // optional
    }).toList(),
  };
}


Map<String, dynamic> toJsonUpdate() {
  return {
    'name': name,
    'categories': categories!.map((c) => {
      if (c.id != null) 'id': c.id,
      'name': c.name,
      'percentage': c.percentage,
      'icon': c.icon,
    }).toList(),
  };
}

}
