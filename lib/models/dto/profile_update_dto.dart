class ProfileUpdateDto {
  final String? firstName;
  final String? lastName;
  final int? monthlyIncome;

  ProfileUpdateDto({
    this.monthlyIncome,
    this.lastName,
    this.firstName,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'monthly_income': monthlyIncome
    };
  }
}
