class UserUpdateDto {
  final String? role;
  final bool? isVip;

  UserUpdateDto({
    this.role,
    this.isVip,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'isVip': isVip,
    };
  }
}
