import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_care/core/constants/api_routes.dart';
import 'package:money_care/models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService api;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final GoogleSignIn _gmailSignIn;

  AuthService({required this.api}) {
    if (kIsWeb) {
      _gmailSignIn = GoogleSignIn(
        clientId:
            '41444230356-hppgcd9tefg26ejc5hiintor35ifs6vr.apps.googleusercontent.com',
        scopes: [
          'email',
          'profile',
          'https://www.googleapis.com/auth/gmail.readonly',
        ],
      );
    } else {
      _gmailSignIn = GoogleSignIn(
        serverClientId:
            '41444230356-hppgcd9tefg26ejc5hiintor35ifs6vr.apps.googleusercontent.com',
        scopes: [
          'email',
          'profile',
          'https://www.googleapis.com/auth/gmail.readonly',
        ],
      );
    }
  }

  Future<UserModel> loginWithGoogle() async {
    User? firebaseUser;

    if (kIsWeb) {
      final provider = GoogleAuthProvider();
      final cred = await FirebaseAuth.instance.signInWithPopup(provider);
      firebaseUser = cred.user;
    } else {
      final googleUser = await _gmailSignIn.signIn();
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

  Future<void> connectGmail() async {
    await _gmailSignIn.signOut();

    final account = await _gmailSignIn.signIn();
    print(account?.serverAuthCode);
    if (account == null) {
      throw Exception('User cancelled Gmail connect');
    }

    final serverAuthCode = account.serverAuthCode;

    if (serverAuthCode == null) {
      throw Exception('Missing server auth code');
    }

    await api.post<void>(
      ApiRoutes.googleLogin2,
      body: {'code': serverAuthCode},
    );

    Get.offAllNamed('/main');
  }
}
