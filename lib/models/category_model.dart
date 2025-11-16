class CategoryModel {
  final int? id;
  final String name;
  int percentage;
  final String icon;

  CategoryModel({
    this.id,
    required this.name,
    this.percentage = 0,
    required this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      percentage: json['percentage'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'percentage': percentage, 'icon': icon};
  }
  

  Map<String, dynamic> toJsonCreate() {
    return {'name': name, 'percentage': percentage, 'icon': icon};
  }
}
