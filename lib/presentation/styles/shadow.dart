import 'package:flutter/cupertino.dart';
import 'package:money_care/core/constants/colors.dart';

class ShadowStyle {
  static final verticalShadow = BoxShadow(
    color: AppColors.text3.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );

    static final horizontalShadow = BoxShadow(
    color: AppColors.text3.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );
}