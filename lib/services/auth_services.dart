import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService api;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService({required this.api});

  Future<UserModel> loginWithGoogle() async {
    User? firebaseUser;
    if (kIsWeb) {
      final provider = GoogleAuthProvider();
      final cred = await FirebaseAuth.instance.signInWithPopup(provider);
      firebaseUser = cred.user;
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw Exception('Google sign in cancelled');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final cred = await _firebaseAuth.signInWithCredential(credential);
      firebaseUser = cred.user;
    }

    if (firebaseUser == null || firebaseUser.email == null) {
      throw Exception('Google login failed');
    }

    final res = await api.post<UserModel>(
      ApiRoutes.googleLogin,
      body: {
        'email': firebaseUser.email,
        'firstName': firebaseUser.displayName,
      },
      fromJsonT:
          (json) => UserModel.fromJson(json['user'], json['accessToken']),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<UserModel> login(String email, String password) async {
    final res = await api.post<UserModel>(
      ApiRoutes.login,
      body: {'email': email, 'password': password},
      fromJsonT:
          (json) => UserModel.fromJson(json['user'], json['accessToken']),
    );

    if (!res.success || res.data == null) {
      throw Exception(res.message);
    }

    return res.data!;
  }

  Future<String> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    final res = await api.post<void>(
      ApiRoutes.register,
      body: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
    );

    return res.message;
  }

  Future<String> forgotPassword(String email) async {
    final res = await api.post<void>(
      ApiRoutes.forgotPassword,
      body: {'email': email},
    );

    return res.message;
  }

  Future<String> verifyOtp(String email, String otp) async {
    final res = await api.post<void>(
      ApiRoutes.verifyOtp,
      body: {'email': email, 'otp': otp},
    );

    return res.message;
  }

  Future<String> resetPassword(String email, String newPassword) async {
    final res = await api.post<void>(
      ApiRoutes.resetPassword,
      body: {'email': email, 'newPassword': newPassword},
    );

    return res.message;
  }
}
