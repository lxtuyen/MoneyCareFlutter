import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectLoginScreen extends StatefulWidget {
  const SelectLoginScreen({super.key});

  @override
  State<SelectLoginScreen> createState() => _SelectLoginScreenState();
}

class _SelectLoginScreenState extends State<SelectLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),

                Center(
                  child: Image.asset(
                    'assets/images/logo.jpg',
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 25),

                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    children: [TextSpan(text: 'Đăng nhập ')],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Vui lòng đăng nhập để sử dụng Money Care.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(134, 101, 101, 101),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),

                    ElevatedButton.icon(
                      onPressed: () {
                        context.push('/login');
                      },
                      icon: Image.asset(
                        'assets/images/google_logo.png',
                        width: 22,
                        height: 22,
                      ),
                      label: const Text(
                        'Đăng nhập với google',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: const Color.fromARGB(255, 180, 180, 180),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    ElevatedButton.icon(
                      onPressed: () {
                        context.push('/selectlogin');
                      },
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.white,
                        size: 22,
                      ),
                      label: const Text(
                        'Đăng nhập với Facebook',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: const Color(
                          0xFF1877F2,
                        ), // Xanh Facebook
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
