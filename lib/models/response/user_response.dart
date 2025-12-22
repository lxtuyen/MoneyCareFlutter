class UserResponse {
  final int id;
  final String email;
  final String role;
  final bool isVip;

  UserResponse({
    required this.id,
    required this.email,
    required this.role,
    required this.isVip,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      UserResponse(
        id: json['id'],
        email: json['email'],
        role: json['role'],
        isVip: json['isVip'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'role': role,
    'isVip': isVip,
  };
}
