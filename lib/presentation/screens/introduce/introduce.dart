import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroduceScreen extends StatefulWidget {
  const IntroduceScreen({super.key});

  @override
  State<IntroduceScreen> createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
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
                      context.go('/nextintro');
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
                  'assets/images/introduce_1.jpg',
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
                    TextSpan(text: 'Quản lý '),
                    TextSpan(
                      text: 'thu chi',
                      style: TextStyle(color: Color(0xFF2196F3)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                'Quản lý thu chi chặt chẽ - tiết kiệm thời gian.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Container(
                    width: 25,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(width: 6),

                  GestureDetector(
                    onTap: () {
                      context.go('/nextintro');
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
                ],
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    context.go('/nextintro');
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
