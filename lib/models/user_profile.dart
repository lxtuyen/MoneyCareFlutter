class UserProfileModel {
  final String firstName;
  final String lastName;
  final double? monthlyIncome;

  UserProfileModel({
    required this.firstName,
    required this.lastName,
    this.monthlyIncome,
  });

  String get fullName => '$firstName $lastName';

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        monthlyIncome: json['monthly_income']?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'monthly_income': monthlyIncome,
      };
}