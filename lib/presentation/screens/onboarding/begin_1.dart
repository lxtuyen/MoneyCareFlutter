import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Begin1Screen extends StatefulWidget {
  const Begin1Screen({super.key});

  @override
  State<Begin1Screen> createState() => _Begin1ScreenState();
}

class _Begin1ScreenState extends State<Begin1Screen> {
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
                  'assets/images/begin_2.png',
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 40),

             
              const Text(
                'Chúng tôi đưa ra một vài quỹ tiết kiệm được các chuyên gia tư vấn.\n Quy tắc 6 chiếc lọ là một phương pháp quản lý chi tiêu được sử dụng phổ biến trên thế giới.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(136, 96, 96, 96),
                  height: 1.4,
                ),
              ),
              const Text(
                'Và bạn hoàn toàn có thể tự tạo quỹ tiết kiệm riêng theo nhu cầu của bản thân!',
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
                  context.push('/');
                },

                label: const Text(
                  'Tiếp tục',
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
