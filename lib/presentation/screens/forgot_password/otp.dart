import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),

              // Tiêu đề
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  children: [TextSpan(text: 'Nhập mã OTP ')],
                ),
              ),

              const SizedBox(height: 10),
              const Text(
                'Nhập mã OTP để lấy lại mật khẩu.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(134, 101, 101, 101),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "- - - - - -",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.numbers),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Không nhận được mã ? Thử lại sau ',
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                    children: [
                      TextSpan(
                        text: '30s',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                // Xử lý gửi lại mã OTP
                              },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  context.push('/reset-password');
                },

                label: const Text(
                  'Xác nhận mã OTP',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),

                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: const Color(0xFF1877F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Nhớ mật khẩu? ',
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                    children: [
                      TextSpan(
                        text: 'Đăng nhập',
                        style: const TextStyle(
                          color: Colors.blue,
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
    );
  }
}
