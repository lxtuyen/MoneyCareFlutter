import 'package:flutter/material.dart';

class AccountTypeSwitch extends StatelessWidget {
  final bool isVip;

  const AccountTypeSwitch({required this.isVip});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: isVip ? const Color(0xFF00E676) : const Color(0xFFE0E0E0),
      ),
      child: Align(
        alignment: isVip ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isVip ? const Color(0xFF00E676) : const Color(0xFFBDBDBD),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
