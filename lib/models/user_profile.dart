class UserProfileModel {
  final String firstName;
  final String lastName;
  final int? monthlyIncome;

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
        monthlyIncome: json['monthly_income'],
      );

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'monthly_income': monthlyIncome,
  };

  UserProfileModel copyWith({
    String? firstName,
    String? lastName,
    int? monthlyIncome,
  }) {
    return UserProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
    );
  }
}
