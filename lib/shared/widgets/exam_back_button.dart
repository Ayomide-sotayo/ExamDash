import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ExamBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool onDarkBackground;
  final Color? iconColor;

  const ExamBackButton({
    super.key,
    this.onTap,
    this.onDarkBackground = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.maybePop(context),
      child: Container(
        width: 48,
        height: 37,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 123, 121, 121).withOpacity(onDarkBackground ? 0.12 : 0.06),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 123, 122, 122).withOpacity(onDarkBackground ? 0.04 : 0.02),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: onDarkBackground
                      ? Colors.white.withOpacity(0.08)
                      : Colors.black.withOpacity(0.08),
                  width: 1.2,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: onDarkBackground
                      ? [
                          Colors.white.withOpacity(0.22),
                          Colors.white.withOpacity(0.04),
                        ]
                      : [
                          Colors.white.withOpacity(0.85),
                          Colors.white.withOpacity(0.50),
                        ],
                  stops: const [0.0, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  // Subtle liquid/glass gloss reflection
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9999),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(onDarkBackground ? 0.15 : 0.25),
                            Colors.transparent,
                          ],
                          stops: const [0.3, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Icon
                  Center(
                    child: Icon(
                      Icons.chevron_left,
                      color: iconColor ?? AppColors.textPrimary,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
