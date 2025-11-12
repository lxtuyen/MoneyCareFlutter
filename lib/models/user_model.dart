import 'package:money_care/models/user_profile.dart';

class UserModel {
  final int id;
  final String email;
  final String role;
  final String accessToken;
  final UserProfileModel profile;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.profile,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String token) => UserModel(
        id: json['id'],
        email: json['email'],
        role: json['role'],
        accessToken: token,
        profile: UserProfileModel.fromJson(json['profile']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'role': role,
        'accessToken': accessToken,
        'profile': profile.toJson(),
      };
}