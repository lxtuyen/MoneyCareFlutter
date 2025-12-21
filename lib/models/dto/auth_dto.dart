class AuthDto {
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;

  AuthDto({this.email, this.password, this.lastName, this.firstName});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
