import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BeginScreen extends StatefulWidget {
  const BeginScreen({super.key});

  @override
  State<BeginScreen> createState() => _BeginScreenState();
}

class _BeginScreenState extends State<BeginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Ảnh minh họa
              Center(
                child: Image.asset(
                  'assets/images/begin_1.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 40),

              // Tiêu đề
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(text: 'Chào mừng bạn \nđến với '),
                    TextSpan(
                      text: 'Money Care',
                      style: TextStyle(color: Color(0xFF2196F3)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Chúng tôi đem đến giải pháp giúp bạn \nquản lý chi tiêu cực kỳ dễ dàng \nvà hiệu quả.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(136, 96, 96, 96),
                  height: 1.4,
                ),
              ),

              const Spacer(),

              const SizedBox(height: 20),

              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  context.push('/begin1');
                },

                label: const Text(
                  'Bắt đầu',
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
            ],
          ),
        ),
      ),
    );
  }
}
