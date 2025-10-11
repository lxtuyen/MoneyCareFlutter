import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NextIntroduceScreen extends StatefulWidget {
  const NextIntroduceScreen({super.key});

  @override
  State<NextIntroduceScreen> createState() => _NextIntroduceScreenState();
}

class _NextIntroduceScreenState extends State<NextIntroduceScreen> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context.go('/selectlogin');
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Center(
                child: Image.asset(
                  'assets/images/introduce_2.jpg',
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 40),

              // Tiêu đề
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(text: 'Làm chủ '),
                    TextSpan(
                      text: 'tài chính',
                      style: TextStyle(color: Color(0xFF2196F3)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                'Làm chủ tài chính - làm chủ cuộc sống.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.go('/introduce');
                    },
                    child: Container(
                      width: 10,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),

                  GestureDetector(
                    onTap: () {
                      context.go('/selectlogin');
                    },
                    child: Container(
                      width: 25,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    context.push('/selectlogin');
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 28,
                    ),
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
