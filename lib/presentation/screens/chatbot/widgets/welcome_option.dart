import 'package:flutter/material.dart';
import 'package:money_care/models/quick_option.dart';

class WelcomeOptions extends StatelessWidget {
  final List<QuickOption> options;
  final void Function(String template) onTapFill;
  final Future<void> Function(String template) onTapSend;

  const WelcomeOptions({
    required this.options,
    required this.onTapFill,
    required this.onTapSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(14),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Xin chào \nBạn có thể gõ hoặc nói theo cú pháp bên dưới:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  options.map((o) {
                    return ActionChip(
                      label: Text(o.title),
                      labelStyle: const TextStyle(color: Colors.blueAccent),
                      onPressed: () => onTapFill(o.template),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 14),
            const Text(
              'Ví dụ lệnh',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),

            ...options.map(
              (o) => Card(
                color: const Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(color: Colors.lightBlue),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        o.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        o.subtitle,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blueAccent,
                                side: const BorderSide(
                                  color: Colors.blueAccent,
                                ),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => onTapFill(o.template),
                              child: const Text('Dán mẫu'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Text(
              'Mẹo voice : bấm mic và nói giống ví dụ, ví dụ: "thêm chi tiêu 50 nghìn ăn sáng hôm nay".',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
