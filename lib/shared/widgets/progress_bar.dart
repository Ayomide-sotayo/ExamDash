import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0

  const CustomProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Small width as per design
      height: 6,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.gradientStart,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
