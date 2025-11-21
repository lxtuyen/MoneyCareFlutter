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
      'firstName': firstName,
      'lastName': lastName,
      'monthlyIncome': monthlyIncome
    };
  }
}
