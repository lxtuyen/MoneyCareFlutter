import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:money_care/core/constants/colors.dart';
import 'package:money_care/core/constants/text_string.dart';
import 'package:money_care/core/utils/validatiors/validation.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
            
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1,
                      ),
                      children: [TextSpan(text: AppTexts.forgotPasswordTitle)],
                    ),
                  ),
            
                  const SizedBox(height: 10),
                  const Text(
                    AppTexts.forgotPasswordDescription,
                    style: TextStyle(fontSize: 15, color: AppColors.text4),
                  ),
                  const SizedBox(height: 20),
            
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: AppTexts.emailLabel,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => AppValidator.validateEmail(value),
                  ),
            
                const Spacer(),
            
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.push('/otp');
                      }
                    },
            
                    label: const Text(
                      AppTexts.getOtp,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
            
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: AppTexts.rememberPassword,
                        style: const TextStyle(
                          color: AppColors.text3,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: AppTexts.login,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    context.push('/login');
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
