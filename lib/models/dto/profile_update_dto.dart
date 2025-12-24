class ProfileUpdateDto {
  final String? firstName;
  final String? lastName;
  final int? monthlyIncome;

  ProfileUpdateDto({
    this.firstName,
    this.lastName,
    this.monthlyIncome,
  });

  factory ProfileUpdateDto.fromJson(Map<String, dynamic> json) {
    return ProfileUpdateDto(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      monthlyIncome: json['monthly_income'] == null
          ? null
          : int.tryParse(json['monthly_income'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (monthlyIncome != null) {
      data['monthly_income'] = monthlyIncome;
    }

    return data;
  }
}
